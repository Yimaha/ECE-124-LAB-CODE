library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
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
	
	
	component LogicProcessor port (
	INPUT_A 		: in std_logic_vector(3 downto 0);
	INPUT_B 		: in std_logic_vector(7 downto 4);
	OPTION		: in std_logic_vector(3 downto 0);
	OUTPUT		: OUT std_logic_vector(7 downto 0)
	);
	end component;
	
	component LogicAdder port (
	INPUT_A 		: in std_logic_vector(3 downto 0);
	INPUT_B 		: in std_logic_vector(7 downto 4);
	OUTPUT		: OUT std_logic_vector(7 downto 0)
	);
	end component;
	
	component MUX port (
	INPUT_A 		: in std_logic_vector(7 downto 0);
	INPUT_B 		: in std_logic_vector(7 downto 0);
	CONTROL		: in std_logic_vector(3 downto 0);
	OUTPUT		: OUT std_logic_vector(7 downto 0)
	);
	end component;
	
	component  MUX_LED port (
	INPUT_A 		: in std_logic_vector(7 downto 0);
	INPUT_B 		: in std_logic_vector(7 downto 0);
	CONTROL		: in std_logic_vector(3 downto 0);
	OUTPUT		: OUT std_logic_vector(7 downto 0)
	);
	end component;
	
-- Create any signals, or temporary variables to be used
--
-- std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);
	signal hex_B 		: std_logic_vector(7 downto 4);
	--stores result for adder
	signal adder		: std_logic_vector(7 downto 0);
	--stores result for logic
	signal logic 		: std_logic_vector(7 downto 0);
	--stores result for the chosen seg7
	signal seg7 		: std_logic_vector(7 downto 0);
	
	--NOTE, we don't store result for LED since we can directly implement it on the output
	
-- Here the circuit begins

begin
	--seperate sw into two 4 bit logic for convinient usage in the future
	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	
	--compute logic output based on sw and pb
	LOGIC_OUTPUT: LogicProcessor port map(hex_A, hex_B, pb, logic);
	--compute adder result based on sw and pb
	ADDER_OUTPUT: LogicAdder port map(hex_A, hex_B, adder);
	--choose the right input for LED
	LED_INPUT: MUX_LED port map(adder, logic, pb, leds);
	--choose the right input for 7Seg
	SEG7_INPUT: MUX port map(sw, adder, pb, seg7);
	--processing 7Seg and output it to seg7_data, seg7_char2, seg7_char1
	INST1: SevenSegment port map(Seg7(3 downto 0), seg7_A);
	INST2: SevenSegment port map(Seg7(7 downto 4), seg7_B);
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
end SimpleCircuit;

