library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 


entity LogicAdder is port (
   INPUT_A : in std_logic_vector(3 downto 0);
	INPUT_B : in std_logic_vector(7 downto 4);
	OUTPUT: OUT std_logic_vector(7 downto 0)
); 
end LogicAdder;



architecture Behavioral of LogicAdder is
begin
-- First convert logic to integer so we can perform addition on INPUT_A and INPUT_B,
-- then convert it back into the logic, so we can feed it to both led and 7seg
OUTPUT(7 downto 0) <= std_logic_vector(unsigned("0000" & INPUT_B) + unsigned("0000" & INPUT_A));
end architecture Behavioral; 