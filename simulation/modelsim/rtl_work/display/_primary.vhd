library verilog;
use verilog.vl_types.all;
entity display is
    generic(
        S0              : integer := 0;
        S1              : integer := 1;
        S2              : integer := 2;
        S3              : integer := 3;
        DNULL           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        D0              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        D1              : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        D2              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1);
        D3              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1);
        D4              : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1);
        D5              : vl_logic_vector(0 to 7) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1);
        D6              : vl_logic_vector(0 to 7) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        D7              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        D8              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        D9              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1);
        DA              : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi1);
        DB              : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        DC              : vl_logic_vector(0 to 7) := (Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi1);
        DD              : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1);
        DE              : vl_logic_vector(0 to 7) := (Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1);
        DF              : vl_logic_vector(0 to 7) := (Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        IN_clk          : in     vl_logic;
        IN_value        : in     vl_logic_vector(15 downto 0);
        IN_off_number   : in     vl_logic_vector(2 downto 0);
        OUT_choice      : out    vl_logic_vector(3 downto 0);
        OUT_seg         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of S0 : constant is 1;
    attribute mti_svvh_generic_type of S1 : constant is 1;
    attribute mti_svvh_generic_type of S2 : constant is 1;
    attribute mti_svvh_generic_type of S3 : constant is 1;
    attribute mti_svvh_generic_type of DNULL : constant is 1;
    attribute mti_svvh_generic_type of D0 : constant is 1;
    attribute mti_svvh_generic_type of D1 : constant is 1;
    attribute mti_svvh_generic_type of D2 : constant is 1;
    attribute mti_svvh_generic_type of D3 : constant is 1;
    attribute mti_svvh_generic_type of D4 : constant is 1;
    attribute mti_svvh_generic_type of D5 : constant is 1;
    attribute mti_svvh_generic_type of D6 : constant is 1;
    attribute mti_svvh_generic_type of D7 : constant is 1;
    attribute mti_svvh_generic_type of D8 : constant is 1;
    attribute mti_svvh_generic_type of D9 : constant is 1;
    attribute mti_svvh_generic_type of DA : constant is 1;
    attribute mti_svvh_generic_type of DB : constant is 1;
    attribute mti_svvh_generic_type of DC : constant is 1;
    attribute mti_svvh_generic_type of DD : constant is 1;
    attribute mti_svvh_generic_type of DE : constant is 1;
    attribute mti_svvh_generic_type of DF : constant is 1;
end display;
