----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 05:12:53 PM
-- Design Name: 
-- Module Name: my_alu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
    Port ( A, B, OPCODE : in std_logic_vector(3 downto 0);
         RES : out std_logic_vector(3 downto 0);
         clk: in std_logic);
end my_alu;

architecture Behavioral of my_alu is
    signal comp_out : std_logic_vector(3 downto 0) := (others=>'0');
    signal comp : std_logic;
    signal shift_right_arithmetic_A :std_logic_vector(3 downto 0);
begin
    comp <= '1' when (A > B) else '0';
    shift_right_arithmetic_A <=std_logic_vector(shift_right(unsigned(A),1));
    process(clk)

    
    begin
        if rising_edge(clk) then
            case comp is
                when '1' => comp_out <="0001";
                when '0' => comp_out <="0000";
                when others => comp_out <= (others =>'0');
            end case;
            case OPCODE is
                when "0000" => RES <= A + B;
                when "0001" => RES <= A-B;
                when "0010" => RES <= A+1;
                when "0011" => RES <= A-1;
                when "0100" => RES <= 0-A;
                when "0101" => RES <= comp_out;
                when "0110" => RES <= A(2 downto 0) & '0'; --6
                when "0111" => RES <= '0' & A(3 downto 1); -- 7
                when "1000" => RES <= A(3) & shift_right_arithmetic_A(2 downto 0); -- 8
                when "1001" => RES <= not A;
                when "1010" => RES <= A and B;
                when "1011" => RES <= A or B;
                when "1100" => RES <= A xor B;
                when "1101" => RES <= A xnor B;
                when "1110" => RES <= A nand B;
                when "1111" => RES <= A nor B;
                when others => RES <= (others=>'0');
            end case;
        end if;
    end process;
end Behavioral;