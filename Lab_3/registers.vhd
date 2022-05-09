--------------------------------------------------------------------------------
--
-- LAB #3
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	bits8: for i in 7 downto 0 generate
		biti: bitstorage port map(datain(i), enout, writein, dataout(i));
	end generate;
end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
	     		enout:  in std_logic;
	     		writein: in std_logic;
	     		dataout: out std_logic_vector(7 downto 0));
	end component;
	signal enableM: std_logic_vector(2 downto 0);
	signal writinM: std_logic_vector(2 downto 0);
	signal enableoutS: std_logic_vector(3 downto 0);
	signal writinS: std_logic_vector(3 downto 0);
	-- hint: you'll want to put register8 as a component here 
	-- so you can use it below
begin
	enableM <= enout32 & enout16 & enout8;
	writinM <= writein32 & writein16 & writein8;

	with enableM select
		enableoutS <= "1110" when "110",
			"1100" when "101",
			"0000" when "011",
			"1111" when others;
	with writinM select
		writinS <= "0001" when "001",
			"0011" when "010",
			"1111" when "100",
			"0000" when others;

	reg32: register8 PORT MAP (datain(31 downto 24), enableoutS(3), writinS(3), dataout(31 downto 24));
	reg24: register8 PORT MAP (datain(23 downto 16), enableoutS(2), writinS(2), dataout(23 downto 16));
	reg16: register8 PORT MAP (datain(15 downto 8), enableoutS(1), writinS(1), dataout(15 downto 8));
	regB: register8 PORT MAP (datain(7 downto 0), enableoutS(0), writinS(0), dataout(7 downto 0));

	
end architecture biggermem;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic;
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
	component fulladder
	port (a: in std_logic;
		b: in std_logic;
		cin: in std_logic;
		sum: out std_logic;
		carry: out std_logic
		);
	end component;
	signal temp: std_logic_vector(31 downto 0);
	signal C: std_logic_vector(32 downto 0);
begin
	C(0) <= add_sub;
	co <= C(32);

	with add_sub select
		temp <= datain_b when'0', 
			not datain_b when others;
	adder0: fulladder PORT MAP (datain_a(0), temp(0), C(0), dataout(0), C(1));
	Adders: for i in 31 downto 1 generate
	adder1: fulladder PORT MAP (datain_a(i), temp(i), C(i), dataout(i), C(i+1));
	end generate;

end architecture calc;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	
begin
	with dir & shamt (1 downto 0) select
		dataout <= datain(30 downto 0) & '0' when "001",
			'0' & datain(31 downto 1) when "101",
			datain(29 downto 0) & "00" when "010",
			"00" & datain(31 downto 2) when "110",
			datain(28 downto 0) & "000" when "011",
			"000" & datain(31downto 3) when "111",
			datain when others;
end architecture shifter;



