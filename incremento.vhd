library ieee;
use ieee.std_logic_1164.all;

entity incremento is
	port(
		entrada: in std_logic_vector(3 downto 0);
		resultado: out std_logic_vector(3 downto 0);
		carryOut: out std_logic
	);
end incremento;

architecture behavioral of incremento is
	component fullAdder4bits is
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;
begin
	-- x++ => x = x + "0001"
	instanciaSomaUm: fullAdder4bits port map(entrada, "0001", '0', resultado, carryOut, open, open, open);

end behavioral;
