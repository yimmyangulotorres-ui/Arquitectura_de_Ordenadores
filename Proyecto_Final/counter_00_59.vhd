-- counter_00_59.vhd : 1.4.3 / 1.4.4 Nucleo del contador 00-59 con decodificadores
-- units_bcd / tens_bcd se exponen solo para verificar en el testbench.
-- 'en' vale '1' por defecto (cuenta en cada flanco de reloj).
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_00_59 is
    Port ( clk       : in  STD_LOGIC;
           rst       : in  STD_LOGIC;
           en        : in  STD_LOGIC := '1';
           units_bcd : out STD_LOGIC_VECTOR(3 downto 0);
           tens_bcd  : out STD_LOGIC_VECTOR(3 downto 0);
           seg_u     : out STD_LOGIC_VECTOR(6 downto 0);
           seg_d     : out STD_LOGIC_VECTOR(6 downto 0));
end counter_00_59;

architecture structural of counter_00_59 is
    signal units_s : STD_LOGIC_VECTOR(3 downto 0);
    signal tens_s  : STD_LOGIC_VECTOR(3 downto 0);
    signal carry : STD_LOGIC;
begin
    -- Unidades (modulo 10): cuenta cuando en='1', genera acarreo en 9
    u_units: entity work.counter_mod10
        port map (clk => clk, rst => rst, en => en, count => units_s, carry => carry);

    -- Decenas (modulo 6): se incrementa solo con el acarreo de las unidades
    u_tens: entity work.counter_mod6
        port map (clk => clk, rst => rst, en => carry, count => tens_s);

    -- Decodificadores BCD a 7 segmentos
    u_dec_u: entity work.bcd_7seg port map (BCD => units_s, SEG => seg_u);
    u_dec_d: entity work.bcd_7seg port map (BCD => tens_s,  SEG => seg_d);

end structural;
