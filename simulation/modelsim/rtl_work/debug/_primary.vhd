library verilog;
use verilog.vl_types.all;
entity debug is
    port(
        clk             : in     vl_logic;
        music           : in     vl_logic;
        key             : in     vl_logic;
        reset           : in     vl_logic;
        control         : in     vl_logic;
        value           : in     vl_logic_vector(3 downto 0);
        neg             : out    vl_logic;
        less            : out    vl_logic;
        zero            : out    vl_logic;
        music_on        : out    vl_logic;
        off_number      : out    vl_logic_vector(2 downto 0);
        state           : out    vl_logic_vector(1 downto 0)
    );
end debug;
