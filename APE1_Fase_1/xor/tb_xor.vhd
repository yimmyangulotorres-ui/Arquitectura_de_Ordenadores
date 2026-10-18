library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_xor is
end tb_xor;

architecture sim of tb_xor is
    signal A : STD_LOGIC := '0';
    signal B : STD_LOGIC := '0';
    signal Y : STD_LOGIC;
begin
    uut: entity work.xor_gate
        port map (
            A => A,
            B => B,
            Y => Y
        );

    process
    begin
        A <= '0'; B <= '0';
        wait for 10 ns;

        A <= '0'; B <= '1';
        wait for 10 ns;

        A <= '1'; B <= '0';
        wait for 10 ns;

        A <= '1'; B <= '1';
        wait for 10 ns;

        wait;
    end process;
end sim;
