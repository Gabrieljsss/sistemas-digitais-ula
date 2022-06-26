library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity comparador is
    Port (       
           a: in std_logic_vector(3 downto 0); -- input 4-bit 
           b: in std_logic_vector(3 downto 0); -- input 4-bit
	   resultado: out std_logic_vector(3 downto 0) 
     );
end comparador;
architecture behavioral of comparador is
signal auxiliar1,auxiliar2 : std_logic; 

begin

-- a = b
auxiliar1 <= (a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and (a(0) xnor b(0));

-- a > b
auxiliar2 <= ((not a(3)) and b(3)) or ((a(3) xnor b(3)) and (not b(2)) and a(2)) or ((a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and (not b(0)) and a(0));

resultado (0) <=   auxiliar1; -- a = b 
resultado (1) <= (auxiliar1 nor auxiliar2); -- a < b
resultado (2) <= auxiliar2; -- a > b
resultado (3) <= '0';

end behavioral;
