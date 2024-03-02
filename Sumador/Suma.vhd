
library IEEE;
	use IEEE.std_logic_1164.all;
entity exSUM is
	port(
		A,B: in std_logic_vector(3 downto 0); -- Entradas
		C: out std_logic_vector(3 downto 0); -- Salida
		Cout: out std_logic
	);
end exSUM;

architecture archAnd of exSUM is

	signal v: std_logic_vector(2 downto 0);
	signal x: std_logic_vector(2 downto 0);
	signal y: std_logic_vector(2 downto 0);
	signal z: std_logic_vector(2 downto 0);
	signal Cin: std_logic_vector(2 downto 0);
	
begin
v(0) <= A(0) xor B(0);
v(1) <= A(0) and B(0);
v(2) <= v(0) and '0';
C(0) <= v(0) xor '0';
Cin(0) <= v(1) or v(2);

x(0) <= A(1) xor B(1);
x(1) <= A(1) and B(1);
x(2) <= x(0) and Cin(0);
C(1) <= x(0) xor Cin(0);
Cin(1) <= x(1) or x(2);

y(0) <= A(2) xor B(2);
y(1) <= A(2) and B(2);
y(2) <= y(0) and Cin(1);
c(2) <= y(0) xor Cin(1);
Cin(2) <= y(1) or y(2);

z(0) <= A(3) xor B(3);
z(1) <= A(3) and B(3);
z(2) <= z(0) and Cin(2);
c(3) <= z(0) xor Cin(2);
Cout <= z(1) or z(2);

end architecture archAnd;