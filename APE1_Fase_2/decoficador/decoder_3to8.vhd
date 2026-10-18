-- 1.2.3 Decodificador 3 a 8
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_3to8 is
    Port (
        A, B, C : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end decoder_3to8;

architecture behavioral of decoder_3to8 is
begin

    Y <= "00000001" when A & B & C = "000" else
         "00000010" when A & B & C = "001" else
         "00000100" when A & B & C = "010" else
         "00001000" when A & B & C = "011" else
         "00010000" when A & B & C = "100" else
         "00100000" when A & B & C = "101" else
         "01000000" when A & B & C = "110" else
         "10000000" when A & B & C = "111" else
         "00000000";

end behavioral;
