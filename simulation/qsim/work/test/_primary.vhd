library verilog;
use verilog.vl_types.all;
entity test is
    port(
        a               : in     vl_logic;
        c               : in     vl_logic;
        b               : out    vl_logic_vector(3 downto 0)
    );
end test;
