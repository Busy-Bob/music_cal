library verilog;
use verilog.vl_types.all;
entity divider is
    port(
        IN_clk          : in     vl_logic;
        OUT_clk1        : out    vl_logic
    );
end divider;
