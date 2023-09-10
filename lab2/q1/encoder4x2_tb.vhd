library IEEE;
use IEEE.std_logic_1164.all;

entity TestBenchEncoder4x2 is
    end entity;


architecture hehe of TestBenchEncoder4x2 is 

signal I: std_logic_vector (3 downto 0);
signal Y: std_logic_vector (1 downto 0);

component encoder4x2 is
    port(I: in std_logic_vector (3 downto 0);
    Y: out std_logic_vector(1 downto 0));
end component;

begin 

dut_instance: encoder4x2
port map(I=>I, Y=>Y);

process
begin

    for p in 3 downto 0 loop
        I(p) <= '1';
        wait for 10 ns;
        I(p) <= '0';

    end loop;

    end process;

end architecture;