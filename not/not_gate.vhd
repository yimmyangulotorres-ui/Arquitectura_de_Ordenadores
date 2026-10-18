library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate is
    port (
        A : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end not_gate;

architecture Behavioral of not_gate is
begin
    Y <= NOT A;
end Behavioral;
