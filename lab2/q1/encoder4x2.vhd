library IEEE;
use IEEE.std_logic_1164.all;

entity encoder4x2 is
    port(I: in std_logic_vector (3 downto 0);
    Y: out std_logic_vector(1 downto 0));
end entity;

architecture akane of encoder4x2 is 

    component OR_Gate is 
    port(x: in std_logic; y: in std_logic; z: out std_logic);
    end component;

begin

oo1: OR_Gate
port map(x=>I(3),y=>I(2),z=>Y(1));

oo2: OR_Gate
port map(x=>I(3),y=>I(1),z=>Y(0));



end architecture;
