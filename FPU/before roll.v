//IEEE 754 Single Precision ALU
module fpu(clk, A, B, opcode, O);
	input clk;
	input [31:0] A, B;
	input [1:0] opcode;
	output [31:0] O;

	wire [31:0] O;
	wire [7:0] a_exponent;
	wire [23:0] a_mantissa;
	wire [7:0] b_exponent;
	wire [23:0] b_mantissa;

	reg        o_sign;
	reg [7:0]  o_exponent;
	reg [24:0] o_mantissa;


	reg [31:0] adder_a_in;
	reg [31:0] adder_b_in;
	wire [31:0] adder_out;

	reg [31:0] multiplier_a_in;
	reg [31:0] multiplier_b_in;
	wire [31:0] multiplier_out;

	reg [31:0] divider_a_in;
	reg [31:0] divider_b_in;
	wire [31:0] divider_out;

	assign O[31] = o_sign;
	assign O[30:23] = o_exponent;
	assign O[22:0] = o_mantissa[22:0];

	assign a_sign = A[31];
	assign a_exponent[7:0] = A[30:23];
	assign a_mantissa[23:0] = {1'b1, A[22:0]};

	assign b_sign = B[31];
	assign b_exponent[7:0] = B[30:23];
	assign b_mantissa[23:0] = {1'b1, B[22:0]};

	assign ADD = !opcode[1] & !opcode[0];
	assign SUB = !opcode[1] & opcode[0];
	assign DIV = opcode[1] & !opcode[0];
	assign MUL = opcode[1] & opcode[0];

	adder A1
	(
		.a(adder_a_in),
		.b(adder_b_in),
		.out(adder_out)
	);

	multiplier M1
	(
		.a(multiplier_a_in),
		.b(multiplier_b_in),
		.out(multiplier_out)
	);

	divider D1
	(
		.a(divider_a_in),
		.b(divider_b_in),
		.out(divider_out)
	);

	always @ (posedge clk) begin
		if (ADD) begin
			//If a is NaN or b is zero return a
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = a_exponent;
				o_mantissa = a_mantissa;
			//If b is NaN or a is zero return b
			end else if ((b_exponent == 255 && b_mantissa != 0) || (a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = b_sign;
				o_exponent = b_exponent;
				o_mantissa = b_mantissa;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				adder_a_in = A;
				adder_b_in = B;
				o_sign = adder_out[31];
				o_exponent = adder_out[30:23];
				o_mantissa = adder_out[22:0];
			end
		end else if (SUB) begin
			//If a is NaN or b is zero return a
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = a_exponent;
				o_mantissa = a_mantissa;
			//If b is NaN or a is zero return b
			end else if ((b_exponent == 255 && b_mantissa != 0) || (a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = b_sign;
				o_exponent = b_exponent;
				o_mantissa = b_mantissa;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				adder_a_in = A;
				adder_b_in = {~B[31], B[30:0]};
				o_sign = adder_out[31];
				o_exponent = adder_out[30:23];
				o_mantissa = adder_out[22:0];
			end
		end else if (DIV) begin
			divider_a_in = A;
			divider_b_in = B;
			o_sign = divider_out[31];
			o_exponent = divider_out[30:23];
			o_mantissa = divider_out[22:0];
		end else begin //Multiplication
			//If a is NaN return NaN
			if (a_exponent == 255 && a_mantissa != 0) begin
				o_sign = a_sign;
				o_exponent = 255;
				o_mantissa = a_mantissa;
			//If b is NaN return NaN
			end else if (b_exponent == 255 && b_mantissa != 0) begin
				o_sign = b_sign;
				o_exponent = 255;
				o_mantissa = b_mantissa;
			//If a or b is 0 return 0
			end else if ((a_exponent == 0) && (a_mantissa == 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 0;
				o_mantissa = 0;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				multiplier_a_in = A;
				multiplier_b_in = B;
				o_sign = multiplier_out[31];
				o_exponent = multiplier_out[30:23];
				o_mantissa = multiplier_out[22:0];
			end
		end
	end
endmodule


module adder(a, b, out);
  input  [31:0] a, b;
  output [31:0] out;

  wire [31:0] out;
	reg a_sign;
	reg [7:0] a_exponent;
	reg [23:0] a_mantissa;
	reg b_sign;
	reg [7:0] b_exponent;
	reg [23:0] b_mantissa;

  reg o_sign;
  reg [7:0] o_exponent;
  reg [24:0] o_mantissa;

  reg [7:0] diff;
  reg [23:0] tmp_mantissa;
  reg [7:0] tmp_exponent;


  reg  [7:0] i_e;
  reg  [24:0] i_m;
  wire [7:0] o_e;
  wire [24:0] o_m;
  
    reg [23:0] add_a_in0;
	reg [23:0] add_b_in0;
	wire [24:0] add_out0;

	fa_24b add0
	(
		.a(add_a_in0),
		.b(add_b_in0),
		.out(add_out0)
	);

	reg [23:0] add_a_in1;
	reg [23:0] add_b_in1;
	wire [24:0] add_out1;

	fa_24b add1
	(
		.a(add_a_in1),
		.b(add_b_in1),
		.out(add_out1)
	);

	reg [23:0] add_a_in2;
	reg [23:0] add_b_in2;
	wire [24:0] add_out2;

	fa_24b add2
	(
		.a(add_a_in2),
		.b(add_b_in2),
		.out(add_out2)
	);

	reg [23:0] add_a_in3;
	reg [23:0] add_b_in3;
	wire [24:0] add_out3;

	fa_24b add3
	(
		.a(add_a_in3),
		.b(add_b_in3),
		.out(add_out3)
	);

	reg [23:0] add_a_in4;
	reg [23:0] add_b_in4;
	wire [24:0] add_out4;

	fa_24b add4
	(
		.a(add_a_in4),
		.b(add_b_in4),
		.out(add_out4)
	);

	reg [23:0] add_a_in5;
	reg [23:0] add_b_in5;
	wire [24:0] add_out5;

	fa_24b add5
	(
		.a(add_a_in5),
		.b(add_b_in5),
		.out(add_out5)
	);

	reg [23:0] add_a_in6;
	reg [23:0] add_b_in6;
	wire [24:0] add_out6;

	fa_24b add6
	(
		.a(add_a_in6),
		.b(add_b_in6),
		.out(add_out6)
	);

	reg [23:0] add_a_in7;
	reg [23:0] add_b_in7;
	wire [24:0] add_out7;

	fa_24b add7
	(
		.a(add_a_in7),
		.b(add_b_in7),
		.out(add_out7)
	);

	reg [23:0] add_a_in8;
	reg [23:0] add_b_in8;
	wire [24:0] add_out8;

	fa_24b add8
	(
		.a(add_a_in8),
		.b(add_b_in8),
		.out(add_out8)
	);

	reg [23:0] add_a_in9;
	reg [23:0] add_b_in9;
	wire [24:0] add_out9;

	fa_24b add9
	(
		.a(add_a_in9),
		.b(add_b_in9),
		.out(add_out9)
	);
	
	reg [2:0] shift_n0;
	reg [7:0] shift_in0;
	wire [7:0] shift_out0;
	
	barrel_shifter_8bit_R sh0
	(
		.in(shift_in0),
		.ctrl(shift_n0),
		.out(shift_out0)
	);
	
	reg [2:0] shift_n1;
	reg [7:0] shift_in1;
	wire [7:0] shift_out1;
	
	barrel_shifter_8bit_R sh1
	(
		.in(shift_in1),
		.ctrl(shift_n1),
		.out(shift_out1)
	);
  

  assign out[31] = o_sign;
  assign out[30:23] = o_exponent;
  assign out[22:0] = o_mantissa[22:0];

  always @ ( * ) begin
		a_sign = a[31];
		if(a[30:23] == 0) begin
			a_exponent = 8'b00000001;
			a_mantissa = {1'b0, a[22:0]};
		end else begin
			a_exponent = a[30:23];
			a_mantissa = {1'b1, a[22:0]};
		end
		b_sign = b[31];
		if(b[30:23] == 0) begin
			b_exponent = 8'b00000001;
			b_mantissa = {1'b0, b[22:0]};
		end else begin
			b_exponent = b[30:23];
			b_mantissa = {1'b1, b[22:0]};
		end
    if (a_exponent == b_exponent) begin // Equal exponents
      o_exponent = a_exponent;
      if (a_sign == b_sign) begin // Equal signs = add
        // o_mantissa = a_mantissa + b_mantissa;
		add_a_in0 = a_mantissa;
		add_b_in0 = b_mantissa;
		o_mantissa = add_out0;
        //Signify to shift
        o_mantissa[24] = 1;
        o_sign = a_sign;
      end else begin // Opposite signs = subtract
        if(a_mantissa > b_mantissa) begin
          // o_mantissa = a_mantissa - b_mantissa;
		  add_a_in1 = a_mantissa;
		  add_b_in1 = ~b_mantissa;
		  o_mantissa = add_out1;		
          o_sign = a_sign;
        end else begin
          // o_mantissa = b_mantissa - a_mantissa;
		  add_a_in2 = ~a_mantissa;
		  add_b_in2 = b_mantissa;
		  o_mantissa = add_out2;
          o_sign = b_sign;
        end
      end
    end else begin //Unequal exponents
      if (a_exponent > b_exponent) begin // A is bigger
        o_exponent = a_exponent;
        o_sign = a_sign;
		// diff = a_exponent - b_exponent;
		add_a_in3 = {16'h00, a_exponent};
		add_b_in3 = {16'h00, ~b_exponent};
		diff = add_out3[7:0];
        //tmp_mantissa = b_mantissa >> diff;
		if (diff > 8) begin // A much bigger than B
			o_sign = a_sign;
			o_exponent = a_exponent;
			o_mantissa = a_mantissa;
			end
		else begin
		shift_n0 = diff[2:0];
		shift_in0 = {24'h00, b_mantissa};
		tmp_mantissa = {16'h00, shift_out0};
        if (a_sign == b_sign) begin
          // o_mantissa = a_mantissa + tmp_mantissa;
		  add_a_in4 = a_mantissa;
		  add_b_in4 = tmp_mantissa;
		  o_mantissa = add_out4;
		  end
        else begin
          	// o_mantissa = a_mantissa - tmp_mantissa;
			add_a_in5 = a_mantissa;
			add_b_in5 = ~tmp_mantissa;
			o_mantissa = add_out5;
			end
		end
      end
	  else if (a_exponent < b_exponent) begin // B is bigger
        o_exponent = b_exponent;
        o_sign = b_sign;
        // diff = b_exponent - a_exponent;
		add_a_in6 = {16'h00, ~a_exponent};
		add_b_in6 = {16'h00, b_exponent};
		diff = add_out6[7:0];
		if (diff > 8) begin // B much bigger than A
			o_sign = b_sign;
			o_exponent = b_exponent;
			o_mantissa = b_mantissa;
		end
		else begin
		tmp_mantissa = a_mantissa >> diff;
		// shift_n1 = diff[2:0];
		// shift_in1 = {24'h00, a_mantissa};
		// tmp_mantissa = {16'h00, shift_out1};
        if (a_sign == b_sign) begin
          // o_mantissa = b_mantissa + tmp_mantissa;
		  add_a_in7 = b_mantissa;
		  add_b_in7 = tmp_mantissa;
		  o_mantissa = add_out7;
        end else begin
		  // o_mantissa = b_mantissa - tmp_mantissa;
		  add_a_in8 = b_mantissa;
		  add_b_in8 = ~tmp_mantissa;
		  o_mantissa = add_out8;
        end
		end
      end
    end
    if(o_mantissa[24] == 1) begin
      // o_exponent = o_exponent + 1;
	  add_a_in9 = {16'h00, o_exponent};
	  add_b_in9 = 24'h01;
	  o_exponent = add_out9[7:0];
      //o_mantissa = o_mantissa >> 1;
	  tmp_mantissa = o_mantissa[24:1];
	  o_mantissa = {1'b0, tmp_mantissa};
    end else if((o_mantissa[23] != 1) && (o_exponent != 0)) begin
      i_e = o_exponent;
      i_m = o_mantissa;
      o_exponent = o_e;
      o_mantissa = o_m;
    end
  end
endmodule

module multiplier(a, b, out);
  input  [31:0] a, b;
  output [31:0] out;

  wire [31:0] out;
	reg a_sign;
  reg [7:0] a_exponent;
  reg [23:0] a_mantissa;
	reg b_sign;
  reg [7:0] b_exponent;
  reg [23:0] b_mantissa;

  reg o_sign;
  reg [7:0] o_exponent;
  reg [24:0] o_mantissa;

	reg [47:0] product;

  assign out[31] = o_sign;
  assign out[30:23] = o_exponent;
  assign out[22:0] = o_mantissa[22:0];

	reg  [7:0] i_e;
	reg  [47:0] i_m;
	wire [7:0] o_e;
	wire [47:0] o_m;

	multiplication_normaliser norm1
	(
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e),
		.out_m(o_m)
	);


  always @ ( * ) begin
		a_sign = a[31];
		if(a[30:23] == 0) begin
			a_exponent = 8'b00000001;
			a_mantissa = {1'b0, a[22:0]};
		end else begin
			a_exponent = a[30:23];
			a_mantissa = {1'b1, a[22:0]};
		end
		b_sign = b[31];
		if(b[30:23] == 0) begin
			b_exponent = 8'b00000001;
			b_mantissa = {1'b0, b[22:0]};
		end else begin
			b_exponent = b[30:23];
			b_mantissa = {1'b1, b[22:0]};
		end
    o_sign = a_sign ^ b_sign;
    o_exponent = a_exponent + b_exponent - 127;
    product = a_mantissa * b_mantissa;
		// Normalization
    if(product[47] == 1) begin
      o_exponent = o_exponent + 1;
      product = product >> 1;
    end else if((product[46] != 1) && (o_exponent != 0)) begin
      i_e = o_exponent;
      i_m = product;
      o_exponent = o_e;
      product = o_m;
    end
		o_mantissa = product[46:23];
	end
endmodule

module addition_normaliser(in_e, in_m, out_e, out_m);
  input [7:0] in_e;
  input [24:0] in_m;
  output [7:0] out_e;
  output [24:0] out_m;

  wire [7:0] in_e;
  wire [24:0] in_m;
  reg [7:0] out_e;
  reg [24:0] out_m;
  
  reg [23:0] add_a_in;
  reg [23:0] add_b_in;
  wire [24:0] add_out;

  fa_24b norm0
  (
	.a(add_a_in),
	.b(add_b_in),
	.out(add_out)
  );

  always @ ( * ) begin
		if (in_m[23:3] == 21'b000000000000000000001) begin
			out_e = in_e - 20;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd20;
			// out_e = add_out[7:0];
			out_m = in_m << 20;
		end else if (in_m[23:4] == 20'b00000000000000000001) begin
			out_e = in_e - 19;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd19;
			// out_e = add_out[7:0];
			out_m = in_m << 19;
		end else if (in_m[23:5] == 19'b0000000000000000001) begin
			out_e = in_e - 18;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd18;
			// out_e = add_out[7:0];			
			out_m = in_m << 18;
		end else if (in_m[23:6] == 18'b000000000000000001) begin
			out_e = in_e - 17;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd17;
			// out_e = add_out[7:0];
			out_m = in_m << 17;
		end else if (in_m[23:7] == 17'b00000000000000001) begin
			out_e = in_e - 16;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd16;
			// out_e = add_out[7:0];
			out_m = in_m << 16;
		end else if (in_m[23:8] == 16'b0000000000000001) begin
			out_e = in_e - 15;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd15;
			// out_e = add_out[7:0];
			out_m = in_m << 15;
		end else if (in_m[23:9] == 15'b000000000000001) begin
			out_e = in_e - 14;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd14;
			// out_e = add_out[7:0];
			out_m = in_m << 14;
		end else if (in_m[23:10] == 14'b00000000000001) begin
			out_e = in_e - 13;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd13;
			// out_e = add_out[7:0];
			out_m = in_m << 13;
		end else if (in_m[23:11] == 13'b0000000000001) begin
			out_e = in_e - 12;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd12;
			// out_e = add_out[7:0];
			out_m = in_m << 12;
		end else if (in_m[23:12] == 12'b000000000001) begin
			out_e = in_e - 11;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd11;
			// out_e = add_out[7:0];
			out_m = in_m << 11;
		end else if (in_m[23:13] == 11'b00000000001) begin
			out_e = in_e - 10;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd10;
			// out_e = add_out[7:0];
			out_m = in_m << 10;
		end else if (in_m[23:14] == 10'b0000000001) begin
			out_e = in_e - 9;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd9;
			// out_e = add_out[7:0];
			out_m = in_m << 9;
		end else if (in_m[23:15] == 9'b000000001) begin
			out_e = in_e - 8;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd8;
			// out_e = add_out[7:0];
			out_m = in_m << 8;
		end else if (in_m[23:16] == 8'b00000001) begin
			out_e = in_e - 7;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd7;
			// out_e = add_out[7:0];
			out_m = in_m << 7;
		end else if (in_m[23:17] == 7'b0000001) begin
			out_e = in_e - 6;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd6;
			// out_e = add_out[7:0];
			out_m = in_m << 6;
		end else if (in_m[23:18] == 6'b000001) begin
			out_e = in_e - 5;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd5;
			// out_e = add_out[7:0];
			out_m = in_m << 5;
		end else if (in_m[23:19] == 5'b00001) begin
			out_e = in_e - 4;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd4;
			// out_e = add_out[7:0];
			out_m = in_m << 4;
		end else if (in_m[23:20] == 4'b0001) begin
			out_e = in_e - 3;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd3;
			// out_e = add_out[7:0];
			out_m = in_m << 3;
		end else if (in_m[23:21] == 3'b001) begin
			out_e = in_e - 2;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd2;
			// out_e = add_out[7:0];
			out_m = in_m << 2;
		end else if (in_m[23:22] == 2'b01) begin
			out_e = in_e - 1;
			// add_a_in = {16'h00, in_e};
			// add_b_in = ~24'd1;
			// out_e = add_out[7:0];
			out_m = in_m << 1;
		end
  end
endmodule

module multiplication_normaliser(in_e, in_m, out_e, out_m);
  input [7:0] in_e;
  input [47:0] in_m;
  output [7:0] out_e;
  output [47:0] out_m;

  wire [7:0] in_e;
  wire [47:0] in_m;
  reg [7:0] out_e;
  reg [47:0] out_m;

  always @ ( * ) begin
	  if (in_m[46:41] == 6'b000001) begin
			out_e = in_e - 5;
			out_m = in_m << 5;
		end else if (in_m[46:42] == 5'b00001) begin
			out_e = in_e - 4;
			out_m = in_m << 4;
		end else if (in_m[46:43] == 4'b0001) begin
			out_e = in_e - 3;
			out_m = in_m << 3;
		end else if (in_m[46:44] == 3'b001) begin
			out_e = in_e - 2;
			out_m = in_m << 2;
		end else if (in_m[46:45] == 2'b01) begin
			out_e = in_e - 1;
			out_m = in_m << 1;
		end
  end
endmodule

module divider (a, b, out);
	input [31:0] a;
	input [31:0] b;
	output [31:0] out;

	wire [31:0] b_reciprocal;

	reciprocal recip
	(
		.in(b),
		.out(b_reciprocal)
	);

	multiplier mult
	(
		.a(a),
		.b(b_reciprocal),
		.out(out)
	);

endmodule

module reciprocal (in, out);
	input [31:0] in;

	output [31:0] out;

	wire [31:0] D;
	wire [31:0] N0;
	wire [31:0] N1;
	wire [31:0] N2;

	assign out[31] = in[31];
	assign out[22:0] = N2[22:0];
	assign out[30:23] = (D==9'b100000000)? 9'h102 - in[30:23] : 9'h101 - in[30:23];

	assign D = {1'b0, 8'h80, in[22:0]};

	wire [31:0] C1; //C1 = 48/17
	assign C1 = 32'h4034B4B5;
	wire [31:0] C2; //C2 = 32/17
	assign C2 = 32'h3FF0F0F1;
	wire [31:0] C3; //C3 = 2.0
	assign C3 = 32'h40000000;


	//Temporary connection wires
	wire [31:0] S0_2D_out;
	wire [31:0] S1_DN0_out;
	wire [31:0] S1_2min_DN0_out;
	wire [31:0] S2_DN1_out;
	wire [31:0] S2_2minDN1_out;

	wire [31:0] S0_N0_in;

	assign S0_N0_in = {~S0_2D_out[31], S0_2D_out[30:0]};

	//S0
	multiplier S0_2D
	(
		.a(C2),
		.b(D),
		.out(S0_2D_out)
	);

	adder S0_N0
	(
		.a(C1),
		.b(S0_N0_in),
		.out(N0)
	);

	//S1
	multiplier S1_DN0
	(
		.a(D),
		.b(N0),
		.out(S1_DN0_out)
	);

	adder S1_2minDN0
	(
		.a(C3),
		.b({~S1_DN0_out[31], S1_DN0_out[30:0]}),
		.out(S1_2min_DN0_out)
	);

	multiplier S1_N1
	(
		.a(N0),
		.b(S1_2min_DN0_out),
		.out(N1)
	);

	//S2
	multiplier S2_DN1
	(
		.a(D),
		.b(N1),
		.out(S2_DN1_out)
	);

	adder S2_2minDN1
	(
		.a(C3),
		.b({~S2_DN1_out[31], S2_DN1_out[30:0]}),
		.out(S2_2minDN1_out)
	);

	multiplier S2_N2
	(
		.a(N1),
		.b(S2_2minDN1_out),
		.out(N2)
	);

endmodule

module fa(a, b, cin, out, cout);
input a, b, cin;
output out, cout;
wire a, b, cin;
reg out, cout;
reg s1, c1, c2;
always@(*) begin

s1 = a ^ b;
c1 = a & b;
out = s1 ^ cin;
c2 = s1 & cin;
cout = c1 | c2;
end
endmodule

module fa_24b(a, b, out);
input [23:0] a, b;
output [24:0] out;
wire [23:0] a, b;

wire [24:0] out;
wire [22:0] c;

fa d0(a[0], b[0], 1'b0, out[0], c[0]);
fa d1(a[1], b[1], c[0], out[1], c[1]);
fa d2(a[2], b[2], c[1], out[2], c[2]);
fa d3(a[3], b[3], c[2], out[3], c[3]);
fa d4(a[4], b[4], c[3], out[4], c[4]);
fa d5(a[5], b[5], c[4], out[5], c[5]);
fa d6(a[6], b[6], c[5], out[6], c[6]);
fa d7(a[7], b[7], c[6], out[7], c[7]);
fa d8(a[8], b[8], c[7], out[8], c[8]);
fa d9(a[9], b[9], c[8], out[9], c[9]);
fa d10(a[10], b[10], c[9], out[10], c[10]);
fa d11(a[11], b[11], c[10], out[11], c[11]);
fa d12(a[12], b[12], c[11], out[12], c[12]);
fa d13(a[13], b[13], c[12], out[13], c[13]);
fa d14(a[14], b[14], c[13], out[14], c[14]);
fa d15(a[15], b[15], c[14], out[15], c[15]);
fa d16(a[16], b[16], c[15], out[16], c[16]);
fa d17(a[17], b[17], c[16], out[17], c[17]);
fa d18(a[18], b[18], c[17], out[18], c[18]);
fa d19(a[19], b[19], c[18], out[19], c[19]);
fa d20(a[20], b[20], c[19], out[20], c[20]);
fa d21(a[21], b[21], c[20], out[21], c[21]);
fa d22(a[22], b[22], c[21], out[22], c[22]);
fa d23(a[23], b[23], c[22], out[23], out[24]);
endmodule

module mux2X1(in0, in1, sel, out);
input in0, in1, sel;
output out;
wire in0, in1, sel;
reg out;
always@(*) begin
out = sel?in1:in0;
end
endmodule

module barrel_shifter_8bit_R (in, ctrl, out);
  input  [7:0] in;
  input [2:0] ctrl;
  output [7:0] out;
  wire [7:0] x,y;
  
	//4bit shift right
	mux2X1  muxr_47 (.in0(in[7]),.in1(1'b0),.sel(ctrl[2]),.out(x[7]));
	mux2X1  muxr_46 (.in0(in[6]),.in1(1'b0),.sel(ctrl[2]),.out(x[6]));
	mux2X1  muxr_45 (.in0(in[5]),.in1(1'b0),.sel(ctrl[2]),.out(x[5]));
	mux2X1  muxr_44 (.in0(in[4]),.in1(1'b0),.sel(ctrl[2]),.out(x[4]));
	mux2X1  muxr_43 (.in0(in[3]),.in1(in[7]),.sel(ctrl[2]),.out(x[3]));
	mux2X1  muxr_42 (.in0(in[2]),.in1(in[6]),.sel(ctrl[2]),.out(x[2]));
	mux2X1  muxr_41 (.in0(in[1]),.in1(in[5]),.sel(ctrl[2]),.out(x[1]));
	mux2X1  muxr_40 (.in0(in[0]),.in1(in[4]),.sel(ctrl[2]),.out(x[0]));
	 
	//2 bit shift right
	 
	mux2X1  muxr_27 (.in0(x[7]),.in1(1'b0),.sel(ctrl[1]),.out(y[7]));
	mux2X1  muxr_26 (.in0(x[6]),.in1(1'b0),.sel(ctrl[1]),.out(y[6]));
	mux2X1  muxr_25 (.in0(x[5]),.in1(x[7]),.sel(ctrl[1]),.out(y[5]));
	mux2X1  muxr_24 (.in0(x[4]),.in1(x[6]),.sel(ctrl[1]),.out(y[4]));
	mux2X1  muxr_23 (.in0(x[3]),.in1(x[5]),.sel(ctrl[1]),.out(y[3]));
	mux2X1  muxr_22 (.in0(x[2]),.in1(x[4]),.sel(ctrl[1]),.out(y[2]));
	mux2X1  muxr_21 (.in0(x[1]),.in1(x[3]),.sel(ctrl[1]),.out(y[1]));
	mux2X1  muxr_20 (.in0(x[0]),.in1(x[2]),.sel(ctrl[1]),.out(y[0]));
	 
	//1 bit shift right
	mux2X1  muxr_17 (.in0(y[7]),.in1(1'b0),.sel(ctrl[0]),.out(out[7]));
	mux2X1  muxr_16 (.in0(y[6]),.in1(y[7]),.sel(ctrl[0]),.out(out[6]));
	mux2X1  muxr_15 (.in0(y[5]),.in1(y[6]),.sel(ctrl[0]),.out(out[5]));
	mux2X1  muxr_14 (.in0(y[4]),.in1(y[5]),.sel(ctrl[0]),.out(out[4]));
	mux2X1  muxr_13 (.in0(y[3]),.in1(y[4]),.sel(ctrl[0]),.out(out[3]));
	mux2X1  muxr_12 (.in0(y[2]),.in1(y[3]),.sel(ctrl[0]),.out(out[2]));
	mux2X1  muxr_11 (.in0(y[1]),.in1(y[2]),.sel(ctrl[0]),.out(out[1]));
	mux2X1  muxr_10 (.in0(y[0]),.in1(y[1]),.sel(ctrl[0]),.out(out[0]));
	
endmodule

module barrel_shifter_8bit_L (in, ctrl, out);
  input  [7:0] in;
  input [2:0] ctrl;
  output [7:0] out;
  wire [7:0] x,y;
  
	//1 bit shift left
	mux2X1 muxl_10 (.in0(1'b0), .in1(in[0]), .sel(ctrl[0]), .out(x[0]));
	mux2X1 muxl_11 (.in0(in[0]), .in1(in[1]), .sel(ctrl[0]), .out(x[1]));
	mux2X1 muxl_12 (.in0(in[1]), .in1(in[2]), .sel(ctrl[0]), .out(x[2]));
	mux2X1 muxl_13 (.in0(in[2]), .in1(in[3]), .sel(ctrl[0]), .out(x[3]));
	mux2X1 muxl_14 (.in0(in[3]), .in1(in[4]), .sel(ctrl[0]), .out(x[4]));
	mux2X1 muxl_15 (.in0(in[4]), .in1(in[5]), .sel(ctrl[0]), .out(x[5]));
	mux2X1 muxl_16 (.in0(in[5]), .in1(in[6]), .sel(ctrl[0]), .out(x[6]));
	mux2X1 muxl_17 (.in0(in[6]), .in1(in[7]), .sel(ctrl[0]), .out(x[7]));
	
	//2 bit shift left
	mux2X1 muxl_20 (.in0(1'b0), .in1(x[0]), .sel(ctrl[1]), .out(y[0]));
	mux2X1 muxl_21 (.in0(1'b0), .in1(x[1]), .sel(ctrl[1]), .out(y[1]));
	mux2X1 muxl_22 (.in0(x[0]), .in1(x[2]), .sel(ctrl[1]), .out(y[2]));
	mux2X1 muxl_23 (.in0(x[1]), .in1(x[3]), .sel(ctrl[1]), .out(y[3]));
	mux2X1 muxl_24 (.in0(x[2]), .in1(x[4]), .sel(ctrl[1]), .out(y[4]));
	mux2X1 muxl_25 (.in0(x[3]), .in1(x[5]), .sel(ctrl[1]), .out(y[5]));
	mux2X1 muxl_26 (.in0(x[4]), .in1(x[6]), .sel(ctrl[1]), .out(y[6]));
	mux2X1 muxl_27 (.in0(x[5]), .in1(x[7]), .sel(ctrl[1]), .out(y[7]));
	
	//4 bit shift left
	mux2X1 muxl_40 (.in0(1'b0), .in1(y[0]), .sel(ctrl[2]), .out(out[0]));
	mux2X1 muxl_41 (.in0(1'b0), .in1(y[1]), .sel(ctrl[2]), .out(out[1]));
	mux2X1 muxl_42 (.in0(1'b0), .in1(y[2]), .sel(ctrl[2]), .out(out[2]));
	mux2X1 muxl_43 (.in0(1'b0), .in1(y[3]), .sel(ctrl[2]), .out(out[3]));
	mux2X1 muxl_44 (.in0(y[2]), .in1(y[4]), .sel(ctrl[2]), .out(out[4]));
	mux2X1 muxl_45 (.in0(y[3]), .in1(y[5]), .sel(ctrl[2]), .out(out[5]));
	mux2X1 muxl_46 (.in0(y[4]), .in1(y[6]), .sel(ctrl[2]), .out(out[6]));
	mux2X1 muxl_47 (.in0(y[5]), .in1(y[7]), .sel(ctrl[2]), .out(out[7]));
	
endmodule