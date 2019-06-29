library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Single_Bit_Comparator is port (
		A, B: IN std_logic;
		AGB, AEB, ALB: OUT std_logic
); 
end Single_Bit_Comparator;

architecture Comparator of Single_Bit_Comparator is

begin
AGB <= A AND (NOT B);
AEB <= NOT(A XOR B);
ALB <= (NOT A) AND B;
end Comparator;

