library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity adder is
    Port (
        A, B, Cin : in STD_LOGIC;
        Cout, S : out STD_LOGIC);
end adder;

architecture Behavioral of adder is
    signal S1, S2, S3 : std_logic;
begin
    S1 <= A xor B;
    S2 <= Cin and S1;
    S3 <= A and B;
    S <= S1 xor Cin;
    Cout <= S2 or S3;
end Behavioral;