library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 


entity LogicProcessor is port (
   INPUT_A : in std_logic_vector(3 downto 0);
	INPUT_B : in std_logic_vector(7 downto 4);
	OPTION: in std_logic_vector(3 downto 0);
	OUTPUT: OUT std_logic_vector(7 downto 0)
); 
end LogicProcessor;



architecture Behavioral of LogicProcessor is
begin

with OPTION(3 downto 0) select 
-- based on the button clicked, determin the logic used for each digit
OUTPUT <= "0000" & INPUT_A AND INPUT_B when "1110",
			 "0000" & INPUT_A OR INPUT_B when "1101",
			 "0000" & INPUT_A XOR INPUT_B when "1011",
						"11111111" when others;
-- we handle unexpected input in the MUX 
end architecture Behavioral; 