library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 


entity MUX_LED is port (
   INPUT_A : in std_logic_vector(7 downto 0);
	INPUT_B : in std_logic_vector(7 downto 0);
	CONTROL: in std_logic_vector(3 downto 0);
	OUTPUT: OUT std_logic_vector(7 downto 0)
); 
end MUX_LED;



architecture Behavioral of MUX_LED is
begin

--if nothing is pressed, then output 00000000
--if pb3 is pressed, output addition result on LED
--if anything but pb3 is pressed, output logic on LED
--if received unexpected result, light up all LEDs
with CONTROL (3 downto 0) select
OUTPUT <= "00000000" when "1111",
			 INPUT_A when "0111",
			 INPUT_B when "1011",
			 INPUT_B when "1101",
			 INPUT_B when "1110",
			 "11111111" when others;

end architecture Behavioral; 