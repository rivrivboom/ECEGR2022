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

	SIGNAL carry : std_logic;
	SIGNAL addsub_out : std_logic_vector(31 DOWNTO 0);
	SIGNAL shift_out : std_logic_vector(31 DOWNTO 0);

	
	SIGNAL output_reg: std_logic_vector(31 DOWNTO 0);

	--SIGNAL operation_select :STD_LOGIC;
	
begin
--orignal slow breakdown to make this work 
--	WITH ALUCtrl SELECT
	--operation_select <= '0' WHEN "00000", --ADD
	--	'1' WHEN "00001", --SUB
	--	'0' WHEN "00010", --ADDI
--		'0' WHEN "00011", --AND
		--'0' WHEN "00100", --ANDI
	--	'0' WHEN "00101", --OR
	--	'0' WHEN "00110", --ORI
	--	'0' WHEN "00111", --sll
	--	'0' WHEN "01000", --slli
	--	'1' WHEN "01001", -- srl
	--	'1' WHEN "01110",		 --srli
	--	'1' WHEN OTHERS;
	
--now simplified
	A0:adder_subtracter PORT MAP (DataIn1, DataIn2, ALUCtrl(1), addsub_out, carry);
	--Sll, SLLI, SRL, SRLI
	A3:shift_register PORT MAP(DataIn1, ALUCtrl(1), DataIn2(4 Downto 0), shift_out);
	
	WITH ALUCtrl(4 downto 2) SELECT
	output_reg <= addsub_out WHEN "000", --ADD
		--addsub_out WHEN "00001", --SUB
		--addsub_out WHEN "00010", --ADDI
		(DataIn1 AND DataIn2) WHEN "010", --AND
		--(DataIn1 AND DataIn2) WHEN "00100", --ANDI
		(DataIn1 OR DataIn2) WHEN "011", --OR
		--(DataIn1 OR DataIn2) WHEN "00110", --ORI
		shift_out WHEN "001", --SLL
		--shift_out WHEN "01000", --SLLI
		--shift_out WHEN "01001", --SRL
		--shift_out WHEN "01110", --SRLI
		DataIn2 WHEN OTHERS;
	
	Zero <= '1' WHEN output_reg = X"0000" ELSE '0';

	ALUResult <= output_reg;

	

end architecture ALU_Arch;





