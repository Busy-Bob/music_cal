library verilog;
use verilog.vl_types.all;
entity keyboard is
    generic(
        S0              : integer := 0;
        S1              : integer := 1;
        S2              : integer := 2;
        S3              : integer := 3
    );
    port(
        IN_clk          : in     vl_logic;
        IN_row          : in     vl_logic_vector(3 downto 0);
        OUT_col         : out    vl_logic_vector(3 downto 0);
        OUT_value       : out    vl_logic_vector(3 downto 0);
        OUT_key         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
end keyboard;
