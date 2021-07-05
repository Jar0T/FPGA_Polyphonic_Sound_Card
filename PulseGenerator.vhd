----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:40:26 06/13/2021 
-- Design Name: 
-- Module Name:    PulseGenerator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PulseGenerator is
port (
	clk			: in	STD_LOGIC;
	reloadValue	: in	STD_LOGIC_VECTOR(21 downto 0);
	pulse			: out	STD_LOGIC := '0'
);
end PulseGenerator;

architecture Behavioral of PulseGenerator is

signal counter			: UNSIGNED(21 downto 0) := (others => '0');
signal internalPulse	: STD_LOGIC := '0';

begin

count : process(clk)
begin
	if rising_edge(clk) then
		if counter = 0 then
			counter <= unsigned(reloadValue);
		else
			counter <= counter - 1;
		end if;
	end if;
end process count;

generate_pulse : process(clk)
begin
	if falling_edge(clk) then
		if counter = 0 then
			internalPulse <= not(internalPulse);
		else
			internalPulse <= internalPulse;
		end if;
	end if;
end process generate_pulse;

pulse <= internalPulse;

end Behavioral;

