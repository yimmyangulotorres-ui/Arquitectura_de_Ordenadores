library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_display is
end tb_counter_display;

architecture sim of tb_counter_display is
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '1';
    signal SEG : STD_LOGIC_VECTOR(6 downto 0);
begin

    uut: entity work.counter_display
        port map (clk => clk, rst => rst, SEG => SEG);

    -- Reloj de periodo 20 ns
    clk_process: process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;

    stim: process
    begin
        rst <= '1'; wait for 25 ns;
        rst <= '0'; wait for 10 ns;      -- t = 35 ns, ya conto el 1

        assert (SEG = "1111001") report "Error en 1" severity error;
        wait for 20 ns;
        assert (SEG = "0100100") report "Error en 2" severity error;
        wait for 20 ns;
        assert (SEG = "0110000") report "Error en 3" severity error;
        wait for 20 ns;
        assert (SEG = "0011001") report "Error en 4" severity error;
        wait for 20 ns;
        assert (SEG = "0010010") report "Error en 5" severity error;
        wait for 20 ns;
        assert (SEG = "0000010") report "Error en 6" severity error;
        wait for 20 ns;
        assert (SEG = "1111000") report "Error en 7" severity error;
        wait for 20 ns;
        assert (SEG = "0000000") report "Error en 8" severity error;
        wait for 20 ns;
        assert (SEG = "0010000") report "Error en 9" severity error;
        wait for 20 ns;
        assert (SEG = "1000000") report "Error: no reinicia a 0" severity error;

        wait;
    end process;
    
end sim;
