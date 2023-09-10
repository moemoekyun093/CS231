library IEEE;
use IEEE.std_logic_1164.all;

entity CHORD_Encoder is
    port(clk, rst: in std_logic;
    a: in std_logic_vector(7 downto 0);
    data_valid: out std_logic;
    z: out std_logic_vector(7 downto 0));
end entity;

architecture sakura of CHORD_Encoder is
    type inbuf is array (0 to 32) of std_logic_vector (7 downto 0);
    type outbuf is array (0 to 32) of std_logic_vector (7 downto 0);
    type mytable is array(0 to 32) of std_logic_vector (7 downto 0);
    signal sharp : std_logic_vector(7 downto 0) := "00100011";
    signal M : std_logic_vector(7 downto 0) := "01001101";
    signal m : std_logic_vector(7 downto 0) := "01101101";
    signal s : std_logic_vector(7 downto 0) := "00100000";
    signal seven: std_logic_vector(7 downto 0) := "00110111";
    signal flush : integer range 0 to 5 := 0;
    signal flag : boolean := false;
    signal chord_type: integer range 0 to 4;
    signal inp_buf : integer := 0;
    signal buf_itr: integer := 0;
    signal buf_top: integer := 0;
    signal temp: std_logic_vector(7 downto 0);
    signal check : mytable;
    -- check will be filled up later when required

    begin
        kofuku:
        process (clk, rst)
        file input_file: text open read_mode is "test.txt";
        variable input_buffer: inbuf;
        variable output_buffer: outbuf;
        begin
        if rising_edge(clk) then
            data_valid <= '0';

           if flush = 0 then
                if a = sharp then
                    input_buffer(inp_buf) := sharp;
                    for i in 0 to 25 loop
                        if input_buffer(inp_buf-1)=check(i) then
                            j<=i+1;
                            exit;
                            end if;
                        end loop;
                        inp_buf <= inp_buf +1;
                        z <= sharp;
                        data_valid <= '1';
                        flush <=1;
                else
                if flag = false then    
                input_buffer(inp_buf) := a;
                inp_buf <= inp_buf + 1;
                flag <= true;
                else
                for i in 0 to 25 loop
                    if input_buffer(inp_buf-1)=check(i) then
                        j<=i;
                        exit;
                        end if;
                    end loop;
                flush <=1;
                z <= input_buffer(inp_buf-1);
                data_valid <= '1';
                input_buffer(inp_buf) :=a;
                inp_buf <= inp_buf +1;
                flag <= false;
                end if;
                    end if;
            

            elsif flush = 1 then
                if a = sharp then
                    input_buffer(1) := sharp;
                    for i in j to 25 loop
                        if input_buffer(0)=check(i) then
                            k<=i+1;
                            exit;
                            end if;
                        end loop;
                        flush <= 2;
                    else 
                    if flag = false then    
                input_buffer(0) := a;
                flag <= true;
                else
                for i in j to 25 loop
                    if input_buffer(0)=check(i) then
                        j<=i;
                        exit;
                        end if;
                    end loop;
                flush <=2;
                input_buffer(0) :=a;
                flag <= false;
                end if;

                end if;


                if flush = 2 then
                    if k-j = 3 then
                        chord_type <= 0;
                        z <= m;
                        data_valid <= '1';
                    elsif k-j = 5 then
                        chord_type <= 1;
                        z <= s;
                        data_valid <= '1';
                    else
                        chord_type <= 2;
                    end if;
                end if;

            

            elsif flush = 2 then

                if a = sharp then
                    input_buffer(1) := sharp;
                    
                        flush <=3;
                else
                if flag = false then    
                input_buffer(0) := a;
                flag <= true;
                else
                
                flush <=3;
                input_buffer(0) :=a;
                flag <= false;
                end if;
                    end if;
                
            


            elsif flush =3 then
                if a = sharp then
                    input_buffer(1) := sharp;
                    for i in k to 25 loop
                        if input_buffer(0)=check(i) then
                            l<=i+1;
                            exit;
                            end if;
                        end loop;
                        
                        flush <=4;
                else
                if flag = false then    
                input_buffer(0) := a;
                flag <= true;
                else
                for i in k to 25 loop
                    if input_buffer(0)=check(i) then
                        l<=i;
                        exit;
                        end if;
                    end loop;
                flush <=4;
                temp <= input_buffer(0);
                input_buffer(0) :=a;
                flag <= false;
                end if;
                    end if;

                
                if flush=4
                    if l-k = 6 and chord_type =2 then
                        chord_type <= 3;
                        z <= seven ;
                        data_valid <= '1';
                    elsif chord_type =2 then
                        chord_type <= 2;
                        if a = sharp then
                            output_buffer(buf_itr) := input_buffer(0);
                            buf_itr <= buf_itr + 1;
                            output_buffer(buf_itr) := input_buffer(1);
                            buf_itr <= buf_itr + 1;
                        else
                        output_buffer(buf_itr) := temp;
                        buf_itr <= buf_itr + 1;
                        output_buffer(buf_itr) := input_buffer(0);
                            buf_itr <= buf_itr + 1;
                        end if;
                        output_buffer(buf_itr) := M;
                            buf_itr <= buf_itr + 1;
                    else
                    if a = sharp then
                        output_buffer(buf_itr) := input_buffer(0);
                        buf_itr <= buf_itr + 1;
                        output_buffer(buf_itr) := input_buffer(1);
                        buf_itr <= buf_itr + 1;
                        z <= output_buffer(buf_top);
                        buf_top <= buf_top +1;
                        data_valid <= '1';
                    else
                    output_buffer(buf_itr) := temp;
                    buf_itr <= buf_itr + 1;
                    output_buffer(buf_itr) := input_buffer(0);
                        buf_itr <= buf_itr + 1;
                        z <= output_buffer(buf_top);
                        buf_top <= buf_top +1;
                        data_valid <= '1';
                    end if;
                        
                    end if;
                  
                end if;

            else

            if not endfile(input_file) then
                output_buffer(buf_itr) := a;
                buf_itr <= buf_itr+1;
                z <= output_buffer(buf_top);
                buf_top <= buf_top +1;
                data_valid <= '1';
            elsif buf_top < buf_itr then
                z <= output_buffer(buf_top);
                buf_top <= buf_top +1;
                data_valid <= '1';
                end if;

            end if;

            end if;
               
            end process;


    end architecture;