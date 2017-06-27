library verilog;
use verilog.vl_types.all;
entity anti_shake is
    generic(
        s0              : integer := 0;
        s1              : integer := 1
    );
    port(
        IN_clk          : in     vl_logic;
        IN_value        : in     vl_logic_vector(3 downto 0);
        IN_key          : in     vl_logic;
        OUT_value       : out    vl_logic_vector(3 downto 0);
        OUT_key         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
end anti_shake;
