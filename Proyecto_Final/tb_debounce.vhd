-- tb_debounce.vhd : filtra rebotes cortos y acepta cambios estables (CNT_MAX reducido a 5)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_debounce is
end tb_debounce;

architecture sim of tb_debounce is
    constant T : time := 20 ns;
    signal clk     : STD_LOGIC := '0';
    signal btn_in  : STD_LOGIC := '0';
    signal btn_out : STD_LOGIC;
    signal done    : boolean := false;
begin
    uut: entity work.debounce
        generic map (CNT_MAX => 5)
        port map (clk => clk, btn_in => btn_in, btn_out => btn_out);

    clk_proc: process
    begin
        while not done loop
            clk <= '0'; wait for T/2;
            clk <= '1'; wait for T/2;
        end loop;
        wait;
    end process;

    stim: process
    begin
        btn_in <= '0'; wait for 3*T;

        -- glitch corto en alto: debe ser ignorado
        btn_in <= '1'; wait for 3*T;
        btn_in <= '0'; wait for 3*T;
        assert btn_out = '0' report "debounce: no filtro el glitch en alto" severity error;

        -- pulsacion real con rebote inicial
        btn_in <= '1'; wait for T;
        btn_in <= '0'; wait for T;
        btn_in <= '1'; wait for 20*T;
        assert btn_out = '1' report "debounce: no acepto la pulsacion" severity error;

        -- glitch corto en bajo: debe ser ignorado
        btn_in <= '0'; wait for 3*T;
        btn_in <= '1'; wait for 3*T;
        assert btn_out = '1' report "debounce: no filtro el glitch en bajo" severity error;

        -- liberacion real
        btn_in <= '0'; wait for 20*T;
        assert btn_out = '0' report "debounce: no acepto la liberacion" severity error;

        report "tb_debounce: FIN OK" severity note;
        done <= true;
        wait;
    end process;
end sim;
