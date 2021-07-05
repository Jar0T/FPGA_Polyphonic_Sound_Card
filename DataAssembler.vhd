----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:07:28 06/15/2021 
-- Design Name: 
-- Module Name:    DataAssembler - Behavioral 
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

entity DataAssembler is
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
end DataAssembler;

architecture Behavioral of DataAssembler is

signal counter	: UNSIGNED(1 downto 0) := "00";
signal shift_register	:	STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000010110001100011";
signal axis_tready	:	STD_LOGIC := '0';

begin

generate_axis_signals : process(clk)
begin
	if falling_edge(clk) then
		if s_axis_tvalid = '1' then
			axis_tready <= '1';
		else
			axis_tready <= '0';
		end if;
	end if;
end process generate_axis_signals;

read_data_in : process(clk)
begin
	if rising_edge(clk) then
		if axis_tready = '1' then
			shift_register <= shift_register(23 downto 0) & s_axis_tdata;
			counter <= counter + 1;
		else
			null;
		end if;
	end if;
end process read_data_in;

output_data : process(clk)
begin
	if falling_edge(clk) then
		if counter = "00" then
			counter_reload <= shift_register(21 downto 0);
			volume <= shift_register(24 downto 22);
			case shift_register(27 downto 25) is
				when "000" => voice_select <= "00000001";
				when "001" => voice_select <= "00000010";
				when "010" => voice_select <= "00000100";
				when "011" => voice_select <= "00001000";
				when "100" => voice_select <= "00010000";
				when "101" => voice_select <= "00100000";
				when "110" => voice_select <= "01000000";
				when "111" => voice_select <= "10000000";
				when others => voice_select <= "00000000";
			end case;
		else
			null;
		end if;
	end if;
end process output_data;

s_aclk <= clk;
s_axis_tready <= axis_tready;

bytes_read <= STD_LOGIC_VECTOR(counter);

end Behavioral;

