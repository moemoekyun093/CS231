library IEEE;
use IEEE.std_logic_1164.all;

entity TestBenchAnd is
    end entity;


architecture hehe of TestBenchAnd is 

signal x, y, z: std_logic;

component AND_Gate is 
port(x: in std_logic; y: in std_logic; z: out std_logic);
end component;

begin 

dut_instance: AND_Gate
port map(x => x, y => y, z=> z);

process
begin

    x <= '0';
    y <= '0';
    wait for 1 ns;

    x <= '0';
    y <= '1';
    wait for 1 ns;

    x <= '1';
    y <= '0';
    wait for 1 ns;
    
    x <= '1';
    y <= '1';
    wait for 1 ns;

    end process;

end architecture;