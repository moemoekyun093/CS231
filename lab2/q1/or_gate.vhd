library IEEE;
use IEEE.std_logic_1164.all;

entity OR_Gate is
    port(x: in std_logic; y: in std_logic; z: out std_logic);
    end entity;

architecture peepeepoopoo of OR_Gate is 

begin
    z <= x or y;
end architecture;