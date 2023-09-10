library IEEE;
use IEEE.std_logic_1164.all;

entity decoder4x16 is
    port(a, b, c, d, enable: in std_logic;
    dec: out std_logic_vector(15 downto 0));
end entity;

architecture natsu of decoder4x16 is

    signal temp : std_logic_vector(3 downto 0);
    signal always_1: std_logic;
    signal n1: std_logic;
    signal n2: std_logic;

    component decoder2x4 is
        port(a, b, enable: in std_logic;
        dec_int: out std_logic_vector(3 downto 0));
    end component;

    component NOT_Gate is
        port(x: in std_logic; z: out std_logic);
        end component;

    begin

    always_1 <= '1';
    
    nn1: NOT_Gate
    port map(x=>c,z=>n1);

    nn2: NOT_Gate
    port map(x=>d,z=>n2);
    
    d1: decoder2x4
    port map(a=>a,b=>b,enable=>always_1,dec_int(3 downto 0)=>temp(3 downto 0));

    dd1: decoder2x4
    port map(a=>c,b=>d,enable=>temp(3),dec_int(3 downto 0)=>dec(15 downto 12));

    dd2: decoder2x4
    port map(a=>c,b=>n2,enable=>temp(2),dec_int(3 downto 0)=>dec(11 downto 8));

    dd3: decoder2x4
    port map(a=>n1,b=>d,enable=>temp(1),dec_int(3 downto 0)=>dec(7 downto 4));

    dd4: decoder2x4
    port map(a=>n1,b=>n2,enable=>temp(0),dec_int(3 downto 0)=>dec(3 downto 0));

end architecture;