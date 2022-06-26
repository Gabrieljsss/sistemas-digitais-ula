library ieee;
use ieee.std_logic_1164.all;

entity fullAdder4bits is
	port(
		entrada1, entrada2: in std_logic_vector(3 downto 0);
		carryIn: in std_logic;
		soma: out std_logic_vector(3 downto 0);
		carryOut, flagNegativo, flagZero, flagOverflow: out std_logic
	);
end fullAdder4bits;

architecture behavioral of fullAdder4bits is
	signal carry0, carry1, carry2, carry3, carry4: std_logic;
	signal a0, a1, a2, a3: std_logic;
	signal b0, b1, b2, b3: std_logic;
	signal result0, result1, result2, result3: std_logic;

	component fullAdder1bit
		port(
			entrada1, entrada2, carryIn: in std_logic;
			soma, carryOut: out std_logic
		);
	end component;
begin
	-- a e b poderiam ser transformados em vectors

	-- entrada1
	a0 <= entrada1(0);
	a1 <= entrada1(1);
	a2 <= entrada1(2);
	a3 <= entrada1(3);

	-- entrada 2
	b0 <= entrada2(0);
	b1 <= entrada2(1);
	b2 <= entrada2(2);
	b3 <= entrada2(3);

	carry0 <= carryIn;

	-- Importante: propagar o carry de um FA para o proximo COMENCANDO DO LSB
	bit0: fullAdder1bit port map(a0, b0, carry0, result0, carry1);
	bit1: fullAdder1bit port map(a1, b1, carry1, result1, carry2);
	bit2: fullAdder1bit port map(a2, b2, carry2, result2, carry3);
	bit3: fullAdder1bit port map(a3, b3, carry3, result3, carry4);

	carryOut <= carry4;

	soma(0) <= result0;
	soma(1) <= result1;
	soma(2) <= result2;
	soma(3) <= result3;

	flagNegativo <= result3;

	flagZero <= not(result0 or result1 or result2 or result3);

	flagOverflow <= carry3 xor carry4;
end behavioral;
