library IEEE;
use IEEE.std_logic_1164.all;

entity TestBenchMUX4x1 is
    end entity;


architecture hehe of TestBenchMux4x1 is 

signal D: std_logic_vector (3 downto 0);
signal S: std_logic_vector (1 downto 0);
signal Y: std_logic;

component mux4x1 is 
port(D: in std_logic_vector (3 downto 0);
    S: in std_logic_vector(1 downto 0);
    Y: out std_logic);
end component; 

begin 

dut_instance: mux4x1
port map(D(3)=>D(3),D(2)=>D(2),D(1)=>D(1),D(0)=>D(0),S(0)=>S(0),S(1)=>S(1),Y=>Y);

process
begin

    S(0) <= '0';
    S(1) <= '0';
    D(0) <= '0';
    wait for 1 ns;

    S(0) <= '0';
    S(1) <= '0';
    D(0) <= '1';
    wait for 1 ns;

    S(0) <= '0';
    S(1) <= '0';
    D(0) <= '0';
    wait for 1 ns;

    S(0) <= '1';
    S(1) <= '0';
    D(1) <= '0';
    wait for 1 ns;

    S(0) <= '1';
    S(1) <= '0';
    D(1) <= '1';
    wait for 1 ns;

    S(0) <= '1';
    S(1) <= '0';
    D(1) <= '0';
    wait for 1 ns;

    S(0) <= '0';
    S(1) <= '1';
    D(2) <= '0';
    wait for 1 ns;

    S(0) <= '0';
    S(1) <= '1';
    D(2) <= '1';
    wait for 1 ns;

    S(0) <= '0';
    S(1) <= '1';
    D(2) <= '0';
    wait for 1 ns;

    S(0) <= '1';
    S(1) <= '1';
    D(3) <= '0';
    wait for 1 ns;

    S(0) <= '1';
    S(1) <= '1';
    D(3) <= '1';
    wait for 1 ns;

    S(0) <= '1';
    S(1) <= '1';
    D(3) <= '0';
    wait for 1 ns;

    

    end process;

end architecture;