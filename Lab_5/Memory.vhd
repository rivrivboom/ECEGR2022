--------------------------------------------------------------------------------
--
-- LAB #5 - Memory and Register Bank
--
--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   signal i_ram : ram_type;

begin

  RamProc: process(Clock, Reset, OE, WE, Address) is

  begin
    if Reset = '1' then
      for i in 0 to 127 loop   
          i_ram(i) <= X"00000000";
      end loop;
    end if;

    if falling_edge(Clock) and WE = '1' and (to_integer(unsigned(Address(7 downto 0))) >= 0) and 
		(to_integer(unsigned(Address)) <= 127) then
		i_ram(to_integer(unsigned(Address(7 downto 0)))) <= DataIn;
	-- Add code to write data to RAM
	-- Use to_integer(unsigned(Address)) to index the i_ram array
	
	
    end if;
    	if(OE = '0') and (to_integer(unsigned(Address)) < 127) and (to_integer(unsigned(Address)) >= 0) then
		DataOut <= i_ram(to_integer(unsigned(Address(7 downto 0))));
	else
		DataOut <= (others => 'Z');
	end if;

	-- Rest of the RAM implementation

  end process RamProc;

end staticRAM;	


--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture remember of Registers is
	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;
	
	signal write_In : std_logic_vector (7 downto 0);
	signal x0_out: std_logic_vector(31 downto 0);
	type dataArray is Array(7 downto 0) of std_logic_vector(31 downto 0);
	signal regData: dataArray;
	
begin
	write_In <= "00000001" when WriteReg = "01010" and WriteCmd = '1' else
		"00000010" when WriteReg = "01011" and WriteCmd = '1' else
		"00000100" when WriteReg = "01100" and WriteCmd = '1' else
		"00001000" when WriteReg = "01101" and WriteCmd = '1' else
		"00010000" when WriteReg = "01110" and WriteCmd = '1' else
		"00100000" when WriteReg = "01111" and WriteCmd = '1' else
		"01000000" when WriteReg = "10000" and WriteCmd = '1' else
		"10000000" when WriteReg = "10001" and WriteCmd = '1' else
		"00000000" ;

 	RegOrg: for i in 7 downto 0 generate
		Ai: register32 port map (WriteData, '0', '1', '1', write_In(i), '0', '0',  regData(i));
	end generate;
		--x0 : register32 port map(WriteData, '0', '0', '0', "00000000", '0', '0', x0_out);
	
	
	with ReadReg1 select
		ReadData1 <= regData(0) when "01010",
			regData(1) when "01011",
			regData(2) when "01100",
			regData(3) when "01101",
			regData(4) when "01110",
			regData(5) when "01111",
			regData(6) when "10000",
			regData(7) when "10001",
			(others => '0' ) when "00000",
			(others => 'Z') when others;

	with ReadReg2 select
		ReadData2 <= regData(0) when "01010",
			regData(1) when "01011",
			regData(2) when "01100",
			regData(3) when "01101",
			regData(4) when "01110",
			regData(5) when "01111",
			regData(6) when "10000",
			regData(7) when "10001",
			(others => '0' ) when "00000",
			(others => 'Z') when others;

end remember;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
