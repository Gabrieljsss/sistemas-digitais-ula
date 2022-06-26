library ieee;
use ieee.std_logic_1164.all;

entity dobro is
	port(
		entrada: in std_logic_vector(3 downto 0);
		resultado: out std_logic_vector(3 downto 0);
		carryOut: out std_logic;
		flagOverflow: out std_logic
	);
end dobro;

architecture behavioral of dobro is
	component fullAdder4bits is
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;
begin
	-- Dobro(x) = x + x
	instanciaFazDobro: fullAdder4bits port map(entrada, entrada, '0', resultado, carryOut, open, open, flagOverflow);

end behavioral;
