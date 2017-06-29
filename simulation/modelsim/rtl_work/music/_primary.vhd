library verilog;
use verilog.vl_types.all;
entity music is
    port(
        IN_clk          : in     vl_logic;
        IN_neg_ans      : in     vl_logic;
        IN_music_on     : in     vl_logic;
        OUT_music       : out    vl_logic
    );
end music;
