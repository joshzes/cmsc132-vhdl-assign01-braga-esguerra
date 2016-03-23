-- Author: 	Michael Arvin Jay Braga
-- 			Joshze Rica Esguerra
-- Section:	CMSC 132 T-5L
-- Program Definition: An alarm component that alarms when 
-- 			 atleast one pair of IN and OUT buzzers are on.

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

-- Entity Definition
entity alarm is
	port(
		-- output
		alarm_buzzer: out std_logic;
		-- inputs
		in_buzzer: in std_logic_vector(2 downto 0);
		out_buzzer: in std_logic_vector(2 downto 0)
	);
end entity alarm;

-- Architecture Definition
architecture priority of alarm is
begin
	-- ALARM_BUZZER = [ in(0) or in(1) or in(2) ] and [ out(0) or out(1) or out(2) ]
	alarm_buzzer <= '0' when in_buzzer = "000" else -- when no IN buzzers are on
			 		'0' when out_buzzer = "000" else -- when no OUT buzzers are on
					'1';
end architecture priority;
