--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:43 06/13/2021
-- Design Name:   
-- Module Name:   /home/jaroslaw/dev/FPGA/Polyphonic_Sound_Card/PulseGenerator_TB.vhd
-- Project Name:  Polyphonic_Sound_Card
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PulseGenerator
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
--USE ieee.numeric_std.ALL;
 
ENTITY PulseGenerator_TB IS
END PulseGenerator_TB;
 
ARCHITECTURE behavior OF PulseGenerator_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PulseGenerator
    PORT(
         clk : IN  std_logic;
         reloadValue : IN  std_logic_vector(21 downto 0);
         pulse : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reloadValue : std_logic_vector(21 downto 0) := (others => '0');

 	--Outputs
   signal pulse : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PulseGenerator PORT MAP (
          clk => clk,
          reloadValue => reloadValue,
          pulse => pulse
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reloadValue <= "0000011011101111100100"; --113636 for 440 Hz
      wait for 10 ms;

      wait;
   end process;

END;
