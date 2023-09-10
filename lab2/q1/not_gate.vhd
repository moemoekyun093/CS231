library IEEE;
use IEEE.std_logic_1164.all;

entity NOT_Gate is
    port(x: in std_logic; z: out std_logic);
    end entity;

architecture peepeepoopoo of NOT_Gate is 

begin
    z <= not x;
end architecture;