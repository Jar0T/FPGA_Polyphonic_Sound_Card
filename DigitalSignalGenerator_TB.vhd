--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:58:32 07/03/2021
-- Design Name:   
-- Module Name:   /home/jarek/development/FPGA/Polyphonic_Sound_Card/DigitalSignalGenerator_TB.vhd
-- Project Name:  Polyphonic_Sound_Card
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DigitalSignalGenerator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY DigitalSignalGenerator_TB IS
END DigitalSignalGenerator_TB;
 
ARCHITECTURE behavior OF DigitalSignalGenerator_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DigitalSignalGenerator
    PORT(
         audio_signal : IN  std_logic;
         volume : IN  std_logic_vector(2 downto 0);
         digital_audio : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal audio_signal : std_logic := '0';
   signal volume : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal digital_audio : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DigitalSignalGenerator PORT MAP (
          audio_signal => audio_signal,
          volume => volume,
          digital_audio => digital_audio
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      
      volume <= "000";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "001";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "010";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "011";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "100";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "101";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "110";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;
		
		volume <= "111";
		audio_signal <= '0';
		wait for 1 ns;
		audio_signal <= '1';
		wait for 1 ns;

      wait;
   end process;

END;
