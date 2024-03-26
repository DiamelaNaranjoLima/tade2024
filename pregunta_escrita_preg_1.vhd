--Realice una descripción en VHDL de un contador ascendente de N bits. La cantidad de bits del contador
--debe ser definida por un parámetro genérico en el componente con el nombre de g_dataSize. El contador
--debe reiniciar su salida de conteo (o_data) si esta se iguala al valor de entrada i_data, en esta transición la
--salida o_end se establece en '1' indicando el reinicio del conteo. 
--el contador solo incremente su valor cuando i_en esté activo ('1')

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_ascendente is
    generic (
        g_dataSize : integer := 8 -- Tamaño del contador en bits
    );
    port (
        clk : in STD_LOGIC; -- Señal de reloj
        reset : in STD_LOGIC; -- Señal de reset
        i_data : in unsigned(g_dataSize-1 downto 0); -- Valor de entrada para reiniciar el contador
        i_en : in STD_LOGIC; -- Señal de habilitación para el contador
        o_data : out unsigned(g_dataSize-1 downto 0); -- Salida de conteo
        o_end : out STD_LOGIC -- Indica el reinicio del conteo
    );
end contador_ascendente;

architecture Behavioral of contador_ascendente is
    signal contador : unsigned(g_dataSize-1 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            contador <= (others => '0');
            o_end <= '0';
        elsif rising_edge(clk) then
            if i_en = '1' then
                if contador = i_data then
                    contador <= (others => '0');
                    o_end <= '1';
                else
                    contador <= contador + 1;
                    o_end <= '0';
                end if;
            end if;
        end if;
    end process;

    o_data <= contador;
end Behavioral;