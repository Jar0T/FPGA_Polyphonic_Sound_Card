----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:49:04 07/03/2021 
-- Design Name: 
-- Module Name:    DigitalSignalGenerator - Behavioral 
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

entity DigitalSignalGenerator is
port (
	audio_signal	: in	STD_LOGIC;
	volume			: in	STD_LOGIC_VECTOR(2 downto 0);
	digital_audio	: out	STD_LOGIC_VECTOR(3 downto 0) := "1000"
);
end DigitalSignalGenerator;

architecture Behavioral of DigitalSignalGenerator is

begin

digital_audio <= "1000" when volume = "000" else
					  audio_signal & volume when audio_signal = '0' else
					  audio_signal & not volume;

end Behavioral;

