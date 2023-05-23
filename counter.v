module myDecoder1(inValue, outSeg);
	input [3:0] inValue;
	output reg [6:0] outSeg;

	always @(inValue)
		begin
			case(inValue)
				4'b0000: outSeg = 7'b1000000;
				4'b0001: outSeg = 7'b1111001;
				4'b0010: outSeg = 7'b0100100;
				4'b0011: outSeg = 7'b0110000;
				4'b0100: outSeg = 7'b0011001;
				4'b0101: outSeg = 7'b0010010;
				4'b0110: outSeg = 7'b0000010;
				4'b0111: outSeg = 7'b1111000;
				4'b1000: outSeg = 7'b0000000;
				4'b1001: outSeg = 7'b0011000;
				4'b1010: outSeg = 7'b0001000;
				4'b1011: outSeg = 7'b0000011;
				4'b1100: outSeg = 7'b1000110;
				4'b1101: outSeg = 7'b0100001;
				4'b1110: outSeg = 7'b0000110;
				4'b1111: outSeg = 7'b0001110;
					
				default: outSeg = 7'b1000000;
			endcase
		end
endmodule


module D_FF (input D, input CLK, output reg Q);
	always @(posedge CLK)
	begin 
		if(D==1) begin
			Q=1;
		end
		else begin
			Q = 0;
		end
	end
endmodule

module counter(input clk, input mode, input lo, input [3:0]load, output [3:0]Q, output [6:0]seg);
	reg [3:0]temp;
	always @(negedge clk) begin
			if(mode) begin //johnson
				temp[3:1] = Q[2:0];
				temp[0] = ~Q[3];
			end
			else begin
				temp[3:1] = Q[2:0];
				temp[0]=Q[3];
			end
			
			if(lo) begin
				temp=load;
			end
	end

	D_FF f0(temp[0], clk, Q[0]);
	D_FF f1(temp[1], clk, Q[1]);
	D_FF f2(temp[2], clk, Q[2]);
	D_FF f3(temp[3], clk, Q[3]);

	myDecoder1 dd(Q, seg);

endmodule
