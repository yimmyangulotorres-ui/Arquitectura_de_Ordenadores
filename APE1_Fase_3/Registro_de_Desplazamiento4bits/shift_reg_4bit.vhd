-- 1.3.3 Registro de Desplazamiento 4 bits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_4bit is
    Port ( clk       : in  STD_LOGIC;
           rst       : in  STD_LOGIC;
           serial_in : in  STD_LOGIC;
           q_out     : out STD_LOGIC_VECTOR(3 downto 0));
end shift_reg_4bit;

architecture behavioral of shift_reg_4bit is
    signal reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(clk, rst)
    begin
        if rst = '1' then
            reg <= "0000";
        elsif rising_edge(clk) then
            reg <= serial_in & reg(3 downto 1);
        end if;
    end process;
    q_out <= reg;
end behavioral;
