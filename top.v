module top(
input wire clk,
input wire reset
);
wire enable;
wire load_seed;
wire [127:0] seed;
wire [127:0] lfsr_out;
lfsr i1(
      .clk(clk),
      .reset(reset),
      .enable(enable),
      .load_seed(load_seed),
      .seed(seed),
      .lfsr_out(lfsr_out)
);
ila_0 i2 (
	.clk(clk), // input wire clk


	.probe0(seed), // input wire [127:0]  probe0  
	.probe1(lfsr_out), // input wire [127:0]  probe1 
	.probe2(reset), // input wire [0:0]  probe2 
	.probe3(enable), // input wire [0:0]  probe3 
	.probe4(load_seed) // input wire [0:0]  probe4
);
vio_1 i3 (
  .clk(clk),                // input wire clk
  .probe_out0(seed),  // output wire [127 : 0] probe_out0
  .probe_out1(reset),  // output wire [0 : 0] probe_out1
  .probe_out2(enable),  // output wire [0 : 0] probe_out2
  .probe_out3(load_seed)  // output wire [0 : 0] probe_out3
);
endmodule
