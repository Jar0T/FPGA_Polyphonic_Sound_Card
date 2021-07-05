----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:39:58 07/03/2021 
-- Design Name: 
-- Module Name:    Voice - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Voice is
port (
	clk				: in	STD_LOGIC;
	counter_reload	: in	STD_LOGIC_VECTOR(21 downto 0);
	volume			: in	STD_LOGIC_VECTOR(2 downto 0);
	load				: in	STD_LOGIC;
	digital_audio	: out	STD_LOGIC_VECTOR(3 downto 0) := "1000"
);
end Voice;

architecture Behavioral of Voice is

component PulseGenerator
port (
	clk			: in	STD_LOGIC;
	reloadValue	: in	STD_LOGIC_VECTOR(21 downto 0);
	pulse			: out	STD_LOGIC
);
end component;

component DigitalSignalGenerator
port (
	audio_signal	: in	STD_LOGIC;
	volume			: in	STD_LOGIC_VECTOR(2 downto 0);
	digital_audio	: out	STD_LOGIC_VECTOR(3 downto 0) := "1000"
);
end component;

signal s_counter_reload : STD_LOGIC_VECTOR(21 downto 0) := "0000000000000000000000";
signal s_volume : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal s_audio : STD_LOGIC := '0';

begin

pulse_generator : PulseGenerator
port map (
	clk			=> clk,
	reloadValue	=> s_counter_reload,
	pulse			=> s_audio
);

digital_signal_generator : DigitalSignalGenerator
port map (
	audio_signal	=> s_audio,
	volume			=> s_volume,
	digital_audio	=> digital_audio
);

load_counter_value : process(clk)
begin
	if rising_edge(clk) then
		if load = '1' then
			s_counter_reload <= counter_reload;
		else
			null;
		end if;
	end if;
end process load_counter_value;

load_volume_value : process(clk)
begin
	if rising_edge(clk) then
		if load = '1' then
			s_volume <= volume;
		else
			null;
		end if;
	end if;
end process load_volume_value;

end Behavioral;

