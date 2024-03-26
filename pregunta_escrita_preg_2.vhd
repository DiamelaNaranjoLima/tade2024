--EL componente noise_suppresor.vhd reutiliza el componente counter.vhd previamente diseñado. Este
--componente cumple la función de eliminar el ruido proveniente de una señal digital y dar una salida
--actualizada solo cuando la señal de entrada se mantiene estable durante una cantidad de pulsos de reloj
--establecida en el parámetro genérico g_nClkIgnore. Diseñe un test-bench que permita evaluar el
--comportamiento del circuito y definir si es correcto o no.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity noise_suppressor_tb is
end noise_suppressor_tb;

architecture sim of noise_suppressor_tb is
    -- Definición del componente a simular
    component noise_suppressor is
        generic(
            g_nClkIgnore : integer := 20 
        );
        port (
            i_clk   : in std_logic;
            i_rst   : in std_logic;
            i_data : in std_logic;
            o_data : out std_logic
        );
    end component;

    -- Señales para el test bench
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal data_in : std_logic := '0';
    signal data_out : std_logic;

    -- Constante para el periodo del reloj
    constant clk_period : time := 10 ns;
begin
    -- Instancia del componente a simular
    UUT: noise_suppressor
        generic map (
            g_nClkIgnore => 20
        )
        port map (
            i_clk => clk,
            i_rst => rst,
            i_data => data_in,
            o_data => data_out
        );

    -- Proceso para generar el reloj
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Proceso para simular las señales de entrada
    stim_proc: process
    begin
        -- Reinicio inicial
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

        -- Prueba con datos estables
        data_in <= '0';
        wait for clk_period * 20; -- Asegurarse de que el contador alcance el límite
        assert data_out = '0' report "Error: La señal de salida no es estable" severity error;

        -- Prueba con datos cambiantes
        data_in <= '1';
        wait for clk_period * 10; -- Menos de 20 ciclos de reloj
        assert data_out = '0' report "Error: La señal de salida debería ser inestable" severity error;

        -- Prueba con datos estables nuevamente
        data_in <= '0';
        wait for clk_period * 20; -- Asegurarse de que el contador alcance el límite
        assert data_out = '0' report "Error: La señal de salida no es estable" severity error;

        -- Fin de la simulación
        wait;
    end process;

end sim;