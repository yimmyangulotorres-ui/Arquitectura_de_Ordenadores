library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_00_59 is
end tb_counter_00_59;

architecture behavioral of tb_counter_00_59 is

    signal clk   : STD_LOGIC := '0';
    signal rst   : STD_LOGIC := '0';
    signal seg_u : STD_LOGIC_VECTOR(6 downto 0);
    signal seg_d : STD_LOGIC_VECTOR(6 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instancia del contador 00-59
    uut: entity work.counter_00_59
        port map (
            clk   => clk,
            rst   => rst,
            seg_u => seg_u,
            seg_d => seg_d
        );

    -- Generador de reloj
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Proceso de simulacion
    stim_proc: process
    begin

        -- Reiniciar contador
        rst <= '1';
        wait for 20 ns;

        -- Iniciar conteo
        rst <= '0';

        -- Simular hasta pasar de 59 a 00
        wait for 650 ns;

        -- Finalizar simulacion
        report "Simulacion finalizada"
            severity note;

        wait;

    end process;

end behavioral;
