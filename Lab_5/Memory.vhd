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
	
SIGNAL regWrite: std_logic_vector(31 downto 1);
	TYPE dataArray is Array(31 downto 1) of std_logic_vector(31 downto 0);
	SIGNAL regData: dataArray := (OTHERS=>(OTHERS=>'0'));
begin

	regWrite <= (1 => '1', OTHERS => '0') WHEN WriteReg = "00001" AND WriteCmd = '1' ELSE
			(2 => '1', OTHERS => '0') WHEN WriteReg = "00010" AND WriteCmd = '1' ELSE
			(3 => '1', OTHERS => '0') WHEN WriteReg = "00011" AND WriteCmd = '1' ELSE
			(4 => '1', OTHERS => '0') WHEN WriteReg = "00100" AND WriteCmd = '1' ELSE
			(5 => '1', OTHERS => '0') WHEN WriteReg = "00101" AND WriteCmd = '1' ELSE
			(6 => '1', OTHERS => '0') WHEN WriteReg = "00110" AND WriteCmd = '1' ELSE
			(7 => '1', OTHERS => '0') WHEN WriteReg = "00111" AND WriteCmd = '1' ELSE
			(8 => '1', OTHERS => '0') WHEN WriteReg = "01000" AND WriteCmd = '1' ELSE
			(9 => '1', OTHERS => '0') WHEN WriteReg = "01001" AND WriteCmd = '1' ELSE
		    (10 => '1', OTHERS => '0') WHEN WriteReg ="01010" AND WriteCmd = '1' ELSE
		    (11 => '1', OTHERS => '0') WHEN WriteReg ="01011" AND WriteCmd = '1' ELSE
	  	    (12 => '1', OTHERS => '0') WHEN WriteReg ="01100" AND WriteCmd = '1' ELSE
		    (13 => '1', OTHERS => '0') WHEN WriteReg ="01101" AND WriteCmd = '1' ELSE
		    (14 => '1', OTHERS => '0') WHEN WriteReg = "01110" AND WriteCmd = '1' ELSE
		    (15 => '1', OTHERS => '0') WHEN WriteReg ="01111" AND WriteCmd = '1' ELSE
		    (16 => '1', OTHERS => '0') WHEN WriteReg ="10000" AND WriteCmd = '1' ELSE
		(17 => '1', OTHERS => '0') WHEN WriteReg ="10001" AND WriteCmd = '1' ELSE
		(18 => '1', OTHERS => '0') WHEN WriteReg ="10010" AND WriteCmd = '1' ELSE


		    (OTHERS => '0');
	
	
	RegisterMap: FOR i in 31 downto 1 GENERATE
		xi: register32 PORT MAP(WriteData, '0', '1', '1', regWrite(i), '0', '0', regData(i));
	END GENERATE;
		
	WITH ReadReg1 SELECT
		ReadData1 <= regData(1) WHEN "00001",
				regData(2) WHEN "00010",
				regData(3) WHEN "00011",
				regData(4) WHEN "00100",
				regData(5) WHEN "00101",
				regData(6) WHEN "00110",
				regData(7) WHEN "00111",
				regData(8) WHEN "01000",
				regData(9) WHEN "01001",
				regData(10) WHEN "01010",
				regData(11) WHEN "01011",
				regData(12) WHEN "01100",
				regData(13) WHEN "01101",
				regData(14) WHEN "01110",
				regData(15) WHEN "01111",
				regData(16) WHEN "10000",
				regData(17) WHEN "10001",
				regData(18) WHEN "10010",
			

			    (OTHERS => '0') WHEN OTHERS;

	WITH ReadReg2 SELECT
		ReadData2 <= regData(1) WHEN "00001",
					regData(2) WHEN "00010",
					regData(3) WHEN "00011",
					regData(4) WHEN "00100",
					regData(5) WHEN "00101",
					regData(6) WHEN "00110",
					regData(7) WHEN "00111",
					regData(8) WHEN "01000",
					regData(9) WHEN "01001",
					regData(10) WHEN "01010",
					regData(11) WHEN "01011",
					regData(12) WHEN "01100",
					regData(13) WHEN "01101",
					regData(14) WHEN "01110",
					regData(15) WHEN "01111",
					regData(16) WHEN "10000",
					regData(17) WHEN "10001",
					regData(18) WHEN "10010",

					(OTHERS => '0') WHEN OTHERS;

end remember;



----------------------------------------------------------------------------------------------------------------------------------------------------------------
