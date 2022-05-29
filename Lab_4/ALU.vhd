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
	SIGNAL addsub_out, or_out, and_out, shift_out, immidiate_val: std_logic_vector(31 downto 0);
	SIGNAL carry: std_logic;


begin
	ADD_SUB: adder_subtracter PORT MAP(DataIn1, DataIn2, ALUCtrl(2), addsub_out, carry);
	SHIFT: shift_register PORT MAP(DataIn1, ALUCtrl(2), DataIn2(4 downto 0), shift_out);
	or_out <= DataIn1 or DataIn2;
	and_out <= DataIn1 and DataIn2;

	-- Add ALU VHDL implementation here

	immidiate_val <= addsub_out when ALUCtrl(3 downto 0) = "0010" or ALUCtrl (3 downto 0) = "0110" else
			shift_out when ALUCtrl(3 downto 0) = "0011" or ALUCtrl(3 downto 0) = "0100" else
			and_out when ALUCtrl(3 downto 0) = "0000" else DataIn2 when ALUCtrl(3 downto 0) = "1111";

	ALUResult <= immidiate_val;
	with immidiate_val select
		Zero <= '1' when x"00000000",
		'0' when others;

end architecture ALU_Arch;


