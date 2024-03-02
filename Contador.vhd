library IEEE;

use IEEE.STD_LOGIC_1164.ALL;



entity fsm is

    Port ( INIT_PAUSE : in  STD_LOGIC;

           SDOUT : out  STD_LOGIC_VECTOR(1 downto 0);

           CLK : in  STD_LOGIC;

           STOP : in  STD_LOGIC);

end fsm;



architecture Behavioral of fsm is

signal state: std_logic_vector(1 downto 0);

signal next_state: std_logic_vector(1 downto 0);

begin 



  SYNC_PROC: process (CLK)

   begin

      if (CLK'event and CLK = '1') then

         if (STOP = '1') then

            state <= "00";



         else

            state <= next_state;



         end if;        

      end if;

   end process;

	

NEXT_STATE_DECODE: process ( state, INIT_PAUSE)

   begin



 case (state) is

         when "00" =>

            if INIT_PAUSE = '1' then

               next_state <= "01";
				else
					next_state <= "00";

            end if;

         when "01" =>

					if INIT_PAUSE = '0' then

               next_state <= "10";

				else
					next_state <= "00";
				end if;

         when "10" =>
				if INIT_PAUSE = '0' then

               next_state <= "11";

				else
					next_state <= "00";
				end if;
			when others =>
				next_state <= "00";

      end case;      

   end process;


	SDOUT <= 	next_state;
end Behavioral;