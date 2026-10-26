library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_mod6 is
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        en    : in  STD_LOGIC;
        count : out STD_LOGIC_VECTOR(3 downto 0)
    );
end counter_mod6;

architecture behavioral of counter_mod6 is
    signal value : UNSIGNED(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                value <= (others => '0');
            elsif en = '1' then
                if value = 5 then
                    value <= (others => '0');
                else
                    value <= value + 1;
                end if;
            end if;
        end if;
    end process;

    count <= STD_LOGIC_VECTOR(value);
end behavioral;