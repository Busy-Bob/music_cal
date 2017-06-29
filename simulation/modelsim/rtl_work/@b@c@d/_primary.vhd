library verilog;
use verilog.vl_types.all;
entity BCD is
    port(
        IN_clk          : in     vl_logic;
        IN_hex          : in     vl_logic_vector(15 downto 0);
        IN_off_number   : in     vl_logic_vector(2 downto 0);
        OUT_dec         : out    vl_logic_vector(15 downto 0);
        OUT_off_number  : out    vl_logic_vector(2 downto 0)
    );
end BCD;
