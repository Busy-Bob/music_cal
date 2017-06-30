library verilog;
use verilog.vl_types.all;
entity key_out is
    generic(
        s0              : integer := 0;
        s1              : integer := 1;
        s2              : integer := 2;
        s3              : integer := 3
    );
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
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
end key_out;
