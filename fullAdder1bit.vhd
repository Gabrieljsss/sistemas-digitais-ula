library ieee;
use ieee.std_logic_1164.all;

entity fullAdder1bit is
	port(
		entrada1, entrada2, carryIn: in std_logic;
		soma, carryOut: out std_logic
	);
end fullAdder1bit;

architecture behavioral of fullAdder1bit is
begin
	carryOut <= (entrada1 and entrada2) or (carryIn and (entrada1 xor entrada2));
	soma <= entrada1 xor entrada2 xor carryIn;
end behavioral;
