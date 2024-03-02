library IEEE;
	use IEEE.std_logic_1164.all;
entity exampleAnd is
	port(
		A,B : in std_logic; -- Entradas
		C: out std_logic -- Salida
	);
end exampleAnd;

architecture archAnd of exampleAnd is

begin
	C <= A and B; -- Compuerta AND
end architecture archAnd;
