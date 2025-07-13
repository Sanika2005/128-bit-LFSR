module lfsr(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire load_seed,
    input wire [127:0] seed,
    output reg [127:0] lfsr_out
    );
    wire feedback;
    // P(x) = x^128 + x^103 + x^76 + x^51 + x^25 + x + 1
    assign feedback = lfsr_out[127] ^ lfsr_out[102] ^ lfsr_out[75] ^ 
               lfsr_out[50] ^ lfsr_out[24] ^ lfsr_out[0] ^ lfsr_out[1];
    always @(posedge clk) begin
         if (reset)
               lfsr_out <= 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
         else if (load_seed)
               lfsr_out <= seed;
         else if (enable)
               lfsr_out <= {lfsr_out[126:0],feedback};
      end
endmodule
