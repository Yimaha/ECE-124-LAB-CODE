library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Energy_Monitor_Control_Logic is port (
 AGB, ALB, vacation, window, door : in std_logic;
 led0, led2, led3, led4, led5, led7: out std_logic
); 
end Energy_Monitor_Control_Logic;
architecture Energy_Monitor of Energy_Monitor_Control_Logic is
begin
 
 -- door, window, and vacation mode would receive flipped input from pb since pb is naturally flipped
 led4 <= not door;
 led5 <= not window;
 led7 <= not vacation;
 
 Logic: 
 PROCESS(door, window, AGB, ALB) is 
 variable ac_on, fur_on : std_logic := '0';
 begin 
 --always check if door or furnace is open
 IF ((door ='1') AND (window = '1') AND (ALB = '1'))THEN
	fur_on := '1';
	ac_on  := '0';
 
 ELSIF ((door ='1') AND (window = '1') AND (AGB = '1'))THEN
	ac_on  := '1';
	fur_on := '0';
-- if door or window is open, or A equal B, then don't turn on furnace or ac
 ELSE
 	fur_on := '0';
	ac_on  := '0';
 END IF;
-- connect variables to correct leds.
 led0 <= fur_on;
 led2	<= ac_on;
 led3 <= ac_on OR fur_on;
 
end process;
 
 
 
end Energy_Monitor;