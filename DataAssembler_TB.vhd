--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:35:33 06/16/2021
-- Design Name:   
-- Module Name:   /home/jaroslaw/dev/FPGA/Polyphonic_Sound_Card/DataAssembler_TB.vhd
-- Project Name:  Polyphonic_Sound_Card
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DataAssembler
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
 
ENTITY DataAssembler_TB IS
END DataAssembler_TB;
 
ARCHITECTURE behavior OF DataAssembler_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataAssembler
    PORT(
         clk : IN  std_logic;
         s_aclk : OUT  std_logic;
         s_axis_tvalid : IN  std_logic;
         s_axis_tready : OUT  std_logic;
         s_axis_tdata : IN  std_logic_vector(7 downto 0);
         counter_reload : OUT  std_logic_vector(21 downto 0);
         volume : OUT  std_logic_vector(2 downto 0);
         voice_select : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal s_axis_tvalid : std_logic := '0';
   signal s_axis_tdata : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal s_aclk : std_logic;
   signal s_axis_tready : std_logic;
   signal counter_reload : std_logic_vector(21 downto 0);
   signal volume : std_logic_vector(2 downto 0);
   signal voice_select : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataAssembler PORT MAP (
          clk => clk,
          s_aclk => s_aclk,
          s_axis_tvalid => s_axis_tvalid,
          s_axis_tready => s_axis_tready,
          s_axis_tdata => s_axis_tdata,
          counter_reload => counter_reload,
          volume => volume,
          voice_select => voice_select
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
      -- hold reset state for 100 ns.
		wait for clk_period / 2;
      s_axis_tdata <= "10101010";
		s_axis_tvalid <= '1';
		
		wait for clk_period * 4;
		
		s_axis_tvalid <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
