library ieee;
use ieee.std_logic_1164.all;

entity inverteSinal is
	port(
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(3 downto 0)
	);
end inverteSinal;

architecture behavioral of inverteSinal is
	signal inverso: std_logic_vector(3 downto 0);

	component fullAdder4bits is
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;
begin
	-- Em complemento a 2, inverte-se o numero positivo e soma um para obter o mesmo numero
	-- com o sinal trocado
	inverso <= not(input);
	instanciaFA: fullAdder4bits port map(inverso, "0001", '0', output, open, open, open, open);
end behavioral;
