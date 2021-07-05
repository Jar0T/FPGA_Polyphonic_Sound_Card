----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:18:17 06/15/2021 
-- Design Name: 
-- Module Name:    UartReceiver - Behavioral 
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

entity UartReceiver is
port (
	uartClk			:	in 	STD_LOGIC;	-- 307,2 kHz for 19200 baudrate
	rx					:	in 	STD_LOGIC;
	m_aclk			:	in 	STD_LOGIC;
	m_axis_tvalid	: 	out	STD_LOGIC;
	m_axis_tready	:	in		STD_LOGIC;
	m_axis_tdata	:	out	STD_LOGIC_VECTOR(7 downto 0)
);
end UartReceiver;

architecture Behavioral of UartReceiver is

component UartFifo
port (
	m_aclk			:	in		STD_LOGIC;
	s_aclk			:	in		STD_LOGIC;
	s_aresetn		:	in 	STD_LOGIC;
	s_axis_tvalid	:	in 	STD_LOGIC;
	s_axis_tready	:	out 	STD_LOGIC;
	s_axis_tdata	:	in 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	m_axis_tvalid	:	out 	STD_LOGIC;
	m_axis_tready	:	in 	STD_LOGIC;
	m_axis_tdata	:	out 	STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;

signal shiftRegister			: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal counter					: UNSIGNED(3 downto 0) := "0000";
signal receivedBitsCount	: UNSIGNED(2 downto 0) := "000";
signal state					: STD_LOGIC_VECTOR(1 downto 0) := "00"; -- 00 idle, 01 start bit, 10 data, 11 stop bit
signal s_axis_tvalid			: STD_LOGIC := '0';
signal dataReceived			: STD_LOGIC := '0';

begin

ReceiveFifo : UartFifo
port map (
	m_aclk			=>	m_aclk,
	s_aclk			=> uartClk,
	s_aresetn		=>	'1',
	s_axis_tvalid	=> s_axis_tvalid,
	s_axis_tready	=> open,
	s_axis_tdata	=>	shiftRegister,
	m_axis_tvalid	=>	m_axis_tvalid,
	m_axis_tready	=>	m_axis_tready,
	m_axis_tdata	=>	m_axis_tdata
);

count : process(uartClk)
begin
	if rising_edge(uartClk) then
		case state is
			when "00" =>
				counter <= "0000";
			when "01" =>
				if counter = "0111" then
					counter <= "0000";
				else
					counter <= counter + 1;
				end if;
			when "10" =>
				counter <= counter + 1;
			when "11" =>
				counter <= counter + 1;
			when others => null;
		end case;
	end if;
end process;

receive_data : process(uartClk)
begin
	if rising_edge(uartClk) then
		case state is
			when "00" =>
				if rx = '0' then
					state <= "01";
				else
					null;
				end if;
			when "01" =>
				if counter = "0111" then
					state <= "10";
				else
					null;
				end if;
			when "10" =>
				if counter = "1111" then
					shiftRegister <= rx & shiftRegister(7 downto 1);
					receivedBitsCount <= receivedBitsCount + 1;
					if receivedBitsCount = "111" then
						receivedBitsCount <= "000";
						state <= "11";
					else
						null;
					end if;
				else
					null;
				end if;
			when "11" =>
				if counter = "1111" then
					state <= "00";
				else
					null;
				end if;
			when others => null;
		end case;
	end if;
end process;

fifo_signals : process(uartClk)
begin
	if falling_edge(uartClk) then
		case state is
			when "11" =>
				if dataReceived = '0' then
					s_axis_tvalid <= '1';
				else
					s_axis_tvalid <= '0';
				end if;
				dataReceived <= '1';
			when "00" =>
				dataReceived <= '0';
			when others =>
				dataReceived <= '0';
				s_axis_tvalid <= '0';
		end case;
	end if;
end process;

end Behavioral;

