library IEEE;
use IEEE.std_logic_1164.all;

entity decoder2x4 is
    port(a, b, enable: in std_logic;
    dec_int: out std_logic_vector(3 downto 0));
end entity;

architecture midori of decoder2x4 is 

    signal n1: std_logic;
    signal n2: std_logic;
    signal wfb1: std_logic;
    signal wfb2: std_logic;
    signal wfb3: std_logic;
    signal wfb4: std_logic;

    component AND_Gate is 
    port(x: in std_logic; y: in std_logic; z: out std_logic);
    end component;

    component NOT_Gate is
    port(x: in std_logic; z: out std_logic);
    end component;

    begin

    i1: NOT_Gate
    port map(x=>a,z=>n1);
    i2: NOT_Gate
    port map(x=>b,z=>n2);

    a1: AND_Gate
    port map(x=>a,y=>b,z=>wfb1);
    aa1: AND_Gate
    port map(x=>wfb1,y=>enable,z=>dec_int(3));


    a2: AND_Gate
    port map(x=>a,y=>n2,z=>wfb2);
    aa2: AND_Gate
    port map(x=>wfb2,y=>enable,z=>dec_int(2));


    a3: AND_Gate
    port map(x=>n1,y=>b,z=>wfb3);
    aa3: AND_Gate
    port map(x=>wfb3,y=>enable,z=>dec_int(1));


    a4: AND_Gate
    port map(x=>n1,y=>n2,z=>wfb4);
    aa4: AND_Gate
    port map(x=>wfb4,y=>enable,z=>dec_int(0));

end architecture;