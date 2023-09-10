library IEEE;
use IEEE.std_logic_1164.all;

entity AND_Gate is
    port(x: in std_logic; y: in std_logic; z: out std_logic);
    end entity;

architecture peepeepoopoo of AND_Gate is 

begin
    z <= x and y;
end architecture;