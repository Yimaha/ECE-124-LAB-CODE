library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 


entity Desired_Temp_MUX is port (
	Desired_Temp: in std_logic_vector(3 downto 0);
	CONTROL: in  std_logic_vector(0 downto 0);
	OUTPUT: OUT std_logic_vector(3 downto 0)
); 
end Desired_Temp_MUX;



architecture Behavioral of Desired_Temp_MUX is
begin

PROCESS(CONTROL) is 
begin 
	IF(CONTROL = "1") THEN
	OUTPUT <= Desired_Temp;
	ELSE
	OUTPUT <= "0100";
	END IF;
END PROCESS;


end architecture Behavioral; 