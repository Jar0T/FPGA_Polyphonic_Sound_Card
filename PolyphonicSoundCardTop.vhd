----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:39 06/13/2021 
-- Design Name: 
-- Module Name:    PolyphonicSoundCardTop - Behavioral 
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

entity PolyphonicSoundCardTop is
port (
	clk					: in	STD_LOGIC;
	rx						: in	STD_LOGIC;
	digital_audio_1	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_2	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_3	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_4	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_5	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_6	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_7	: out	STD_LOGIC_VECTOR(3 downto 0);
	digital_audio_8	: out	STD_LOGIC_VECTOR(3 downto 0);
	led					: out	STD_LOGIC_VECTOR(1 downto 0)
);
end PolyphonicSoundCardTop;

architecture Behavioral of PolyphonicSoundCardTop is

component Voice
port (
	clk				: in	STD_LOGIC;
	counter_reload	: in	STD_LOGIC_VECTOR(21 downto 0);
	volume			: in	STD_LOGIC_VECTOR(2 downto 0);
	load				: in	STD_LOGIC;
	digital_audio	: out	STD_LOGIC_VECTOR(3 downto 0)
);
end component;

component UartReceiver
port (
	uartClk			:	in 	STD_LOGIC;	-- 307,2 kHz for 19200 baudrate
	rx					:	in 	STD_LOGIC;
	m_aclk			:	in 	STD_LOGIC;
	m_axis_tvalid	: 	out	STD_LOGIC;
	m_axis_tready	:	in		STD_LOGIC;
	m_axis_tdata	:	out	STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component DataAssembler
port (
	clk				:	in		STD_LOGIC;
	s_aclk			:	out	STD_LOGIC;
	s_axis_tvalid	:	in		STD_LOGIC;
	s_axis_tready	:	out	STD_LOGIC;
	s_axis_tdata	:	in		STD_LOGIC_VECTOR(7 downto 0);
	counter_reload	:	out	STD_LOGIC_VECTOR(21 downto 0);
	volume			:	out	STD_LOGIC_VECTOR(2 downto 0);
	voice_select	:	out	STD_LOGIC_VECTOR(7 downto 0);
	bytes_read		:	out	STD_LOGIC_VECTOR(1 downto 0)
);
end component;

signal uartClk : STD_LOGIC := '0';
signal clockCounter	: UNSIGNED(7 downto 0) := "00000000";

signal aclk, axis_tvalid, axis_tready : STD_LOGIC := '0';
signal axis_tdata : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal counter_reload : STD_LOGIC_VECTOR(21 downto 0) := (others => '0');
signal volume : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal load : STD_LOGIC_VECTOR(7 downto 0) := "00000000";

begin

	voice_1 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(0),
		digital_audio	=> digital_audio_1
	);
	
	voice_2 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(1),
		digital_audio	=> digital_audio_2
	);
	
	voice_3 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(2),
		digital_audio	=> digital_audio_3
	);
	
	voice_4 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(3),
		digital_audio	=> digital_audio_4
	);
	
	voice_5 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(4),
		digital_audio	=> digital_audio_5
	);
	
	voice_6 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(5),
		digital_audio	=> digital_audio_6
	);
	
	voice_7 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(6),
		digital_audio	=> digital_audio_7
	);
	
	voice_8 : Voice
	port map(
		clk				=> clk,
		counter_reload	=> counter_reload,
		volume			=> volume,
		load				=> load(7),
		digital_audio	=> digital_audio_8
	);
	
	UartReceiverInstance : UartReceiver
	port map (
		uartClk			=> uartClk,
		rx					=>	rx,
		m_aclk			=> aclk,
		m_axis_tvalid	=> axis_tvalid,
		m_axis_tready	=> axis_tready,
		m_axis_tdata	=> axis_tdata
	);
	
	DataAssemblerInstance : DataAssembler
	port map (
		clk				=> clk,
		s_aclk			=> aclk,
		s_axis_tvalid	=> axis_tvalid,
		s_axis_tready	=> axis_tready,
		s_axis_tdata	=> axis_tdata,
		counter_reload	=> counter_reload,
		volume			=> volume,
		voice_select	=> load,
		bytes_read		=> led
	);
	
divide_clock : process(clk)
begin
	if rising_edge(clk) then
		if clockCounter = "10100011" then
			clockCounter <= "00000000";
			uartClk <= not uartClk;
		else
			clockCounter <= clockCounter + 1;
		end if;
	end if;
end process;


end Behavioral;

