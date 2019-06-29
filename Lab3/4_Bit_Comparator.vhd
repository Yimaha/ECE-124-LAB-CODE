library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab3_top is port (
	A				: in	std_logic_vector(3 downto 0);
 	B   			: in  std_logic_vector(7 downto 4);
	AGB, AEB, ALB: OUT BIT
	
); 
end LogicalStep_Lab3_top;

architecture Energy_Monitor of LogicalStep_Lab3_top is
--
-- Components Used
------------------------------------------------------------------- 

	component LogicAdder port (
	A, B: IN BIT;
	AGB, AEB, ALB: OUT BIT
	);
	end component;

------------------------------------------------------------------
	
	
-- Create any signals, or temporary variables to be used
	
	
-- Here the circuit begins

begin
 
end Energy_Monitor;

