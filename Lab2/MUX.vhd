library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 


entity MUX is port (
   INPUT_A : in std_logic_vector(7 downto 0);
	INPUT_B : in std_logic_vector(7 downto 0);
	CONTROL: in std_logic_vector(3 downto 0);
	OUTPUT: OUT std_logic_vector(7 downto 0)
); 
end MUX;



architecture Behavioral of MUX is
begin

with CONTROL (3 downto 0) select

--only when the pb3 is pressed, we would output addition on 7seg
--if pb is not pressed, output operands on the 7seg
--if we receive unexpected input, we output 88 on the 7seg
OUTPUT <= INPUT_A when "1111", 
			 INPUT_B when "0111",
			 INPUT_A when "1011", 
			 INPUT_A when "1101", 
			 INPUT_A when "1110", 
			 "10001000" when others;

end architecture Behavioral; 