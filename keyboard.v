// 位数按照从左到右,从上到下

// s0 第一列 1 4 7 0（从上到下） 
// s1 第二列 2 5 8 =(F)
// s2 第三列 3 6 9 cmp(E)
// s3 第四列 +(A) -(B) and(C) or(D) 

module keyboard(input IN_clk, input[3:0] IN_row,
                    output reg [3:0] OUT_col, output reg [3:0] OUT_value, output reg OUT_key);

    // Declare state register
    reg [1:0]state = 0;
    reg [1:0]flag = 0;

    // Declare  states
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

    always @ (posedge IN_clk) 
    begin
            case (state)
                S0:
                    begin
                        state <= S1;
                        OUT_col <= 4'b0100;
                    end
                S1:
                    begin
                        state <= S2;
                        OUT_col <= 4'b0010;
                    end
                S2:
                    begin
                        state <= S3;
                        OUT_col <= 4'b0001;
                    end
                S3:
                    begin
                        state <= S0;
                        OUT_col <= 4'b1000;
                    end
                default:
                    begin
                        state <= S0;
                        OUT_col <= 4'b1000;
                    end
            endcase
    end

    // Determine the output based only on the current state
    // and the input (do not wait for a clock edge).
    // always @ (state or IN_reset or IN_row)
    always @ (posedge IN_clk)
    begin
        //OUT_value <= OUT_value;
        begin
            case (state)
                S0:
                    case(IN_row)
                        4'b1000: begin OUT_value <= 1; OUT_key <= 1; flag <= 0; end
                        4'b0100: begin OUT_value <= 4; OUT_key <= 1; flag <= 0; end
                        4'b0010: begin OUT_value <= 7; OUT_key <= 1; flag <= 0; end
                        4'b0001: begin OUT_value <= 0; OUT_key <= 1; flag <= 0; end
                        default: begin 
                            OUT_value <= OUT_value; 
                            if(flag != 3)begin
                                OUT_key <= OUT_key; 
                                flag <= flag + 1;
                            end
                            else
                            begin
                                OUT_key <= 0;
                                flag <= 0;
                            end
                        end
                    endcase
                S1:
                    case(IN_row)
                        4'b1000: begin OUT_value <= 2; OUT_key <= 1; flag <= 0; end
                        4'b0100: begin OUT_value <= 5; OUT_key <= 1; flag <= 0; end
                        4'b0010: begin OUT_value <= 8; OUT_key <= 1; flag <= 0; end
                        4'b0001: begin OUT_value <= 15; OUT_key <= 1; flag <= 0; end
                        default: begin 
                            OUT_value <= OUT_value; 
                            if(flag != 3)begin
                                OUT_key <= OUT_key; 
                                flag <= flag + 1;
                            end
                            else
                            begin
                                OUT_key <= 0;
                                flag <= 0;
                            end
                        end
                    endcase
                S2:
                    case(IN_row)
                        4'b1000: begin OUT_value <= 3; OUT_key <= 1; flag <= 0; end
                        4'b0100: begin OUT_value <= 6; OUT_key <= 1; flag <= 0; end
                        4'b0010: begin OUT_value <= 9; OUT_key <= 1; flag <= 0; end
                        4'b0001: begin OUT_value <= 14; OUT_key <= 1; flag <= 0; end
                        default: begin
                            OUT_value <= OUT_value;
                            if(flag != 3)begin
                                OUT_key <= OUT_key; 
                                flag <= flag + 1;
                            end
                            else
                            begin
                                OUT_key <= 0;
                                flag <= 0;
                            end
                        end
                    endcase
                    
                S3:
                    case(IN_row)
								4'b1000: begin OUT_value <= 10; OUT_key <= 1; flag <= 0; end
                        4'b0100: begin OUT_value <= 11; OUT_key <= 1; flag <= 0; end
                        4'b0010: begin OUT_value <= 12; OUT_key <= 1; flag <= 0; end
                        4'b0001: begin OUT_value <= 13; OUT_key <= 1; flag <= 0; end
                        default: begin 
                            OUT_value <= OUT_value; 
                            if(flag != 3)begin
                                OUT_key <= OUT_key; 
                                flag <= flag + 1;
                            end
                            else
                            begin
                                OUT_key <= 0;
                                flag <= 0;
                            end
                        end
                    endcase
                default:
                    begin OUT_value <= 0; OUT_key <= 0; end
            endcase
        end

/*
    always @(IN_reset)
    begin
    if(IN_reset)
        deassign OUT_value;
    else
        assign OUT_value = 0;
    end
*/
end
    endmodule