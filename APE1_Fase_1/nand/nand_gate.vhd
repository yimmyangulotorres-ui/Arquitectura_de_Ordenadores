library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate is
    port (
        A : in  STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end nand_gate;

architecture Behavioral of nand_gate is
begin
    Y <= NOT (A AND B);
end Behavioral;
