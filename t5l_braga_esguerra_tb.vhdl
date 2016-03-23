-- Author: 	Michael Arvin Jay Braga
-- 			Joshze Rica Esguerra
-- Section:	CMSC 132 T-5L
-- Program Definition: A test bench for the `alarm` component

-- Library Definition
library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity alarm_tb is
	-- CONSTANTS
	-- number of input combinations
	constant MAX_COMB: integer := 64;
	-- delay value in testing
	constant DELAY: time := 10 ms;
end entity alarm_tb;

architecture tb of alarm_tb is
	
	--  alarm_buzzer indicitor from UUT
	signal alarm_buzzer: std_logic; 
	-- in_buzzer inputs to UUT
	signal in_buzzer: std_logic_vector(2 downto 0);
	-- out_buzzer inputs to UUT
	signal out_buzzer: std_logic_vector(2 downto 0);

	-- Component Declaration
	component alarm is
		port(
			alarm_buzzer: out std_logic;
			in_buzzer: in std_logic_vector(2 downto 0);
			out_buzzer: in std_logic_vector(2 downto 0)
		);
	end component alarm;

begin -- MAIN BODY of architecture
	
	-- instantiation of UUT
	UUT: component alarm port map(alarm_buzzer, in_buzzer, out_buzzer);

	-- main process: generate test vectors and check results
	main: process is
		-- used in calculations
		variable temp: unsigned(5 downto 0);
		variable temp_in: unsigned(2 downto 0);
		variable temp_out: unsigned(2 downto 0);
		variable expected_alarm_buzzer: std_logic;
		-- number of simulation errors
		variable error_count: integer := 0;

	begin
		report "Start simulation.";

		-- loop start
		for count in 0 to 64 loop
			temp := TO_UNSIGNED(count, 6);
			-- inputs for in_buzzers
			in_buzzer(2) <= std_logic(temp(5));
			in_buzzer(1) <= std_logic(temp(4));
			in_buzzer(0) <= std_logic(temp(3));
			-- temporary variable for checking
			temp_in(2) := std_logic(temp(5));
			temp_in(1) := std_logic(temp(4));
			temp_in(0) := std_logic(temp(3));

			-- inputs for out_buzzers
			out_buzzer(2) <= std_logic(temp(2));
			out_buzzer(1) <= std_logic(temp(1));
			out_buzzer(0) <= std_logic(temp(0));
			-- temporary variable for checking
			temp_out(2) := std_logic(temp(2));
			temp_out(1) := std_logic(temp(1));
			temp_out(0) := std_logic(temp(0));
			
			wait for DELAY;

			-- initialize expected alarm_buzzer
			expected_alarm_buzzer := '1';
			-- if no in_buzzers are on
			if (temp_in = "000") then 
				expected_alarm_buzzer := '0';
			end if ;
			-- if no out_buzzers are on
			if (temp_out = "000") then 
				expected_alarm_buzzer := '0';
			end if ;

			-- ASSERTIONS for error checking
			assert((expected_alarm_buzzer = alarm_buzzer))
				report "ERROR: Expected alarm_buzzer " & std_logic'image(expected_alarm_buzzer) & " at time " & time'image(now);
			if (expected_alarm_buzzer /= alarm_buzzer) then
			 	error_count := error_count + 1;
			 end if ; 

		end loop;

		wait for DELAY;

		-- check if there are errors
		assert (error_count=0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";

		if(error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;

		wait;
	end process;
end architecture tb; 
