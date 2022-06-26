library ieee;
use ieee.std_logic_1164.all;

entity circuitoPlaca is
	port(
		SW: in std_logic_vector(2 downto 0);                 -- Inputs and operador
		LED_RESULT: out std_logic_vector(7 downto 0);        -- Result e flags
		--HEX0, HEX4, HEX6: out std_logic_vector(0 to 6);    -- display 7seg
		CLOCK_50: in std_logic
	);
end circuitoPlaca;

architecture behavioral of circuitoPlaca is
	signal operador: std_logic_vector(2 downto 0);
	signal entrada1, entrada2: std_logic_vector(3 downto 0);
	signal result: std_logic_vector(3 downto 0);
	signal flagCarry, flagNegativo, flagZero, flagOverflow, ce, reset, clk: std_logic;
   	signal counter: std_logic_vector(7 downto 0);

    component contadorProfessor
		port(
			clk: in std_logic;
            counter: out std_logic_vector(7 downto 0)
		);
	end component;

	---------- Para display 7seg do labsland ---------
	-- component mapeadorSeteSegmentos
	--	port(
	--		entrada: in std_logic_vector(3 downto 0);
	--		numeroDisplay: out std_logic_vector(0 to 6)
	--	);
	--end component;

	component ula
		port(
			entrada1, entrada2: in std_logic_vector(3 downto 0);
			operador: in std_logic_vector(2 downto 0);
			result: out std_logic_vector(3 downto 0);
			flagCarry, flagNegativo, flagZero, flagOverflow: out std_logic
		);
	end component;


begin
	-------- Para utilizacao no labsland ---------
	--entrada1 <= "00" & SW(17 downto 16);
	--entrada1 <= SW(17 downto 14);
	--entrada2 <= SW(12 downto 9);
	--entrada2 <= "00" & SW(13 downto 12);

	clk <= CLOCK_50;
	ce <= '1';
	reset <= '0';
	instanciaContadora: contadorProfessor port map(clk, counter);
	entrada1 <= counter(7 downto 4);
	entrada2 <= counter(3 downto 0);
	operador <= SW(2 downto 0);

	-- Utilizado para o display 7 seg labsland
	-- entrada1Display: mapeadorSeteSegmentos port map(entrada1, HEX6);
	-- entrada2Display: mapeadorSeteSegmentos port map(entrada2, HEX4);
	-- resultDisplay: mapeadorSeteSegmentos port map(result, HEX0);

	instanciaUla: ula port map(entrada1, entrada2, operador, result, flagCarry, flagNegativo, flagZero, flagOverflow);

	-------- mapeamento dos resultados e flags nos leds -----------
    LED_RESULT(7) <= flagNegativo;
	LED_RESULT(6) <= flagZero;
	LED_RESULT(5) <= flagCarry;
	LED_RESULT(4) <= flagOverflow;
	LED_RESULT(3 downto 0) <= result;

	--------- Utilizar para checar o comportamento do contador nos leds ------------
   	-- LED_RESULT(3 downto 0) <= entrada1;
	-- LED_RESULT(7 downto 4) <= entrada2;

end behavioral;