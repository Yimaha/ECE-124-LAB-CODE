library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab3_top is port (
   clkin_50		: in	std_logic;
	pb				: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the switch content
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	
); 
end LogicalStep_Lab3_top;

architecture Energy_Monitor of LogicalStep_Lab3_top is
--
-- Components Used
------------------------------------------------------------------- 

	component Four_Bit_Comparator port (
	A				: in	std_logic_vector(3 downto 0);
 	B   			: in  std_logic_vector(7 downto 4);
	AGB, AEB, ALB: OUT std_logic
	);
	end component;




------------------------------------------------------------------
	
	
-- Create any signals, or temporary variables to be used
	signal INPUT_A : std_logic_vector(3 downto 0);
	signal INPUT_B : std_logic_vector(3 downto 0);
	signal AEQB, ALEB, AGEB : std_logic;
	signal TEST_PASS : std_logic;
	
-- Here the circuit begins

begin
 
 INPUT_A <= sw(3 downto 0);
 INPUT_B <= sw(7 downto 4);
 A_COMPARE_B : Four_Bit_Comparator port map(INPUT_A, INPUT_B, leds(0), leds(1), leds(2));
 
 Testbench1:
 PROCESS(sw, AEQB, ALEB, AGEB, pb(2)) is 
 variable EQ_PASS, GE_Pass, LE_PASS : std_logic := '0';
 
 begin 
	IF ((sw(3 downto 0) = sw(7 downto 4)) AND (AEQB = '1'))THEN
	EQ_PASS :='1';
	GE_PASS :='0';
	LE_PASS :='0';
	
	ELSIF ((sw(3 downto 0) >= sw(7 downto 4)) AND (AGEB = '1'))THEN
	EQ_PASS :='0';
	GE_PASS :='1';
	LE_PASS :='0';
	
	ELSIF ((sw(3 downto 0) <= sw(7 downto 4)) AND (ALEB = '1'))THEN
	EQ_PASS :='0';
	GE_PASS :='0';
	LE_PASS :='1';
	
	ELSE 
	EQ_PASS :='0';
	GE_PASS :='0';
	LE_PASS :='0';
	
	END IF;
	
	TEST_PASS <= pb(2) AND (EQ_PASS OR GE_PASS OR LE_PASS);
	leds(6) <= TEST_PASS;
end process;
end Enery_Monitor; 
	
	
	
end Energy_Monitor;

