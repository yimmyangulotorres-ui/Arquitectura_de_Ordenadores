library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_not is
end tb_not;

architecture sim of tb_not is
    signal A : STD_LOGIC := '0';
    signal Y : STD_LOGIC;
begin
    uut: entity work.not_gate
        port map (
            A => A,
            Y => Y
        );

    process
    begin
        A <= '0';
        wait for 10 ns;

        A <= '1';
        wait for 10 ns;

         A <= '0';
        wait for 10 ns;
        
         A <= '1';
        wait for 10 ns;

        wait;
    end process;
end sim;

    