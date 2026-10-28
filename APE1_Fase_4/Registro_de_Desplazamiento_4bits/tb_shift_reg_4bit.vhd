library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_shift_reg_4bit is
end tb_shift_reg_4bit;

architecture sim of tb_shift_reg_4bit is
    signal clk       : STD_LOGIC := '0';
    signal rst       : STD_LOGIC := '1';
    signal serial_in : STD_LOGIC := '0';
    signal q_out     : STD_LOGIC_VECTOR(3 downto 0);
begin

    uut: entity work.shift_reg_4bit
        port map (clk => clk, rst => rst, serial_in => serial_in, q_out => q_out);

    -- Reloj de periodo 20 ns
    clk_process: process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;

    -- Se envia el patron: 1, 1, 0, 1 (un bit por ciclo de reloj)
    stim: process
    begin
        rst <= '1'; serial_in <= '0'; wait for 25 ns;
        rst <= '0';

        serial_in <= '1'; wait for 20 ns;  -- bit 1, entra en el flanco de 30 ns
        serial_in <= '1'; wait for 20 ns;  -- bit 2, flanco de 50 ns
        serial_in <= '0'; wait for 20 ns;  -- bit 3, flanco de 70 ns
        serial_in <= '1'; wait for 20 ns;  -- bit 4, flanco de 90 ns

        assert (q_out = "1011")
            report "Error: el patron 1011 no aparece en q_out" severity error;

        serial_in <= '0'; wait for 100 ns; -- se siguen metiendo ceros
        wait;
    end process;

end sim;
