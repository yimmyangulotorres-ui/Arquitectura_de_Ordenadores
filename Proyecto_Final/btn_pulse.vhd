-- btn_pulse.vhd : sincronizador (2 FF) + antirrebote + detector de flanco de subida
-- Entrega UN pulso de un ciclo de reloj por cada pulsacion del boton.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn_pulse is
    Generic ( CNT_MAX : integer := 1000000 );
    Port ( clk    : in  STD_LOGIC;
           btn_in : in  STD_LOGIC;
           pulse  : out STD_LOGIC);
end btn_pulse;

architecture structural of btn_pulse is
    signal s1, s2 : STD_LOGIC := '0';   -- sincronizador
    signal clean  : STD_LOGIC;
    signal prev   : STD_LOGIC := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            s1   <= btn_in;
            s2   <= s1;
            prev <= clean;
        end if;
    end process;

    u_deb: entity work.debounce
        generic map (CNT_MAX => CNT_MAX)
        port map (clk => clk, btn_in => s2, btn_out => clean);

    pulse <= clean and not prev;
end structural;
