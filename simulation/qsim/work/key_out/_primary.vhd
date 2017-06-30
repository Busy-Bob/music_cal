library verilog;
use verilog.vl_types.all;
entity key_out is
    port(
        IN_clk          : in     vl_logic;
        IN_value        : in     vl_logic_vector(3 downto 0);
        IN_key          : in     vl_logic;
        IN_reset        : in     vl_logic;
        IN_control      : in     vl_logic;
        IN_ans          : in     vl_logic_vector(15 downto 0);
        OUT_SRCH        : out    vl_logic_vector(7 downto 0);
        OUT_SRCL        : out    vl_logic_vector(7 downto 0);
        OUT_DSTH        : out    vl_logic_vector(7 downto 0);
        OUT_DSTL        : out    vl_logic_vector(7 downto 0);
        OUT_ALU_OP      : out    vl_logic_vector(3 downto 0);
        OUT_finish      : out    vl_logic;
        OUT_state       : out    vl_logic_vector(1 downto 0);
        OUT_flag        : out    vl_logic_vector(1 downto 0)
    );
end key_out;
