LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;

ENTITY CHORDEncoder IS
    PORT (
        clk, rst : IN STD_LOGIC;
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_valid : OUT STD_LOGIC;
        z : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END ENTITY;

ARCHITECTURE sakura OF CHORDEncoder IS
    TYPE inbuf IS ARRAY (0 TO 32) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    TYPE outbuf IS ARRAY (0 TO 32) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    TYPE mytable IS ARRAY(0 TO 23) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL sharp : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00100011";
    SIGNAL major : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01001101";
    SIGNAL m : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01101101";
    SIGNAL s : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01110011";
    SIGNAL seven : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110111";
    SIGNAL check : mytable;
    SIGNAL check2 : mytable;
    -- check will be filled up later when required

BEGIN
    check <= ("01000011", "01100100", "01000100", "01100101", "01000101", "01000110", "01100111", "01000111", "01100001", "01000001", "01100010", "01000010",
        "01000011", "01100100", "01000100", "01100101", "01000101", "01000110", "01100111", "01000111", "01100001", "01000001", "01100010", "01000010");
    check2 <= ("01000011", "01100100", "01000100", "01100101", "01100110", "01000110", "01100111", "01000111", "01100001", "01000001", "01100010", "01100011",
        "01000011", "01100100", "01000100", "01100101", "01100110", "01000110", "01100111", "01000111", "01100001", "01000001", "01100010", "01100011");

    kofuku :
    PROCESS (clk, rst)
        FILE input_file : text OPEN read_mode IS "test.txt";
        VARIABLE input_buffer : inbuf;
        VARIABLE output_buffer : outbuf;
        VARIABLE flush : INTEGER := 0;
        VARIABLE inp_itr : INTEGER := 1;
        VARIABLE inp_buf : INTEGER := 0;
        VARIABLE buf_itr : INTEGER := 0;
        VARIABLE buf_top : INTEGER := 0;
        VARIABLE j : INTEGER;
        VARIABLE k : INTEGER;
        VARIABLE l : INTEGER;
        VARIABLE n : INTEGER;
        VARIABLE flag : BOOLEAN := true;
        VARIABLE flag2 : BOOLEAN := true;
        VARIABLE add_pt : INTEGER := 0;
        VARIABLE input_line : line;
    BEGIN
        IF rising_edge(clk) THEN
            IF NOT endfile(input_file) THEN
                readline (input_file, input_line);
                input_buffer(inp_buf) := a;
                inp_buf := inp_buf + 1;
            END IF;
            REPORT INTEGER'image(inp_buf);
            REPORT INTEGER'image(inp_itr);
            REPORT INTEGER'image(flush);
            -- report integer'image(inp_itr) & integer'image(inp_buf) & integer'image(flush);
            IF flush = 0 AND inp_itr <= inp_buf AND inp_buf /= 1 THEN
                IF input_buffer(inp_itr) = sharp THEN
                    FOR i IN 0 TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            j := i + 1;
                            EXIT;
                        END IF;
                    END LOOP;
                    flush := 1;
                    output_buffer(buf_itr) := input_buffer(inp_itr - 1);
                    output_buffer(buf_itr + 1) := input_buffer(inp_itr);
                    buf_itr := buf_itr + 2;
                    inp_itr := inp_itr + 2;
                    add_pt := add_pt + 2;
                ELSE
                    FOR i IN INTEGER RANGE 0 TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            j := i;
                            -- report boolean'image(input_buffer(inp_itr-1)=check(i));
                            EXIT;
                        END IF;
                    END LOOP;
                    flush := 1;
                    output_buffer(buf_itr) := input_buffer(inp_itr - 1);
                    buf_itr := buf_itr + 1;
                    inp_itr := inp_itr + 1;
                    add_pt := add_pt + 1;
                    -- report std_logic'image(output_buffer(buf_itr-1)(0));
                    -- report integer'image(j);
                    -- report integer'image(flush);
                END IF;
            ELSIF flush = 1 AND inp_itr <= inp_buf THEN
                REPORT "abc";
                IF input_buffer(inp_itr) = sharp THEN
                    FOR i IN j TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            k := i + 1;
                            EXIT;
                        END IF;
                    END LOOP;
                ELSE
                    FOR i IN j TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            k := i;
                            EXIT;
                        END IF;
                    END LOOP;
                END IF;

                IF k - j = 3 OR k - j = 4 OR k - j = 5 THEN
                    flush := 2;
                    IF input_buffer(inp_itr) = sharp THEN
                        inp_itr := inp_itr + 2;
                    ELSE
                        inp_itr := inp_itr + 1;
                    END IF;

                ELSE
                    flush := 0;
                END IF;
            ELSIF flush = 2 AND inp_itr <= inp_buf THEN
                IF input_buffer(inp_itr) = sharp THEN
                    FOR i IN k TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            l := i + 1;
                            EXIT;
                        END IF;
                    END LOOP;
                ELSE
                    FOR i IN k TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            l := i;
                            EXIT;
                        END IF;
                    END LOOP;
                END IF;

                IF k - j = 3 AND l - k = 4 THEN
                    flush := 0;
                    output_buffer(buf_itr) := m;
                    buf_itr := buf_itr + 1;
                    IF input_buffer(inp_itr) = sharp THEN
                        add_pt := inp_itr;
                        inp_itr := inp_itr + 2;
                    ELSE
                        add_pt := inp_itr - 1;
                        inp_itr := inp_itr + 1;
                    END IF;

                ELSIF k - j = 5 AND l - k = 2 THEN
                    flush := 0;
                    output_buffer(buf_itr) := s;
                    buf_itr := buf_itr + 1;
                    IF input_buffer(inp_itr) = sharp THEN
                        add_pt := inp_itr;
                        inp_itr := inp_itr + 2;
                    ELSE
                        add_pt := inp_itr - 1;
                        inp_itr := inp_itr + 1;
                    END IF;
                ELSIF k - j = 4 AND l - k = 3 THEN
                    flush := 3;
                    IF input_buffer(inp_itr) = sharp THEN
                        add_pt := inp_itr;
                        inp_itr := inp_itr + 2;
                    ELSE
                        add_pt := inp_itr - 1;
                        inp_itr := inp_itr + 1;
                    END IF;
                ELSE
                    flush := 0;
                    IF input_buffer(inp_itr - 2) = sharp THEN
                        inp_itr := inp_itr - 2;
                    ELSE
                        inp_itr := inp_itr - 1;
                    END IF;
                END IF;
            ELSIF flush = 3 AND inp_itr <= inp_buf THEN
                IF input_buffer(inp_itr) = sharp THEN
                    FOR i IN l TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            n := i + 1;
                            EXIT;
                        END IF;
                    END LOOP;
                ELSE
                    FOR i IN l TO 23 LOOP
                        IF input_buffer(inp_itr - 1) = check(i) OR input_buffer(inp_itr - 1) = check2(i) THEN
                            n := i;
                            EXIT;
                        END IF;
                    END LOOP;
                END IF;
                IF n - l = 3 THEN
                    flush := 0;
                    output_buffer(buf_itr) := seven;
                    buf_itr := buf_itr + 1;
                    IF input_buffer(inp_itr) = sharp THEN
                        add_pt := inp_itr;
                        inp_itr := inp_itr + 2;

                    ELSE
                        add_pt := inp_itr - 1;
                        inp_itr := inp_itr + 1;
                    END IF;
                ELSE
                    output_buffer(buf_itr) := major;
                    buf_itr := buf_itr + 1;
                    flush := 0;

                END IF;
            ELSIF inp_itr /= 1 THEN
                flag := false;

            END IF;
        END IF;

        -- report integer'image(buf_itr) & integer'image(buf_top);
        REPORT INTEGER'image(add_pt) & INTEGER'image(inp_buf - 1);
        IF flag = false AND flag2 = true THEN
            FOR i IN add_pt + 1 TO inp_buf - 1 LOOP
                output_buffer(buf_itr) := input_buffer(i);
                buf_itr := buf_itr + 1;
                REPORT "hello";
            END LOOP;
            flag2 := false;
        END IF;
        IF falling_edge(clk) THEN
            IF buf_top < buf_itr THEN
                z <= output_buffer(buf_top);
                data_valid <= '1';
                buf_top := buf_top + 1;

            ELSIF inp_itr <= inp_buf + 1 AND flag = true THEN
                z <= "00000000";
                data_valid <= '1';
            ELSE
                data_valid <= '0';
            END IF;
        END IF;

    END PROCESS;
END ARCHITECTURE;