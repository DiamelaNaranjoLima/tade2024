library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    Port ( SDIN : in  STD_LOGIC;
           SDOUT : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end fsm;

architecture Behavioral of fsm is
signal state: std_logic_vector(1 downto 0);
signal next_state: std_logic_vector(1 downto 0);
begin 

  SYNC_PROC: process (CLK)
   begin
      if (CLK'event and CLK = '1') then
         if (RST = '1') then
            state <= "00";

         else
            state <= next_state;

         end if;        
      end if;
   end process;

		
	
NEXT_STATE_DECODE: process ( state, SDIN)
   begin

 case (state) is
         when "00" =>
            if SDIN = '1' then
               next_state <= "01";
            end if;
         when "01" =>
					if SDIN = '0' then
               next_state <= "10";
            end if;
         when others =>
            next_state <= "00";

      end case;      
   end process;
	
	SDOUT <= '0' when state = "01"else '1';

end Behavioral;

