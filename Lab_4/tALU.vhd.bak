--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			ALUCtrl: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

	--Inputs
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		ALUCtrl => control,
		Zero => zeroOut,
		ALUResult => result
	);
	

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Start testing the ALU
		datain_a <= X"01234567";	-- DataIn in hex
		datain_b <= X"11223344";
		control  <= "00000";		-- Control in binary (ADD and ADDI test)
		wait for 20 ns;
			 			-- result = 0x124578AB  and zeroOut = 0

		control <= "00001"; --addi
		wait for 100ns;
		
		datain_a <= X"01234567"; --sub
		datain_b <= X"11223344";
		control <= "00010";
		wait for 100ns;

		datain_a <= X"11223344"; --subzero finisher
		control <= "00110";
		wait for 100ns;

		datain_b <= X"FEFEFEFE"; --and
		control <= "00101";
		wait for 100ns;


		control <= "00110"; --andi
		wait for 100ns;
		
		datain_a <= X"11001100"; --or
		datain_b <= X"11110011";
		control <="00011";
		wait for 100ns;

		control <= "00100";--ori
		wait for 100ns;

		datain_a <= X"CBACBDFF"; --sll
		datain_b <= X"00000001";
		control <= "00111";
		wait for 100ns;
		
		control <= "01000"; --slli
		wait for 100ns;
			
		control <= "01001"; --srl
		wait for 100ns;

		control <= "01010"; --srli
		wait for 100ns;

		control <= "01011"; --pass
		wait for 100ns;
		
		

		
		-- Add test cases here to drive the ALU implementation


		wait; -- will wait forever
	END PROCESS;

END;