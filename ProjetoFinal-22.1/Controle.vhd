library ieee;
use ieee.std_logic_1164.all;

entity Controle is port (
	end_round,end_game, end_sequence, enter_left, enter_right, enter, clock, reset: in std_logic;
	R1, E1, E2, E3, E4, E5, E6: out std_logic
	);
end Controle;

architecture circuito of Controle is
	
type STATES is (INIT, SETUP, SEQUENCE, PLAY, CHECK, WT, RESULT);
signal EA, PE: STATES;

Begin
	
P1: process(clock, reset)
    begin
       if reset = '1' then
           EA <= INIT;
       elsif clock'event and clock = '0' then
           EA <= PE;
       end if;
   end process;
    
P2: process (EA)
    begin 
       case EA is 
           when INIT =>  R1 <= '1';
                         E1 <= '0';
                         E2 <= '0';
                         E3 <= '0';
                         E4 <= '0';
                         E5 <= '0';
                         E6 <= '0';
                         PE <= SETUP;
                
            when SETUP => R1 <= '0';
                          E1 <= '1';
                          E2 <= '0';
                          E3 <= '0';
                          E4 <= '0';
                          E5 <= '0';
                          E6 <= '0';

                          if enter = '1' then
                              PE <= SEQUENCE;
                          else
                              PE <= SETUP;
                          end if;
            
            when SEQUENCE =>  R1 <= '0';
                              E1 <= '0';
                              E2 <= '1';
                              E3 <= '0';
                              E4 <= '0';
                              E5 <= '0';
                              E6 <= '0';

                              if end_sequence = '1' then
                                  PE <= PLAY;
                              else
                                  PE <= SEQUENCE;
                              end if;
                    
            when PLAY =>  R1 <= '0';
                          E1 <= '0';
                          E2 <= '0';
                          E3 <= '1';
                          E4 <= '0';
                          E5 <= '0';
                          E6 <= '0';

                          if enter_left = '1' and enter_right = '1' then
                              PE <= CHECK;
                          else
                              PE <= PLAY;
                          end if;
                
            when CHECK => R1 <= '0';
                          E1 <= '0';
                          E2 <= '0';
                          E3 <= '0';
                          E4 <= '1';
                          E5 <= '0';
                          E6 <= '0';
                          PE <= WT;
                
            when WT => R1 <= '0';
                       E1 <= '0';
                       E2 <= '0';
                       E3 <= '0';
                       E4 <= '0';
                       E5 <= '1';
                       E6 <= '0';

		       if enter = '1' then
		         if (end_game = '1' or end_round = '1') then
		           PE <= result;
		         else   
		           PE <= sequence;
		         end if;
		       else
		         PE <= WT;
		       end if;
                
            when RESULT => R1 <= '0';
                           E1 <= '0';
                           E2 <= '0';
                           E3 <= '0';
                           E4 <= '0';
                           E5 <= '0';
                           E6 <= '1';

                           if enter = '1' then
                               PE <= INIT;
                           else
                               PE <= RESULT;
                           end if;
				   
            end case;
        end process;
    end circuito;
