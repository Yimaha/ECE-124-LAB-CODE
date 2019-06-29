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

	component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
	clk			:  in  std_logic :='0';
	DIN2 			:	in	 std_logic_vector(6 downto 0);
	DIN1 			:	in	 std_logic_vector(6 downto 0);
	DOUT			:	out std_logic_vector(6 downto 0);
	DIG2			:	out std_logic;
	DIG1			:	out std_logic
   ); 
   end component;

	
	component Desired_Temp_MUX port (
	Desired_Temp:	in std_logic_vector(7 downto 4);
	CONTROL		: 	in std_logic;
	OUTPUT		: 	OUT std_logic_vector(3 downto 0)
   ); 
   end component;

	component Energy_Monitor_Control_Logic port (
	AGB, ALB, vacation, window, door : in std_logic;
	led0, led2, led3, led4, led5, led7: out std_logic
	);
	end component;

------------------------------------------------------------------
	
	
-- Create any signals, or temporary variables to be used`
	signal INPUT_A : std_logic_vector(3 downto 0);
	signal INPUT_B : std_logic_vector(3 downto 0);
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal AEQB, ALEB, AGEB : std_logic;
	signal AGB, AEB, ALB : std_logic;
	signal TEST_PASS : std_logic;
	
-- Here the circuit begins

begin

 INPUT_A <= sw(3 downto 0);
 --mux that choose vacation mode if pb 3 is pressed, otherwise just use regular input_B
 VACATION_MODE: Desired_Temp_Mux port map(sw(7 downto 4), pb(3), INPUT_B);
 --Seven segment display
 INST1: SevenSegment port map(INPUT_A, seg7_A);
 INST2: SevenSegment port map(INPUT_B, seg7_B);
 INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
 --comparing the value of a and b
 A_COMPARE_B : Four_Bit_Comparator port map(INPUT_A, INPUT_B, AGB, AEB, ALB);
 --energy-montitor, which handles the output of the leds based on the value of a and b
 ENERGY_MONITOR : Energy_Monitor_Control_Logic port map(AGB, ALB, pb(3), pb(1), pb(0), leds(0),leds(2),leds(3),leds(4),leds(5),leds(7));
 
 --same temperature always output 1 to leds1, no editional condition is required
 leds(1) <= AEB;
 
 
 -- assign variable for testbench
 AEQB <= AEB;
 ALEB <= AEB OR ALB;
 AGEB <= AEB OR AGB;
 
 
 
 
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
	--output test result to leds 6, only false if you use the Vacation Mode, Input_B and the MCTest Mode together
	--since the input being passed to the test bench is still limited to sw, but the AEQB, AGEB, and ALEB could potentially depends on vacation mode too
	TEST_PASS <= (not pb(2)) AND (EQ_PASS OR GE_PASS OR LE_PASS);
	leds(6) <= TEST_PASS;
end process;
end Energy_Monitor; 
	
	


