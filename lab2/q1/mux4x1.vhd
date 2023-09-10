library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1 is
    port(D: in std_logic_vector (3 downto 0);
    S: in std_logic_vector(1 downto 0);
    Y: out std_logic);
end entity; 

architecture aoi of mux4x1 is

    signal n1: std_logic;
    signal n2: std_logic;
    signal h1: std_logic;
    signal h2: std_logic;
    signal h3: std_logic;
    signal h4: std_logic;
    signal l1: std_logic;
    signal l2: std_logic;
    signal l3: std_logic;
    signal l4: std_logic;
    signal o1: std_logic;
    signal o2: std_logic;


    component AND_Gate is 
    port(x: in std_logic; y: in std_logic; z: out std_logic);
    end component;

    component OR_Gate is 
    port(x: in std_logic; y: in std_logic; z: out std_logic);
    end component;

    component NOT_Gate is
    port(x: in std_logic; z: out std_logic);
    end component;

begin

    a1: AND_Gate
    port map(x=>n1,y=>n2,z=>h1);
    a2: AND_Gate
    port map(x=>n1,y=>S(0),z=>h2);
    a3: AND_Gate
    port map(x=>S(1),y=>n2,z=>h3);
    a4: AND_Gate
    port map(x=>S(1),y=>S(0),z=>h4);
    a5: AND_Gate
    port map(x=>h1,y=>D(0),z=>l1);
    a6: AND_Gate
    port map(x=>h2,y=>D(1),z=>l2);
    a7: AND_Gate
    port map(x=>h3,y=>D(2),z=>l3);
    a8: AND_Gate
    port map(x=>h4,y=>D(3),z=>l4);
    
    

    nn1: NOT_Gate
    port map(x=>S(1),z=>n1);
    nn2: NOT_Gate
    port map(x=>S(0),z=>n2);
    

    oo1: OR_Gate
    port map(x=>l1,y=>l2,z=>o1);
    oo2: OR_Gate
    port map(x=>o1,y=>l3,z=>o2);
    oo3: OR_Gate
    port map(x=>o2,y=>l4,z=>Y);

end architecture;


    