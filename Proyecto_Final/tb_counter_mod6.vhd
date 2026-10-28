library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_mod6 is
end tb_counter_mod6;

architecture simulation of tb_counter_mod6 is
    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '1';
    signal en    : STD_LOGIC := '0';
    signal count : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: entity work.counter_mod6
        port map (
            clk   => clk,
            rst   => rst,
            en    => en,
            count => count
        );
    -- Reloj con periodo de 10 ns
    clk <= not clk after 5 ns;
    process
    begin
        rst <= '1';
        en  <= '0';
        wait for 12 ns;

        rst <= '0';
        en  <= '1';
        wait for 60 ns;
        en <= '0';
        wait for 20 ns;

        en <= '1';
        wait for 50 ns;

        wait;
    end process;
end simulation;