
-- 1.2.2 Testbench Multiplexor 4:1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mux_4to1 is
end tb_mux_4to1;

architecture sim of tb_mux_4to1 is

    signal D0, D1, D2, D3 : STD_LOGIC := '0';
    signal S : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal Y : STD_LOGIC;

begin

    uut: entity work.mux_4to1
        port map (
            D0 => D0,
            D1 => D1,
            D2 => D2,
            D3 => D3,
            S  => S,
            Y  => Y
        );

    process
        variable datos : STD_LOGIC_VECTOR(3 downto 0);
        variable esperado : STD_LOGIC;
    begin

        for i in 0 to 15 loop

            datos := STD_LOGIC_VECTOR(
                TO_UNSIGNED(i, 4)
            );

            D0 <= datos(0);
            D1 <= datos(1);
            D2 <= datos(2);
            D3 <= datos(3);

            for j in 0 to 3 loop

                S <= STD_LOGIC_VECTOR(
                    TO_UNSIGNED(j, 2)
                );

                wait for 10 ns;

                case j is
                    when 0 => esperado := datos(0);
                    when 1 => esperado := datos(1);
                    when 2 => esperado := datos(2);
                    when 3 => esperado := datos(3);
                    when others => esperado := '0';
                end case;

                assert Y = esperado
                    report "ERROR: salida incorrecta"
                    severity error;

            end loop;

        end loop;

        report "Simulacion finalizada correctamente"
            severity note;

        wait;
    end process;

end sim;
