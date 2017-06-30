library verilog;
use verilog.vl_types.all;
entity Core_unit is
    generic(
        s0              : integer := 0;
        s1              : integer := 1;
        s2              : integer := 2;
        s3              : integer := 3
    );
    port(
        IN_clk          : in     vl_logic;
        IN_carry_in     : in     vl_logic;
        IN_SRCH         : in     vl_logic_vector(7 downto 0);
        IN_SRCL         : in     vl_logic_vector(7 downto 0);
        IN_DSTH         : in     vl_logic_vector(7 downto 0);
        IN_DSTL         : in     vl_logic_vector(7 downto 0);
        IN_S            : in     vl_logic_vector(7 downto 0);
        IN_ALU_OP       : in     vl_logic_vector(3 downto 0);
        IN_finish       : in     vl_logic;
        IN_state        : in     vl_logic_vector(1 downto 0);
        IN_flag         : in     vl_logic_vector(1 downto 0);
        IN_zero         : in     vl_logic;
        IN_music_on     : in     vl_logic;
        IN_calculating  : in     vl_logic_vector(3 downto 0);
        OUT_value       : out    vl_logic_vector(15 downto 0);
        OUT_off_number  : out    vl_logic_vector(2 downto 0);
        OUT_data_a      : out    vl_logic_vector(7 downto 0);
        OUT_data_b      : out    vl_logic_vector(7 downto 0);
        OUT_ALU_OP      : out    vl_logic_vector(3 downto 0);
        OUT_carry_out   : out    vl_logic;
        OUT_neg_ans     : out    vl_logic;
        OUT_less_than   : out    vl_logic;
        OUT_zero        : out    vl_logic;
        OUT_music_on    : out    vl_logic;
        state           : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
end Core_unit;
