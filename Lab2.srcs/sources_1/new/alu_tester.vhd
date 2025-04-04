----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2024 06:20:12 PM
-- Design Name: 
-- Module Name: alu_tester - Behavioral
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2024 08:53:16 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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
use ieee.numeric_std.all;
entity debounce is
    Port (
        btn : in std_logic;
        clk: in std_logic;
        dbnc : out std_logic);
end debounce;

architecture Behavioral of debounce is


    signal counter : std_logic_vector(21 downto 0);
begin

    debounce: process(clk)
    begin
        if rising_edge(clk)then
            if btn = '1' then

                -- Wait 20ms = wait 2.5million cycles
                if (unsigned(counter) > 2499999) then
                    dbnc <= '1';

                else
                    counter <= std_logic_vector(unsigned(counter) + 1);

                end if;

            else
                dbnc <='0';
                counter <= (others => '0');
            end if;
        end if;
    end process;


end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tester is
  Port (clk : in std_logic;
        sw : in std_logic_vector(3 downto 0);
        btn : in std_logic_vector(3 downto 0);
        led: out std_logic_vector(3 downto 0));
end alu_tester;

architecture Behavioral of alu_tester is
    component my_alu
    Port ( A, B, OPCODE : in std_logic_vector(3 downto 0);
         RES : out std_logic_vector(3 downto 0);
         clk: std_logic);
    end component my_alu;
    
    component debounce is
    Port (
        btn : in std_logic;
        clk: in std_logic;
        dbnc : out std_logic);
    end component debounce;

    signal A,B,OPCODE : std_logic_vector(3 downto 0):=(others=>'0');
    signal dbnc_btn: std_logic_vector(3 downto 0):=(others=>'0');
begin
    
    alu: my_alu
        port map(
            clk=>clk,
            A=>A,
            B =>B,
            OPCODE=>OPCODE,
            RES=>led
            );
            
            
    deb0: debounce
        port map(
            clk=> clk,
            btn=>btn(0),
            dbnc=>dbnc_btn(0)
        );
    deb1: debounce
        port map(
            clk=> clk,
            btn=>btn(1),
            dbnc=>dbnc_btn(1)
        );
    deb2: debounce
        port map(
            clk=> clk,
            btn=>btn(2),
            dbnc=>dbnc_btn(2)
        );
    deb3: debounce
        port map(
            clk=> clk,
            btn=>btn(3),
            dbnc=>dbnc_btn(3)
        );    
        
    
    loader: process(clk)
    begin
        if rising_edge(clk) then
            case dbnc_btn is
                when "0001" => B <= sw;
                when "0010" => A <= sw;
                when "0100" => OPCODE <=sw;
                when "1000" => OPCODE <=(others=>'0'); A <=(others=>'0'); B <=(others=>'0');
                when others => NULL;
            end case;
        end if;
    end process loader;
    

end Behavioral;