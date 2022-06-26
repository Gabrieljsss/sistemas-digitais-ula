library ieee;
use ieee.std_logic_1164.all;

entity mapeadorSeteSegmentos is
	port(
		entrada: in std_logic_vector(3 downto 0);
		numeroDisplay: out std_logic_vector(0 to 6)
	);
end mapeadorSeteSegmentos;

architecture behavioral of mapeadorSeteSegmentos is
begin
	-- Acendo os segmentos adequados para cada entrada
	with entrada select
		numeroDisplay <= "0000001" when "0000",
			"1001111" when "0001",
			"0010010" when "0010",
			"0000110" when "0011",
			"1001100" when "0100",
			"0100100" when "0101",
			"0100000" when "0110",
			"0001111" when "0111",
  			"0000000" when "1000",
			"0000100" when "1001",
			"0001000" when "1010",
			"1100000" when "1011",
			"0110001" when "1100",
			"1000010" when "1101",
			"0110000" when "1110",
			"0111000" when "1111",
			"1111111" when others;
end behavioral;
