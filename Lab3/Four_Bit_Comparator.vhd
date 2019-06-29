library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Four_Bit_Comparator is port (
	A				: in	std_logic_vector(3 downto 0);
 	B   			: in  std_logic_vector(3 downto 0);
	AGB, AEB, ALB: OUT std_logic
	
); 
end Four_Bit_Comparator;

architecture Comparator of Four_Bit_Comparator is
--
-- Components Used
------------------------------------------------------------------- 

	component Single_Bit_Comparator port (
	A, B: IN std_logic;
	AGB, AEB, ALB: OUT std_logic
	);
	end component;

------------------------------------------------------------------
	
	
-- Create any signals, or temporary variables to be used
	signal A_1		: std_logic;
	signal B_1		: std_logic;
	signal A_1GB_1 : std_logic;
	signal A_1EB_1 : std_logic;
	signal A_1LB_1 : std_logic;
	signal A_2		: std_logic;
	signal B_2		: std_logic;
	signal A_2GB_2 : std_logic;
	signal A_2EB_2 : std_logic;
	signal A_2LB_2 : std_logic;
	signal A_3		: std_logic;
	signal B_3		: std_logic;
	signal A_3GB_3 : std_logic;
	signal A_3EB_3 : std_logic;
	signal A_3LB_3 : std_logic;
	signal A_4		: std_logic;
	signal B_4		: std_logic;
	signal A_4GB_4 : std_logic;
	signal A_4EB_4 : std_logic;
	signal A_4LB_4 : std_logic;
	
-- Here the circuit begins

begin

	A_1 <= A(3);
	A_2 <= A(2);
	A_3 <= A(1);
	A_4 <= A(0);
	
	B_1 <= B(3);
	B_2 <= B(2);
	B_3 <= B(1);
	B_4 <= B(0);
	
	FIRST_BIT	: Single_Bit_Comparator port map(A_1, B_1, A_1GB_1, A_1EB_1, A_1LB_1);
	SECOND_BIT	: Single_Bit_Comparator port map(A_2, B_2, A_2GB_2, A_2EB_2, A_2LB_2);
	THRID_BIT	: Single_Bit_Comparator port map(A_3, B_3, A_3GB_3, A_3EB_3, A_3LB_3);
	FOURTH_BIT	: Single_Bit_Comparator port map(A_4, B_4, A_4GB_4, A_4EB_4, A_4LB_4);
	
	AGB <= (A_1GB_1) OR (A_1EB_1 AND A_2GB_2) or (A_1EB_1 AND A_2EB_2 AND A_3GB_3) or (A_1EB_1 AND A_2EB_2 AND A_3EB_3 AND A_4GB_4);
	ALB <= (A_1LB_1) OR (A_1EB_1 AND A_2LB_2) or (A_1EB_1 AND A_2EB_2 AND A_3LB_3) or (A_1EB_1 AND A_2EB_2 AND A_3EB_3 AND A_4LB_4);
	AEB <= A_1EB_1 AND A_2EB_2 AND A_3EB_3 AND A_4EB_4;
 
end Comparator;

