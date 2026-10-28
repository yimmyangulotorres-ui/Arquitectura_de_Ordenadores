library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_bcd_7seg is
end tb_bcd_7seg;
architecture sim of tb_bcd_7seg is

    signal BCD : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal SEG : STD_LOGIC_VECTOR(6 downto 0);

begin
    uut: entity work.bcd_7seg
        port map (
            BCD => BCD,
            SEG => SEG
        );
    process
        variable esperado : STD_LOGIC_VECTOR(6 downto 0);
    begin
        for i in 0 to 15 loop
            BCD <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4));
            wait for 10 ns;
            case i is
                when 0  => esperado := "1000000";
                when 1  => esperado := "1111001";
                when 2  => esperado := "0100100";
                when 3  => esperado := "0110000";
                when 4  => esperado := "0011001";
                when 5  => esperado := "0010010";
                when 6  => esperado := "0000010";
                when 7  => esperado := "1111000";
                when 8  => esperado := "0000000";
                when 9  => esperado := "0010000";
                when others => esperado := "1111111";
            end case;

            assert SEG = esperado
                report "ERROR: salida incorrecta para BCD = " &
                       INTEGER'IMAGE(i)
                severity error;
        end loop;
        report "Simulacion finalizada correctamente"
            severity note;
        wait;
    end process;
end sim;
