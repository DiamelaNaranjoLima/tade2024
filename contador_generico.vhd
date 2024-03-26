library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arich.all;
se ieee.std_logic_unsigned.all;

entity COUNTER_GENERIC is
generic (
    width : integer :=4 --ancho del contador es decir cant de bit
)
port(
    clk : in std_logic;
    rst : in std_logic;
    enable : in std_logic;
    input_data : in std_logic_vector (width-1 downto 0);
    output_data : out std_logic_vector (width-1 downto 0); --para q sea generico es lo mismo q 3 a 0 
    carry_out : out std_logic; 

);
end COUNTER_GENERIC;

architecture archcount of COUNTER_GENERIC is

signal temp_count : td_logic_vector (width-1 downto 0);

begin 

process (clk, rst)
begin
if rst='1' then
temp_count<= input_data;
--rst 0
elsif rising_edge(clk) then
if (enable='1')then
temp_count=>temp_count+1;
end if;
end if;
end process;
output_data<= temp_count;
carry_out <= '1' when temp_count = (temp_count'range =>'1') else '0' -- carry_out se activa cuando el cont alcanza su maximo
end archcount;

--TESTBENCH

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_bench IS
END test_bench;

architecture archtb of test_bench is 
COMPONENT test_component
generic (
    width : integer := 4 --ancho del contador es decir cant de bit
)
PORT(
    clk : in std_logic;
    rst : in std_logic;
    enable : in std_logic;
    input_data : in td_logic_vector (width-1 downto 0);
    output_data : out std_logic_vector (width-1 downto 0); --para q sea generico es lo mismo q 3 a 0 
    carry_out : out std_logic; 

);
END COMPONENT; 
--declaro senales de prueba
signal clk, rst,enable : std_logic;
signal carry_out: std_logic;
signal  input_data, output_data :std_logic_vector(width-1 downto 0);
constant Tclk : time := 10 ns;

begin
--instanciar COUNTER GENERIC

UUT: COUNTER_GENERIC generic map (width=>4) port map
(
clk=> clk;
rst => rst;
enable => enable;
input_data=> input_data;
output_data=> output_data;
carry_out=> carry_out;

);

--Generación del reloj
clk_process :process
begin
clk <= '0';
wait for Tclk /2;
clk <= '1';
wait for Tclk/2;
end process

-- proceso de prueba
stimulus_process : process
begin
-- reiniciando contador con un valor inicial
rst <= '1';
input_data <="0001"; --valor inicial
enable<= '0';
wait for Tclk; --genera una espera 

rst <='0';
--habilitar count y verificar su incremento
enable<='1'
wait for 2*Tclk
report " si se incrementa en 1 deberia ser 0010 salida real:"&std_logic'image(output_data);
--deshabilitar count y verificar su incremento
enable<='0'
wait for 2*Tclk

--generar estímulos FIN DE LA SIMULACION
wait;
end process;
END;