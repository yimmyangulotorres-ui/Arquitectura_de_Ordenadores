--testbench para el contador modulo 1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_mod10 is
end tb_counter_mod10;

architecture sim of tb_counter_mod10 is
    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '1';
    signal count : STD_LOGIC_VECTOR(3 downto 0);
begin

    uut: entity work.counter_mod10
        port map (clk => clk, rst => rst, count => count);

    -- Reloj de periodo 20 ns
    clk_process: process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;

    -- Reset al inicio y luego el contador corre solo
    stim: process
    begin
        rst <= '1'; wait for 25 ns;
        rst <= '0'; wait for 300 ns;
        wait;
    end process;

end sim;
