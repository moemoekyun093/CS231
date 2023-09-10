library IEEE;
use IEEE.std_logic_1164.all;

entity TestBenchDECODER4x16 is
    end entity;


architecture hehe of TestBenchDECODER4x16 is 

signal a: std_logic;
signal b: std_logic;
signal c: std_logic;
signal d: std_logic;
signal enable: std_logic;
signal dec: std_logic_vector(15 downto 0);


component decoder4x16 is
    port(a, b, c, d, enable: in std_logic;
    dec: out std_logic_vector(15 downto 0));
end component;

begin

    dut_instance: decoder4x16
    port map(a=>a,b=>b,c=>c,d=>d,enable=>enable,dec(15 downto 0)=>dec(15 downto 0));

    process
    begin

    
        for o in std_logic range '1' downto '1' loop
            enable <= o;
            for p in std_logic range '1' downto '0' loop
                a <= p;
                for q in std_logic range '1' downto '0' loop
                    b <= q;
                    for r in std_logic range '1' downto '0' loop
                        c <= r;
                        for s in std_logic range '1' downto '0' loop
                            d <= s;
                            wait for 1 ns;
                            end loop;
                        end loop;
                    end loop;
                end loop;
            end loop;

          
   
    end process;

end architecture;
