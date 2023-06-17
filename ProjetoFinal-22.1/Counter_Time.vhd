library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity Counter_Time is port(
clock: in std_logic;
set: in std_logic;
E: in std_logic;
load: in std_logic_vector(7 downto 0);
saida: out std_logic_vector(7 downto 0);
endtime: out std_logic
);
end Counter_Time;

architecture bhv of Counter_Time is
signal tc: std_logic_vector(7 downto 0);
begin

P1: process(clock, set, E, tc)
begin
if (set = '1') then
tc <= "01100011";
endtime <= '0';
elsif clock'event and clock= '1' then
	if E = '1' then
	tc <= tc + load;
		if (tc < "00000001") then
		endtime <= '1';
		tc <= "00000000";
		else
		endtime <= '0';
		end if;
	end if;
end if;
end process;
saida <= tc;
end bhv;
