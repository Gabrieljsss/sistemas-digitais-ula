library ieee;
use ieee.std_logic_1164.all;

entity Subtrator is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		carryIn: in std_logic;
		difference: out std_logic_vector(3 downto 0);
		carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
	);
end Subtrator;

architecture behavioral of Subtrator is
	signal entrada2Invertida: std_logic_vector(3 downto 0);
	signal carrySum: std_logic;

	component inverteSinal is
		port(
			input: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0)
		);
	end component;

	component fullAdder4bits is
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;
begin
	-- a - b = a + b_com_sinal_invertido
	inverteESomaUm: inverteSinal port map(entrada2, entrada2Invertida);
	soma: fullAdder4bits port map(
		entrada1, entrada2Invertida,
		carryIn,
		difference,
		carrySum, flagNegativo, flagZero, flagOverflow
	);
	carryOut <= not carrySum;

end behavioral;
