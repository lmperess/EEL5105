library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity counter_round is
port ( reset: in std_logic;
E: in std_logic;
clock: in std_logic;
Tc: out std_logic;
count: out std_logic_vector (3 downto 0)
);
end counter_round;

architecture topo_beh of counter_round is
signal contador: std_logic_vector(3 downto 0);
-- registra valor da contagem
Begin
P1: process(clock, reset, E, contador)
begin
	if reset= '1' then
	contador <= "1111";
	Tc <= '0';
	elsif clock'event and clock= '1' then
		if E = '1' then 
		contador <= contador - "0001";
			if contador = "0000" then
			Tc <= '1';
			else
			Tc <= '0';
			end if;
		 end if;	
	end if;
end process;
count <= contador;
end topo_beh;