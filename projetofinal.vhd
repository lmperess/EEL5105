library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity projetofinal is port(

    SW: in std_logic_vector(17 downto 0);
    CLOCK_50: in std_logic;
	 KEY: in std_logic_vector(3 downto 0);
    HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(17 downto 0));

end projetofinal;

architecture pj of projetofinal is

signal enter, reset: std_logic;
signal R1, E1, E2, E3, E4, E5, E6: std_logic;
signal end_game, end_sequence, end_round, end_left, end_right: std_logic;
signal Enter_left, Enter_right: std_logic;

component datapath is port(

    SW: in std_logic_vector(17 downto 0);
    CLK: in std_logic;
	 Enter_left, Enter_right: in std_logic;
    R1, E1, E2, E3, E4, E5, E6: in std_logic;
	 end_game, end_sequence, end_round, end_left, end_right: out std_logic;
    HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(17 downto 0));

end component;

component Controle is port (

	end_round, end_game, end_sequence, enter_left, enter_right, enter, clock, reset: in std_logic;
	R1, E1, E2, E3, E4, E5, E6: out std_logic);
	
end component;

component ButtonPlay is port(

    KEY1, KEY0: in  std_logic;
    Reset, clk: in  std_Logic;
    BTN1, BTN0: out std_logic); 
    
end component;

component ButtonSync is port(

    KEY1, KEY0, CLK: in  std_logic;
    BTN1, BTN0: out std_logic);

end component;

begin

B0: ButtonSync port map (KEY(1), KEY(0), CLOCK_50, enter, reset);
B1: Controle port map (end_round, end_game, end_sequence, enter_left, enter_right, enter, CLOCK_50, reset, R1, E1, E2, E3, E4, E5, E6);
B2: ButtonPlay port map (KEY(3), KEY(2), E2, CLOCK_50, Enter_left, Enter_right);
B3: datapath port map (SW, CLOCK_50, Enter_left, Enter_right, R1, E1, E2, E3, E4, E5, E6, end_game, end_sequence, end_round, end_left, end_right, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);

end pj;