module counter(
    input [7:0] ctr,
    input ctrl, mode, clk,
    output [7:0] out
);

	reg [7:0] in_js, in_rg;
	wire [7:0] new_injs, new_inrg;
	wire [7:0] temp_js, n_temp_js;
	wire [7:0] temp_rg, n_temp_rg;

	always @(ctrl) begin
		if (ctrl == 1) begin // load
			in_js[7:4] = ctr[7:4];
			in_rg[7:0] = ctr[7:0];
		end
	end
	
	
	// shift
	johnson js(in_js[7:4], clk, temp_js[7:4], n_temp_js[7:4], new_injs[7:4]);
	ring rg(in_rg, clk, temp_rg, n_temp_rg, new_inrg);

	assign out = (mode == 1) ? temp_js : temp_rg;

endmodule // counter

// ---------------------------------

module DFF_f( 
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
    output [3:0] Q, Qnot,
	 output [3:0] in0
);

	DFF_f DFF0(in0[3], clk, Q[0], Qnot[0]);
	assign in0[0] = Q[0];
	DFF_f DFF1(in0[0], clk, Q[1], Qnot[1]);
	assign in0[1] = Q[1];
	DFF_f DFF2(in0[1], clk, Q[2], Qnot[2]);
	assign in0[2] = Q[2];
	DFF_f DFF3(in0[2], clk, Q[3], Qnot[3]);
	assign in0[3] = Qnot[3];

endmodule // johnson

// ---------------------------------

module ring(
    input [7:0] in,
    input clk,
    output [7:0] Q, Qnot,
	 output [7:0] in0
);

	DFF_f DFF0(in[0], clk, Q[0], Qnot[0]);
	assign in0[0] = Q[0];
	DFF_f DFF1(in[1], clk, Q[1], Qnot[1]);
	assign in0[1] = Q[1];
	DFF_f DFF2(in[2], clk, Q[2], Qnot[2]);
	assign in0[2] = Q[2];
	DFF_f DFF3(in[3], clk, Q[3], Qnot[3]);
	assign in0[3] = Q[3];
	DFF_f DFF4(in[4], clk, Q[4], Qnot[4]);
	assign in0[4] = Q[4];
	DFF_f DFF5(in[5], clk, Q[5], Qnot[5]);
	assign in0[5] = Q[5];
	DFF_f DFF6(in[6], clk, Q[6], Qnot[6]);
	assign in0[6] = Q[6];
	DFF_f DFF7(in[7], clk, Q[7], Qnot[7]);
	assign in0[7] = Q[7];

endmodule 
