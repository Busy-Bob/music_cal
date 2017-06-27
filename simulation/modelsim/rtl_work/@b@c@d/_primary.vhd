library verilog;
use verilog.vl_types.all;
entity BCD is
    port(
        clk             : in     vl_logic;
        hex             : in     vl_logic_vector(15 downto 0);
        dec             : out    vl_logic_vector(15 downto 0)
    );
end BCD;
