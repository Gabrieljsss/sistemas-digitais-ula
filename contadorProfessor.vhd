library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity contadorProfessor is
    generic(t_max : integer := 100000000); 
    port(clk: in std_logic;
    counter: out unsigned(7 downto 0) := "00000000"
    );
end contadorProfessor;

architecture behavioral of contadorProfessor is

signal counter_temp: unsigned(7 downto 0) := "00000000";

begin
    counter_label: process (clk)
    variable slow_clock: integer range t_max downto 0 := 0;
    begin
       if (clk'event and clk='1') then
        if (slow_clock <= t_max) then
            slow_clock := slow_clock + 1;
        else
            counter_temp <= counter_temp + 1;
            slow_clock := 0;
        
        end if;
       end if;
    end process;
    counter <= counter_temp;
end behavioral;
