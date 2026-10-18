-- 1.3.1 Contador Síncrono Módulo 10
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_mod10 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0));
end counter_mod10;

architecture Behavioral of counter_mod10 is
    signal cnt : unsigned(3 downto 0) := "0000";
begin
    process(clk, rst)
    begin
        if rst = '1' then
            cnt <= "0000";
        elsif rising_edge(clk) then
            if cnt = 9 then
                cnt <= "0000";
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
        
    count <= std_logic_vector(cnt);
end Behavioral;

