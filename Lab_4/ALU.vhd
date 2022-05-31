--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		ALUCtrl: in std_logic_vector(4 downto 0);
		Zero: out std_logic;
		ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
	-- ALU components	
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component adder_subtracter;

	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic;
			shamt:	in std_logic_vector(4 downto 0);
			dataout: out std_logic_vector(31 downto 0));
	end component shift_register;
	SIGNAL op1,op2, op3, op4, op5, op6, op7: std_logic_vector(31 downto 0);


begin



	-- Add ALU VHDL implementation here
	
	add: adder_subtracter port map (DataIn1, DataIn2, '0',op1, Zero);
	addi: adder_subtracter port map (DataIn1, DataIn2, '0',op2, Zero);
	sub: adder_subtracter port map (DataIn1, DataIn2, '1',op3, Zero);
	sllr: shift_register port map (DataIn1, '0', DataIn2( 4 downto 0),op4);
	slli: shift_register port map (DataIn1, '0',DataIn2( 4 downto 0),op5);
	srlr: shift_register port map (DataIn1,  '1',DataIn2( 4 downto 0),op6);
	srli: shift_register port map (DataIn1, '1',DataIn2( 4 downto 0),op7);

	 with ALUCtrl select
		ALUResult <= op1 when "00000",op2 when "00001", op3 when "00010",
		DataIn1 or Datain2 when "00011", DataIn1 or Datain2 when "00100", 
		DataIn1 and Datain2 when "00101", DataIn1 and Datain2 when "00110",
		op4 when "00111", op5 when "01000", op6 when "01001", op7 when "01010",
		X"00000000" when others;
  
end architecture ALU_Arch;

