-- 1.2.1 Multiplexor 4:1
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4to1 is
    Port ( D0, D1, D2, D3 : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR(1 downto 0);
           Y : out STD_LOGIC);
end mux_4to1;

architecture behavioral of mux_4to1 is
begin
    with S select
        Y <= D0 when "00",
             D1 when "01",
             D2 when "10",
             D3 when "11",
             '0' when others;
end behavioral;
