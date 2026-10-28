library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_display is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           SEG : inout STD_LOGIC_VECTOR (6 downto 0));
end counter_display;

architecture Behavioral of counter_display is
    -- "Cable" interno que une la salida del contador con la entrada del decodificador
    signal cnt_s : STD_LOGIC_VECTOR(3 downto 0);
begin
    u_counter: entity work.counter_mod10
        port map (clk => clk, rst => rst, count => cnt_s);

    u_decoder: entity work.bcd_7seg
        port map (BCD => cnt_s, SEG => SEG);
end Behavioral;

