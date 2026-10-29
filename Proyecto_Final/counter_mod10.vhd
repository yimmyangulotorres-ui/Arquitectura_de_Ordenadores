-- counter_mod10.vhd : Contador sincrono modulo 10 (0-9) con enable y acarreo
-- Es la version de la FASE 3 ampliada con 'en' y 'carry'.
-- 'en' tiene valor por defecto '1' y 'carry' puede quedar sin conectar,
-- por lo que sigue siendo compatible con la instanciacion de la FASE 3.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_mod10 is
    Port ( clk   : in  STD_LOGIC;
           rst   : in  STD_LOGIC;
           en    : in  STD_LOGIC := '1';
           count : out STD_LOGIC_VECTOR(3 downto 0);
           carry : out STD_LOGIC);
end counter_mod10;

architecture behavioral of counter_mod10 is
    signal cnt : unsigned(3 downto 0) := "0000";
begin
    process(clk, rst)
    begin
        if rst = '1' then
            cnt <= "0000";
        elsif rising_edge(clk) then
            if en = '1' then
                if cnt = 9 then
                    cnt <= "0000";
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(cnt);
    -- acarreo: la proxima transicion con en='1' pasa de 9 a 0
    carry <= '1' when (cnt = 9 and en = '1') else '0';
end behavioral;
