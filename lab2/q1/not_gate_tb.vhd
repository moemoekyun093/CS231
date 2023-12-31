library IEEE;
use IEEE.std_logic_1164.all;

entity TestBenchNot is
    end entity;


architecture hehe of TestBenchNot is 

signal x, z: std_logic;

component NOT_Gate is 
port(x: in std_logic; z: out std_logic);
end component;

begin 

dut_instance: NOT_Gate
port map(x => x, z=> z);

process
begin

    x <= '0';
    wait for 1 ns;

    x <= '1';
    wait for 1 ns;

    end process;

end architecture;