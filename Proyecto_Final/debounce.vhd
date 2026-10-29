-- debounce.vhd : 1.4.5 Antirrebote con contador de reloj
-- La salida cambia solo si la entrada permanece estable CNT_MAX+1 ciclos.
-- CNT_MAX=1_000_000 con reloj de 100 MHz ~ 10 ms.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    Generic ( CNT_MAX : integer := 1000000 );
    Port ( clk     : in  STD_LOGIC;
           btn_in  : in  STD_LOGIC;
           btn_out : out STD_LOGIC);
end debounce;

architecture behavioral of debounce is
    signal cnt     : integer range 0 to CNT_MAX := 0;
    signal btn_reg : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if btn_in /= btn_reg then
                if cnt = CNT_MAX then
                    btn_reg <= btn_in;
                    cnt     <= 0;
                else
                    cnt <= cnt + 1;
                end if;
            else
                cnt <= 0;
            end if;
        end if;
    end process;
    btn_out <= btn_reg;
end behavioral;
