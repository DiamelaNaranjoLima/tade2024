library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arich.all;
se ieee.std_logic_unsigned.all;

entity maquina_de _estado is
generic (
)
port(
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic;
    output : out std_logic; 
  ; 

);
end maquina_de _estado;

architecture archMAQ_ESTADO of maquina_de _estado is
type state_type is (stA,stB,stC);--definir los estados
signal state_actual : state_type; senal para el estado actual de tipo state_type

begin 
process (clk, rst)
begin
if rst = '1' then

state_actual<= stA;
elsif rising_edge (clk) then
report "flanco ascendentedetectado" --imprime ese mensaje en un lugar especifico de la SIMULACION
case state_actual is 
when stA=>
if input ='1'then
state_actual=>stB
end if;
when stB=>
state_actual=>stC
when stC=>
state_actual=>stA
end case;
end if;
end process;

--definir salida basada en estado actual   

process (state_actual)
begin
case state_actual is
when stA=>
output<= '0';
when stB=>
output<= '1';
when stC=>
output<= '0';
end processend;
end archMAQ_ESTADO;

--TESTBENCH

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY test_bench IS
END test_bench;

architecture archtb of test_bench is 
COMPONENT test_component
generic (
)
PORT(
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic;
    output : out std_logic; 
  
);
end test_component

--declaro senales de prueba
signal clk, rst,input : std_logic;
signal output: std_logic;
constant Tclk : time := 10 ns;
begin 
--iniciar mi maquina de estado

uut: test_component PORT MAP (
clk => clk;
rst => rst;
input=> input;
output=>output;

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
--reiniciando maq de estado
rst <='1';
input<='0';
wait for 2*Tclk;
report "salida esperada del estado A en 0 , salida real:"&std_logic'image(output);
rst <='0';
--probar transicion de est A a est B
input<='1';
wait for 2*Tclk;
report "salida esperada del estado B en 1 , salida real:"&std_logic'image(output);--convierte el valor de la senal output a una cadena de caracteres, luego se concatenacon el mensaje estatico,muy util imprime el valor de la senal en un punto de la simulacion
--probar transicion de estado B a est C
input<='0';-- aqui puedo dar 0 o 1 porq ambas van para state c
wait for 2*Tclk; --ciclos de maq
report "salida esperada del estado C 0 , salida real:"&std_logic'image(output);
--probar transicion de estado C a est A
wait for 2*Tclk; -- 2 ciclos de maq
report "salida esperada del estado A 0 , salida real:"&std_logic'image(output);
--THE END
wait ;
end process;
end archMAQ_ESTADO














