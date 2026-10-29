-- clk_tick.vhd : generador de habilitacion periodica (un pulso cada DIV ciclos)
-- DIV=100_000_000 con reloj de 100 MHz -> 1 Hz
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_tick is
    Generic ( DIV : positive := 100000000 );
    Port ( clk  : in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           tick : out STD_LOGIC);
end clk_tick;

architecture behavioral of clk_tick is
    signal cnt : integer range 0 to DIV-1 := 0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            cnt <= 0;
        elsif rising_edge(clk) then
            if cnt = DIV-1 then
                cnt <= 0;
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    tick <= '1' when cnt = DIV-1 else '0';
end behavioral;
