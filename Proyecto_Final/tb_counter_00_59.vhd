-- tb_counter_00_59.vhd : verifica 00,01,...,59,00 (dos vueltas), enable, displays y reset asincrono
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_counter_00_59 is
end tb_counter_00_59;

architecture sim of tb_counter_00_59 is
    constant T : time := 20 ns;
    signal clk       : STD_LOGIC := '0';
    signal rst       : STD_LOGIC := '1';
    signal en        : STD_LOGIC := '1';
    signal units_bcd : STD_LOGIC_VECTOR(3 downto 0);
    signal tens_bcd  : STD_LOGIC_VECTOR(3 downto 0);
    signal seg_u     : STD_LOGIC_VECTOR(6 downto 0);
    signal seg_d     : STD_LOGIC_VECTOR(6 downto 0);
    -- decodificadores de referencia para comparar los displays
    signal exp_u, exp_d         : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal ref_seg_u, ref_seg_d : STD_LOGIC_VECTOR(6 downto 0);
    signal done : boolean := false;
begin
    uut: entity work.counter_00_59
        port map (clk => clk, rst => rst, en => en,
                  units_bcd => units_bcd, tens_bcd => tens_bcd,
                  seg_u => seg_u, seg_d => seg_d);

    ref_u: entity work.bcd_7seg port map (BCD => exp_u, SEG => ref_seg_u);
    ref_d: entity work.bcd_7seg port map (BCD => exp_d, SEG => ref_seg_d);

    clk_proc: process
    begin
        while not done loop
            clk <= '0'; wait for T/2;
            clk <= '1'; wait for T/2;
        end loop;
        wait;
    end process;

    stim: process
        variable v : integer;
    begin
        rst <= '1';
        wait for 45 ns;
        rst <= '0';
        wait for 1 ns;
        assert unsigned(units_bcd) = 0 and unsigned(tens_bcd) = 0
            report "00_59: no inicia en 00" severity error;

        -- 125 cuentas: 00..59, 00..59, 00..05 (verifica el 59 -> 00 dos veces)
        for k in 1 to 125 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            v := k mod 60;
            exp_u <= std_logic_vector(to_unsigned(v mod 10, 4));
            exp_d <= std_logic_vector(to_unsigned(v / 10, 4));
            wait for 1 ns;
            assert unsigned(units_bcd) = (v mod 10) and unsigned(tens_bcd) = (v / 10)
                report "00_59: esperado " & integer'image(v) & " en cuenta " & integer'image(k)
                severity error;
            assert seg_u = ref_seg_u and seg_d = ref_seg_d
                report "00_59: display incorrecto en valor " & integer'image(v)
                severity error;
        end loop;

        -- enable = 0 congela ambos contadores
        v := 125 mod 60;
        en <= '0';
        wait for 15*T;
        assert unsigned(units_bcd) = (v mod 10) and unsigned(tens_bcd) = (v / 10)
            report "00_59: cambio con en=0" severity error;
        en <= '1';

        -- reset asincrono
        wait until rising_edge(clk);
        wait for 1 ns;
        rst <= '1';
        wait for 3 ns;
        assert unsigned(units_bcd) = 0 and unsigned(tens_bcd) = 0
            report "00_59: reset asincrono fallo" severity error;
        rst <= '0';
        wait for 5 ns;

        report "tb_counter_00_59: FIN OK (secuencia 00-59 verificada)" severity note;
        done <= true;
        wait;
    end process;
end sim;
