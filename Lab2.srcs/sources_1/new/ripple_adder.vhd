library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ripple_adder is
    Port (
        A, B: in std_logic_vector(3 downto 0);
        C0: in std_logic;
        C4: out std_logic;
        S: out std_logic_vector(3 downto 0)
    );
end ripple_adder;

architecture structural of ripple_adder is
    signal C1, C2, C3 : std_logic;
begin
    FA1 : entity work.adder
        port map(
            A => A(0),
            B => B(0),
            Cin => C0,
            Cout => C1,
            S => S(0)
        );
    FA2 : entity work.adder
        port map(
            A => A(1),
            B => B(1),
            Cin => C1,
            Cout => C2,
            S => S(1)
        );
    FA3 : entity work.adder
        port map(
            A => A(2),
            B => B(2),
            Cin => C2,
            Cout => C3,
            S => S(2)
        );
    FA4 : entity work.adder
        port map(
            A => A(3),
            B => B(3),
            Cin => C3,
            Cout => C4,
            S => S(3)
        );
end structural;