library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_seq is port (
	reset: in std_logic;
	E: in std_logic;
	clock: in std_logic;
	Tc: out std_logic;
	count: out std_logic_vector (1 downto 0)
	);
end counter_seq;

architecture topo_beh of counter_seq is
	
signal contador: std_logic_vector(1 downto 0);

Begin
	
process(clock, reset, E, contador)
	begin
		if reset= '1' then
			contador <= "00";
			Tc <= '0';
		elsif clock'event and clock= '1' then
			if E = '1' then 
				contador <= contador + 1;
			end if;
			if contador = "11" then
				Tc <= '1';
			else
				Tc <= '0';
			end if;
		end if;
end process;
			
count <= contador;
				
end topo_beh;
