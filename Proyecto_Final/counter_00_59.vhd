library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_00_59 is
    Port (
        clk   : in STD_LOGIC;
        rst   : in STD_LOGIC;
        seg_u : out STD_LOGIC_VECTOR(6 downto 0);
        seg_d : out STD_LOGIC_VECTOR(6 downto 0)
    );
end counter_00_59;

architecture structural of counter_00_59 is

    signal unidades : STD_LOGIC_VECTOR(3 downto 0);
    signal decenas  : STD_LOGIC_VECTOR(3 downto 0);
    signal carry    : STD_LOGIC;

begin

    -- Contador de unidades
    u_units: entity work.counter_mod10
        port map (
            clk   => clk,
            rst   => rst,
            count => unidades
        );

    -- Senal de acarreo
    carry <= '1' when unidades = "1001" else '0';

    -- Contador de decenas
    u_tens: entity work.counter_mod6
        port map (
            clk   => clk,
            rst   => rst,
            en    => carry,
            count => decenas
        );

    -- Decodificador de unidades
    u_dec_u: entity work.bcd_7seg
        port map (
            BCD => unidades,
            SEG => seg_u
        );

    -- Decodificador de decenas
    u_dec_d: entity work.bcd_7seg
        port map (
            BCD => decenas,
            SEG => seg_d
        );

end structural;
