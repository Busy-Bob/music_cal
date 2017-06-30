library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        IN_CS           : in     vl_logic_vector(3 downto 0);
        IN_data_a       : in     vl_logic_vector(7 downto 0);
        IN_data_b       : in     vl_logic_vector(7 downto 0);
        IN_carry_in     : in     vl_logic;
        OUT_S           : out    vl_logic_vector(7 downto 0);
        OUT_zero        : out    vl_logic;
        OUT_carry_out   : out    vl_logic
    );
end alu;
