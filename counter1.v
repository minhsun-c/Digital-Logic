module counter(
    input [7:0] ctr,
    input ctrl, mode, clk,
    output [7:0] out
);

wire [7:0] in_js, temp_js, n_temp_js;
wire [7:0] in_rg, temp_rg, n_temp_rg;

assign in_js[7:0] = (mode == 1) ? 8'b00000000 : 8'b10000000;
assign in_rg[7:0] = (mode == 0) ? 8'b00000000 : 8'b10000000;

johnson js(in_js[7:4], clk, temp_js[7:4], n_temp_js[7:4]);
ring rg(in_rg, clk, temp_rg, n_temp_rg);

assign out = (mode == 1) ? temp_js : temp_rg;

endmodule // counter

// ---------------------------------

module DFF( 
    input D, clk,
    output reg Q, Qnot
);

always @ (posedge clk) begin
    Q <= D;
    Qnot <= ~Q;
end

endmodule // DFF

// ---------------------------------
// module DFF( input D, clk, output reg Q, Qnot);
module johnson(
    input [3:0] in,
    input clk,
    output [3:0] Q, Qnot
);

DFF DFF0(in[3], clk, Q[0], Qnot[0]);
DFF DFF1(in[0], clk, Q[1], Qnot[1]);
DFF DFF2(in[1], clk, Q[2], Qnot[2]);
DFF DFF3(in[2], clk, Q[3], Qnot[3]);

endmodule // johnson

// ---------------------------------

module ring(
    input [7:0] in,
    input clk,
    output [7:0] Q, Qnot
);

DFF DFF0(in[7], clk, Q[0], Qnot[0]);
DFF DFF1(in[0], clk, Q[1], Qnot[1]);
DFF DFF2(in[1], clk, Q[2], Qnot[2]);
DFF DFF3(in[2], clk, Q[3], Qnot[3]);
DFF DFF4(in[3], clk, Q[4], Qnot[4]);
DFF DFF5(in[4], clk, Q[5], Qnot[5]);
DFF DFF6(in[5], clk, Q[6], Qnot[6]);
DFF DFF7(in[6], clk, Q[7], Qnot[7]);

endmodule
