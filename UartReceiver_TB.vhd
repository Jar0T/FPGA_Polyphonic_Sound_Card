--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:18:38 06/15/2021
-- Design Name:   
-- Module Name:   /home/jaroslaw/dev/FPGA/Polyphonic_Sound_Card/UartReceiver_TB.vhd
-- Project Name:  Polyphonic_Sound_Card
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UartReceiver
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
 
ENTITY UartReceiver_TB IS
END UartReceiver_TB;
 
ARCHITECTURE behavior OF UartReceiver_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UartReceiver
    PORT(
         uartClk : IN  std_logic;
         rx : IN  std_logic;
			m_aclk : IN  std_logic;
			m_axis_tvalid : OUT  std_logic;
			m_axis_tready : IN  std_logic;
			m_axis_tdata : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal uartClk : std_logic := '0';
   signal rx : std_logic := '0';
	signal m_aclk : std_logic := '0';
	signal m_axis_tready : std_logic := '0';
	
	--Outputs
	signal m_axis_tvalid : std_logic;
	signal m_axis_tdata : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant uartClk_period : time := 3255 ns;
	constant m_aclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UartReceiver PORT MAP (
          uartClk => uartClk,
          rx => rx,
			 m_aclk => m_aclk,
			 m_axis_tvalid => m_axis_tvalid,
			 m_axis_tready => m_axis_tready,
			 m_axis_tdata => m_axis_tdata
        );

   -- Clock process definitions
   uartClk_process :process
   begin
		uartClk <= '0';
		wait for uartClk_period/2;
		uartClk <= '1';
		wait for uartClk_period/2;
   end process;
	
	m_aclk_process :process
   begin
		m_aclk <= '0';
		wait for m_aclk_period/2;
		m_aclk <= '1';
		wait for m_aclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rx <= '1';
		
		wait for uartClk_period * 10;
		
		rx <= '0';
		
		wait for uartClk_period * 16;
		
		rx <= '1';
		
		wait for uartClk_period * 16 * 4;

		rx <= '0';
		
		wait for uartClk_period * 16 * 4;
		
		rx <= '1';
		
		wait for uartClk_period * 16;
		
		wait for uartClk_period * 9;
		
		m_axis_tready <= '1';
		
		wait for uartClk_period;
		
		m_axis_tready <= '0';
		
		rx <= '0';
		
		wait for uartClk_period * 16;
		
		rx <= '0';
		
		wait for uartClk_period * 16 * 4;

		rx <= '1';
		
		wait for uartClk_period * 16 * 4;
		
		rx <= '1';
		
		wait for uartClk_period * 3;
		
		m_axis_tready <= '1';
		
		wait for uartClk_period;
		
		m_axis_tready <= '0';
		
      -- insert stimulus here 

      wait;
   end process;

END;
