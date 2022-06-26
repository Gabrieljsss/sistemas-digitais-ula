library ieee;
use ieee.std_logic_1164.all;

entity ula is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		operador: in std_logic_vector(2 downto 0);
		result: out std_logic_vector(3 downto 0);
		flagCarry, flagNegativo, flagZero, flagOverflow: out std_logic
	);
end ula;

architecture behavioral of ula is
	-- Linha muito longa (?) ---
	signal resultFinal, resultadoSoma, resultadoSubtracao, resultadoInverteSinal, resultadoIncremento, resultadoComparador, resultadoDobro: std_logic_vector(3 downto 0);
	signal resultadoAnd, resultadoOr: std_logic_vector(3 downto 0);
	signal carrySum, carrySubtracao, carryIncrement,carryDobro: std_logic;
	signal somaNegativa, negativeSubtract: std_logic;
	signal somaZero, zeroSubtract: std_logic;
	signal somaOverflow, overflowSubtract, flagOverflowDobro: std_logic;

	component incremento
		port(
			entrada: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0);
			carryOut: out std_logic
		);
	end component;

	component dobro
		port(
			entrada: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0);
			carryOut: out std_logic;
			flagOverflow: out std_logic
		);
	end component;

	component comparador is
		Port (
			a: in std_logic_vector(3 downto 0);
			b: in std_logic_vector(3 downto 0);
			resultado: out std_logic_vector(3 downto 0)
		);
	end component;

	component fullAdder4bits
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			soma: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;

	component Subtrator
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			carryIn: in std_logic;
			difference: out std_logic_vector(3 downto 0);
			carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;

	component inverteSinal is
		port(
			input: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0)
		);
	end component;

begin
	-------- Realiza todas as operacoes possiveis ------
	resultadoAnd <= entrada1 and entrada2;
	resultadoOr  <= entrada1 or  entrada2;
	instanciaComparadora: comparador port map(entrada1, entrada2, resultadoComparador);
	instaciaQueFazDobro: dobro port map(entrada1, resultadoDobro, carryDobro, flagOverflowDobro);
	instanciaSomo: fullAdder4bits port map(entrada1, entrada2, '0', resultadoSoma, carrySum, somaNegativa, somaZero, somaOverflow);
	instanciaSubtratora: Subtrator port map(entrada1, entrada2, '0', resultadoSubtracao, carrySubtracao, negativeSubtract, zeroSubtract, overflowSubtract);
	instanciaInversora: inverteSinal port map(entrada1, resultadoInverteSinal);
	instanciaIncrementadora: incremento port map(entrada1, resultadoIncremento, carryIncrement);

	-------- Seleciona o resultado e as flags de acordo com a operacao ------
	-- Todo: diminuir o numero de FA instanciados

	------ Lista de operacoes obrigatorias -------
	------ 0000 = soma -------------
	------ 0001 = subtracao -------------
	------ 010 = incremento -------------
	------ 011 = inverte sinal  -------------
	------ 100 = and -------------
	------ 101 = or -------------
	------ 110 = comparador -------------
	------ 111 = dobro -------------
	with operador select
		resultFinal <= resultadoSoma when "000",
		resultadoSubtracao when "001",
		resultadoIncremento when "010",
		resultadoInverteSinal when "011",
		resultadoAnd when "100",
		resultadoOr when "101",
		resultadoComparador when "110",
		resultadoDobro when "111",
		"0000" when others;

	result <= resultFinal;

	with operador select
		flagOverflow <= somaOverflow when "000",
		overflowSubtract when "001",
		flagOverflowDobro when "111",
		'0' when others;

	with operador select
		flagCarry <= carrySum when "000",
		carrySubtracao when "001",
		carryIncrement when "010",
		carryDobro when "111",
		'0' when others;

	with operador select
		flagZero <= somaZero when "000",
		zeroSubtract when "001",
		not(resultFinal(3) or resultFinal(2) or resultFinal(1) or resultFinal(0)) when others;

	with operador select
		flagNegativo <= somaNegativa when "000",
		negativeSubtract when "001",
		resultFinal(3) when others;
end behavioral;