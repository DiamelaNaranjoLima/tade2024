library IEEE;
u IseEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity RAM_256x2 is
gdeneric(
    A: integer := 32;
    B: integer := 8;
    C: integer := 256
);
    Port (
        clk : in STD_LOGIC; -- Clock signal
        rst : in STD_LOGIC; -- Reset signal
        en : in STD_LOGIC; -- Enable signal
        wr : in STD_LOGIC; -- Write enable
        rd : in STD_LOGIC; -- Read enable
        din : in STD_LOGIC_VECTOR (A-1 downto 0); -- 32-bit data input
        addr : in STD_LOGIC_VECTOR (B-1 downto 0); -- 8-bit address
        dout : out STD_LOGIC_VECTOR (A-1 downto 0) -- 32-bit data output
    );
end RAM_256x2;

architecture Behavioral of RAM_256x2 is
    type memory is array (0 to C-1) of STD_LOGIC_VECTOR (A-1 downto 0);
    signal ram : memory;
begin
    process (clk, rst)
    begin
        if rst = '1' then
            -- Reset all memory cells to zero
            for i in 0 to 255 loop
                ram(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then
            if en = '1' then
                if wr = '1' then
                    ram(to_integer (unsigned(addr))) <= din;
                end if;
                if rd = '1' then
                    dout <= ram(to_integer(unsigned(addr)));
                end if;
            end if;
        end if;
    end process;
end Behavioral;