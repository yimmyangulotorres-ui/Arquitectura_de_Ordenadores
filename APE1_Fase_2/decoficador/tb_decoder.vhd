-- 1.2.3 Testbench Decodificador 3 a 8
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_decoder_3to8 is
end tb_decoder_3to8;

architecture sim of tb_decoder_3to8 is

    signal A, B, C : STD_LOGIC := '0';
    signal Y : STD_LOGIC_VECTOR(7 downto 0);

begin

    uut: entity work.decoder_3to8
        port map (
            A => A,
            B => B,
            C => C,
            Y => Y
        );

    process
        variable entradas : STD_LOGIC_VECTOR(2 downto 0);
        variable esperado : STD_LOGIC_VECTOR(7 downto 0);
    begin

        for i in 0 to 7 loop

            entradas := STD_LOGIC_VECTOR(
                TO_UNSIGNED(i, 3)
            );

            A <= entradas(2);
            B <= entradas(1);
            C <= entradas(0);

            wait for 10 ns;

            esperado := (others => '0');
            esperado(i) := '1';

            assert Y = esperado
                report "ERROR: salida incorrecta"
                severity error;

        end loop;

        report "Simulacion finalizada correctamente"
            severity note;

        wait;
    end process;

end sim;
