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
			//If a is NaN or b is NaN return NaN
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 255 && b_mantissa != 0)) begin
				o_sign = a_sign;
				o_exponent = 255;
				o_mantissa = a_mantissa;
			//If a is inf and b is inf return NaN
			end else if ((a_exponent == 255) && (b_exponent == 255)) begin
				o_sign = 1;
				o_exponent = 255;
				o_mantissa[22] = 1;
				o_mantissa[21:0] = 0;
			//If a is inf return inf
			end else if (a_exponent == 255) begin
				o_sign = a_sign;
				o_exponent = 255;
				o_mantissa = 0;
				//If b is zero return NaN
				if ((b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = 1;
				o_exponent = 255;
				o_mantissa[22] = 1;
				o_mantissa[21:0] = 0;
				end
			//If B is inf return zero
			end else if (b_exponent == 255) begin
				o_sign = b_sign;
				o_exponent = 0;
				o_mantissa = 0;
			//If a is zero return zero
			end else if ((a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = 0;
				o_mantissa = 0;
			//If b is zero return NaN
				if ((b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = 1;
				o_exponent = 255;
				o_mantissa[22] = 1;
				o_mantissa[21:0] = 0;
			end
			//If b is zero return inf
			end else if ((b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin
			//Pass all corner cases
				divider_a_in = A;
				divider_b_in = B;
				o_sign = divider_out[31];
				o_exponent = divider_out[30:23];
				o_mantissa = divider_out[22:0];
			end
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
			end else if (((a_exponent == 0) && (a_mantissa == 0)) || ((b_exponent == 0) && (b_mantissa == 0))) begin
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
  
	reg [23:0] add_a_in0;
	reg [23:0] add_b_in0;
	reg add_op0;
	wire [24:0] add_out0;

	fa_24b add0
	(
		.a(add_a_in0),
		.b(add_b_in0),
		.op(add_op0),
		.out(add_out0)
	);

	reg [23:0] add_a_in1;
	reg [23:0] add_b_in1;
	reg add_op1;
	wire [24:0] add_out1;

	fa_24b add1
	(
		.a(add_a_in1),
		.b(add_b_in1),
		.op(add_op1),
		.out(add_out1)
	);

	reg [23:0] add_a_in2;
	reg [23:0] add_b_in2;
	reg add_op2;
	wire [24:0] add_out2;

	fa_24b add2
	(
		.a(add_a_in2),
		.b(add_b_in2),
		.op(add_op2),
		.out(add_out2)
	);

	reg [23:0] add_a_in3;
	reg [23:0] add_b_in3;
	reg add_op3;
	wire [24:0] add_out3;

	fa_24b add3
	(
		.a(add_a_in3),
		.b(add_b_in3),
		.op(add_op3),
		.out(add_out3)
	);

	reg [23:0] add_a_in4;
	reg [23:0] add_b_in4;
	reg add_op4;
	wire [24:0] add_out4;

	fa_24b add4
	(
		.a(add_a_in4),
		.b(add_b_in4),
		.op(add_op4),
		.out(add_out4)
	);

	reg [23:0] add_a_in5;
	reg [23:0] add_b_in5;
	reg add_op5;
	wire [24:0] add_out5;

	fa_24b add5
	(
		.a(add_a_in5),
		.b(add_b_in5),
		.op(add_op5),
		.out(add_out5)
	);

	reg [23:0] add_a_in6;
	reg [23:0] add_b_in6;
	reg add_op6;
	wire [24:0] add_out6;

	fa_24b add6
	(
		.a(add_a_in6),
		.b(add_b_in6),
		.op(add_op6),
		.out(add_out6)
	);

	reg [23:0] add_a_in7;
	reg [23:0] add_b_in7;
	reg add_op7;
	wire [24:0] add_out7;

	fa_24b add7
	(
		.a(add_a_in7),
		.b(add_b_in7),
		.op(add_op7),
		.out(add_out7)
	);

	reg [23:0] add_a_in8;
	reg [23:0] add_b_in8;
	reg add_op8;
	wire [24:0] add_out8;

	fa_24b add8
	(
		.a(add_a_in8),
		.b(add_b_in8),
		.op(add_op8),
		.out(add_out8)
	);

	reg [23:0] add_a_in9;
	reg [23:0] add_b_in9;
	reg add_op9;
	wire [24:0] add_out9;

	fa_24b add9
	(
		.a(add_a_in9),
		.b(add_b_in9),
		.op(add_op9),
		.out(add_out9)
	);
	
  reg  [7:0] i_e;
  reg  [24:0] i_m;
  wire [7:0] o_e;
  wire [24:0] o_m;

  addition_normaliser norm1
  (
    .in_e(i_e),
    .in_m(i_m),
    .out_e(o_e),
    .out_m(o_m)
  );
  
  reg [31:0] shift_in0;
  reg [4:0] shift_ctrl0;
  wire [31:0] shift_out0;
  
  barrel_shifter_32bit shift0
  (
	.in(shift_in0),
	.ctrl(shift_ctrl0),
	.out(shift_out0)
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
        //o_mantissa = a_mantissa + b_mantissa;
		add_a_in0 = a_mantissa;
		add_b_in0 = b_mantissa;
		add_op0 = 1'b0;
		o_mantissa = add_out0;
        //Signify to shift
        o_mantissa[24] = 1;
        o_sign = a_sign;
      end else begin // Opposite signs = subtract
        if(a_mantissa > b_mantissa) begin
          //o_mantissa = a_mantissa - b_mantissa;
		  add_a_in1 = a_mantissa;
		  add_b_in1 = ~b_mantissa;
		  add_op1 = 1'b1;
		  o_mantissa = {1'b0, add_out1[23:0]};
          o_sign = a_sign;
        end else begin
          //o_mantissa = b_mantissa - a_mantissa;
		  add_a_in2 = ~a_mantissa;
		  add_b_in2 = b_mantissa;
		  add_op2 = 1'b1;
		  o_mantissa = {1'b0, add_out2[23:0]};
          o_sign = b_sign;
        end
      end
    end else begin //Unequal exponents
      if (a_exponent > b_exponent) begin // A is bigger
        o_exponent = a_exponent;
        o_sign = a_sign;
		//diff = a_exponent - b_exponent;
		add_a_in3 = {16'h00, a_exponent};
		add_b_in3 = ~{16'h00, b_exponent};
		add_op3 = 1'b1;
		diff = add_out3[7:0];		
		if (diff > 32) begin // A is much bigger than B
		o_mantissa = a_mantissa;
		end else begin
		// tmp_mantissa = b_mantissa >> diff;
		shift_in0 = {8'h00, b_mantissa};
		shift_ctrl0 = diff[4:0];
		tmp_mantissa = shift_out0[23:0];
        if (a_sign == b_sign) begin
          // o_mantissa = a_mantissa + tmp_mantissa;
		  add_a_in4 = a_mantissa;
		  add_b_in4 = tmp_mantissa;
		  add_op4 = 1'b0;
		  o_mantissa = add_out4;
		  end
        else begin
          	//o_mantissa = a_mantissa - tmp_mantissa;
			add_a_in5 = a_mantissa;
			add_b_in5 = ~tmp_mantissa;
			add_op5 = 1'b1;
			o_mantissa = {1'b0, add_out5[23:0]};
		end
		end
      end else if (a_exponent < b_exponent) begin // B is bigger
        o_exponent = b_exponent;
        o_sign = b_sign;
        //diff = b_exponent - a_exponent;
		add_a_in6 = ~{16'h00, a_exponent};
		add_b_in6 = {16'h00, b_exponent};
		add_op6 = 1'b1;
		diff = add_out6[7:0];
		if (diff > 32) begin // B is much bigger than A
		o_mantissa = b_mantissa;
		end else begin
        //tmp_mantissa = a_mantissa >> diff;
		shift_in0 = {8'h00, a_mantissa};
		shift_ctrl0 = diff[4:0];
		tmp_mantissa = shift_out0;
        if (a_sign == b_sign) begin
          //o_mantissa = b_mantissa + tmp_mantissa;
		  add_a_in7 = b_mantissa;
		  add_b_in7 = tmp_mantissa;
		  add_op7 = 1'b0;
		  o_mantissa = add_out7;
        end else begin
			// o_mantissa = b_mantissa - tmp_mantissa;
			add_a_in8 = b_mantissa;
			add_b_in8 = ~tmp_mantissa;
			add_op8 = 1'b1;
			o_mantissa = {1'b0, add_out8[23:0]};
        end
		end
      end
    end
	//Normalization
    if(o_mantissa[24] == 1) begin
      //o_exponent = o_exponent + 1;
	  add_a_in9 = {16'h00, o_exponent};
	  add_b_in9 = 24'h01;
	  add_op9 = 1'b0;
	  o_exponent = add_out9[7:0];
      //o_mantissa = o_mantissa >> 1;
	  o_mantissa = {1'b0, o_mantissa[24:1]};
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
	
	reg [23:0] add_a_norm0;
	reg [23:0] add_b_norm0;
	reg add_op_norm0;
	wire [24:0] add_out_norm0;
	
	fa_24b mult_norm0
	(
		.a(add_a_norm0),
		.b(add_b_norm0),
		.op(add_op_norm0),
		.out(add_out_norm0)
	);
	
	reg [23:0] add_a_norm1;
	reg [23:0] add_b_norm1;
	reg add_op_norm1;
	wire [24:0] add_out_norm1;
	
	fa_24b mult_norm1
	(
		.a(add_a_norm1),
		.b(add_b_norm1),
		.op(add_op_norm1),
		.out(add_out_norm1)
	);
	
	reg [23:0] add_a_norm2;
	reg [23:0] add_b_norm2;
	reg add_op_norm2;
	wire [24:0] add_out_norm2;
	
	fa_24b mult_norm2
	(
		.a(add_a_norm2),
		.b(add_b_norm2),
		.op(add_op_norm2),
		.out(add_out_norm2)
	);
	
	reg [23:0] mul_a_in0;
	reg [23:0] mul_b_in0;
	wire [48:0] mul_out0;
	
	dadda24 mul0
	(
		.a(mul_a_in0),
		.b(mul_b_in0),
		.y(mul_out0)
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
    // o_exponent = a_exponent + b_exponent - 127;
	add_a_norm0 = {16'h00, a_exponent};
	add_b_norm0 = {16'h00, b_exponent};
	add_op_norm0 = 1'b0;
	add_a_norm1 = add_out_norm0;
	add_b_norm1 = ~24'd127;
	add_op_norm1 = 1'b1;
	o_exponent = add_out_norm1[7:0];
	
    //product = a_mantissa * b_mantissa;
	mul_a_in0 = a_mantissa;
	mul_b_in0 = b_mantissa;
	product = mul_out0[47:0];
	
		// Normalization
    if(product[47] == 1) begin
      // o_exponent = o_exponent + 1;
	  add_a_norm2 = {16'h00, o_exponent};
	  add_b_norm2 = 24'h01;
	  add_op_norm2 = 1'b0;
	  o_exponent = add_out_norm2[7:0];
      // product = product >> 1;
	  product = {1'b0, product[47:1]};
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
  reg [24:0] tmp_m;
  
  reg [23:0] addition_norm_a;
  reg [23:0] addition_norm_b;
  reg addition_norm_op;
  wire [24:0] addition_norm_out;
	
  fa_24b addition_norm
  (
	.a(addition_norm_a),
	.b(addition_norm_b),
	.op(addition_norm_op),
	.out(addition_norm_out)
  );  

  always @ ( * ) begin
		if (in_m[23:3] == 21'b000000000000000000001) begin
			//out_e = in_e - 20;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd20;
			addition_norm_op = 1'b1;
			//out_m = in_m << 20;
			out_m = {in_m[4:0], 20'h00};
		end else if (in_m[23:4] == 20'b00000000000000000001) begin
			// out_e = in_e - 19;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd19;
			addition_norm_op = 1'b1;
			// out_m = in_m << 19;
			out_m = {in_m[5:0], 19'h00};
		end else if (in_m[23:5] == 19'b0000000000000000001) begin
			// out_e = in_e - 18;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd18;
			addition_norm_op = 1'b1;
			// out_m = in_m << 18;
			out_m = {in_m[6:0], 18'h00};
		end else if (in_m[23:6] == 18'b000000000000000001) begin
			// out_e = in_e - 17;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd17;
			addition_norm_op = 1'b1;
			// out_m = in_m << 17;
			out_m = {in_m[7:0], 17'h00};
		end else if (in_m[23:7] == 17'b00000000000000001) begin
			// out_e = in_e - 16;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd16;
			addition_norm_op = 1'b1;
			// out_m = in_m << 16;
			out_m = {in_m[8:0], 16'h00};
		end else if (in_m[23:8] == 16'b0000000000000001) begin
			// out_e = in_e - 15;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd15;
			addition_norm_op = 1'b1;
			// out_m = in_m << 15;
			out_m = {in_m[9:0], 15'h00};
		end else if (in_m[23:9] == 15'b000000000000001) begin
			// out_e = in_e - 14;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd14;
			addition_norm_op = 1'b1;
			// out_m = in_m << 14;
			out_m = {in_m[10:0], 14'h00};
		end else if (in_m[23:10] == 14'b00000000000001) begin
			// out_e = in_e - 13;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd13;
			addition_norm_op = 1'b1;
			// out_m = in_m << 13;
			out_m = {in_m[11:0], 13'h00};
		end else if (in_m[23:11] == 13'b0000000000001) begin
			// out_e = in_e - 12;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd12;
			addition_norm_op = 1'b1;
			// out_m = in_m << 12;
			out_m = {in_m[12:0], 12'h00};
		end else if (in_m[23:12] == 12'b000000000001) begin
			// out_e = in_e - 11;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd11;
			addition_norm_op = 1'b1;
			// out_m = in_m << 11;
			out_m = {in_m[13:0], 11'h00};
		end else if (in_m[23:13] == 11'b00000000001) begin
			// out_e = in_e - 10;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd10;
			addition_norm_op = 1'b1;
			// out_m = in_m << 10;
			out_m = {in_m[14:0], 10'h00};
		end else if (in_m[23:14] == 10'b0000000001) begin
			// out_e = in_e - 9;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd9;
			addition_norm_op = 1'b1;
			// out_m = in_m << 9;
			out_m = {in_m[15:0], 9'h00};
		end else if (in_m[23:15] == 9'b000000001) begin
			// out_e = in_e - 8;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd8;
			addition_norm_op = 1'b1;
			// out_m = in_m << 8;
			out_m = {in_m[16:0], 8'h00};
		end else if (in_m[23:16] == 8'b00000001) begin
			// out_e = in_e - 7;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd7;
			addition_norm_op = 1'b1;
			// out_m = in_m << 7;
			out_m = {in_m[17:0], 7'h00};
		end else if (in_m[23:17] == 7'b0000001) begin
			// out_e = in_e - 6;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd6;
			addition_norm_op = 1'b1;
			// out_m = in_m << 6;
			out_m = {in_m[18:0], 6'h00};
		end else if (in_m[23:18] == 6'b000001) begin
			// out_e = in_e - 5;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd5;
			addition_norm_op = 1'b1;
			// out_m = in_m << 5;
			out_m = {in_m[19:0], 5'h00};
		end else if (in_m[23:19] == 5'b00001) begin
			// out_e = in_e - 4;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd4;
			addition_norm_op = 1'b1;
			// out_m = in_m << 4;
			out_m = {in_m[20:0], 4'h0};
		end else if (in_m[23:20] == 4'b0001) begin
			// out_e = in_e - 3;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd3;
			addition_norm_op = 1'b1;
			// out_m = in_m << 3;
			out_m = {in_m[21:0], 3'h0};
		end else if (in_m[23:21] == 3'b001) begin
			// out_e = in_e - 2;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd2;
			addition_norm_op = 1'b1;
			// out_m = in_m << 2;
			out_m = {in_m[22:0], 2'h0};
		end else if (in_m[23:22] == 2'b01) begin
			// out_e = in_e - 1;
			addition_norm_a = {16'h00, in_e};
			addition_norm_b = ~24'd1;
			addition_norm_op = 1'b1;
			// out_m = in_m << 1;
			out_m = {in_m[23:0], 1'h0};
		end
		//Exception checker
		//If overflow, return inf
		if ($signed(addition_norm_out[9:0]) > 255) begin
			out_e = 255;
			out_m = 0;
		//If underflow, return zero
		end else if ($signed(addition_norm_out[9:0]) < -255) begin
			out_e = 0;
			out_m =0;
		end else begin
			out_e = addition_norm_out[7:0];
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
  reg [47:0] tmp_man;
  
  reg [23:0] multiplication_norm_a;
  reg [23:0] multiplication_norm_b;
  reg multiplication_norm_op;
  wire [24:0] multiplication_norm_out;
  
  fa_24b multiplication_norm
  (
	.a(multiplication_norm_a),
	.b(multiplication_norm_b),
	.op(multiplication_norm_op),
	.out(multiplication_norm_out)
  ); 

  always @ ( * ) begin
	  if (in_m[46:41] == 6'b000001) begin
			// out_e = in_e - 5;
			multiplication_norm_a = {16'h00, in_e};
			multiplication_norm_b = ~24'd5;
			multiplication_norm_op = 1'b1;
			// out_m = in_m << 5;
			out_m = {in_m[42:0], 5'h00};
		end else if (in_m[46:42] == 5'b00001) begin
			// out_e = in_e - 4;
			multiplication_norm_a = {16'h00, in_e};
			multiplication_norm_b = ~24'd4;
			multiplication_norm_op = 1'b1;
			// out_m = in_m << 4;
			out_m = {in_m[43:0], 4'h0};
		end else if (in_m[46:43] == 4'b0001) begin
			// out_e = in_e - 3;
			multiplication_norm_a = {16'h00, in_e};
			multiplication_norm_b = ~24'd3;
			multiplication_norm_op = 1'b1;
			// out_m = in_m << 3;
			out_m = {in_m[44:0], 3'h0};
		end else if (in_m[46:44] == 3'b001) begin
			// out_e = in_e - 2;
			multiplication_norm_a = {16'h00, in_e};
			multiplication_norm_b = ~24'd2;
			multiplication_norm_op = 1'b1;
			// out_m = in_m << 2;
			out_m = {in_m[45:0], 2'h0};
		end else if (in_m[46:45] == 2'b01) begin
			// out_e = in_e - 1;
			multiplication_norm_a = {16'h00, in_e};
			multiplication_norm_b = ~24'd1;
			multiplication_norm_op = 1'b1;
			// out_m = in_m << 1;
			out_m = {in_m[46:0], 1'h0};
		end
		//Exception checker
		//If overflow, return inf
		if ($signed(multiplication_norm_out[9:0]) > 255) begin
			out_e = 255;
			out_m = 0;
		//If underflow, return zero
		end else if ($signed(multiplication_norm_out[9:0]) < -255) begin
			out_e = 0;
			out_m =0;
		end else begin
			out_e = multiplication_norm_out[7:0];
		end			
  end
endmodule

module divider (a, b, out);
	input [31:0] a;
	input [31:0] b;
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
	reg [23:0] tmp_mantissa;
	
	assign out[31] = o_sign;
	assign out[30:23] = o_exponent;
	assign out[22:0] = o_mantissa[22:0];
	
	reg [23:0] add_a_div0;
	reg [23:0] add_b_div0;
	reg add_op_div0;
	wire [24:0] add_out_div0;
	
	reg [47:0] dividend;
	reg [47:0] divisor;
	reg [47:0] tmp;
	
	fa_24b add_div0
	(
		.a(add_a_div0),
		.b(add_b_div0),
		.op(add_op_div0),
		.out(add_out_div0)
	);
	
	reg [23:0] add_a_div1;
	reg [23:0] add_b_div1;
	reg add_op_div1;
	wire [24:0] add_out_div1;
	
	fa_24b add_div1
	(
		.a(add_a_div1),
		.b(add_b_div1),
		.op(add_op_div1),
		.out(add_out_div1)
	);
	
	reg [23:0] add_a_div2;
	reg [23:0] add_b_div2;
	reg add_op_div2;
	wire [24:0] add_out_div2;
	
	fa_24b add_div2
	(
		.a(add_a_div2),
		.b(add_b_div2),
		.op(add_op_div2),
		.out(add_out_div2)
	);

	  reg  [7:0] i_e;
	  reg  [24:0] i_m;
	  wire [7:0] o_e;
	  wire [24:0] o_m;

	  addition_normaliser norm1
	  (
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e),
		.out_m(o_m)
	  );
	  
	  reg [47:0] div_module_a_in;
	  reg [47:0] div_module_b_in;
	  wire [23:0] div_module_out;
	  
	  div_module div_mod
	  (
		.a(div_module_a_in),
		.b(div_module_b_in),
		.out(div_module_out)
	  );
	
  always @ (*) begin
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
		//Sign of result by XOR
		o_sign = a_sign ^ b_sign;
		
		// o_exponent = a_exponent - b_exponent + 127;
		add_a_div0 = {16'h00, a_exponent};
		add_b_div0 = ~{16'h00, b_exponent};
		add_op_div0 = 1'b1;
		add_a_div1 = add_out_div0;
		add_b_div1 = 24'd127;
		add_op_div1 = 1'b0;
		o_exponent = add_out_div1[7:0];
		
		//Padding
		//dividend = a_mantissa << 24;
		dividend = {a_mantissa, 24'h00};
		divisor = {24'h00, b_mantissa};
		
		//Division module
		div_module_a_in = dividend;
		div_module_b_in = divisor;
		o_mantissa[23:0] = div_module_out;
		
 		//Normalization
		if(o_mantissa[24] == 1) begin
		//o_exponent = o_exponent + 1;
		add_a_div2 = {16'h00, o_exponent};
		add_b_div2 = 24'h01;
		add_op_div2 = 1'b0;
		o_exponent = add_out_div2[7:0];
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

module fa_48b(a, b, op, out, cout);
input [47:0] a, b;
input op;
output [47:0] out;
output cout;
wire [47:0] a, b;
wire op;
wire [47:0] out;
wire cout;
wire [46:0] c;

fa u0 (a[0], b[0], op, out[0], c[0]);
fa u[46:1] (a[46:1], b[46:1], c[45:0], out[46:1], c[46:1]);
fa u47 (a[47], b[47], c[46], out[47], cout);
endmodule

module fa_24b(a, b, op, out);
input [23:0] a, b;
input op;
output [24:0] out;
wire [23:0] a, b;
wire op;
wire [24:0] out;
wire [22:0] c;

fa d0(a[0], b[0], op, out[0], c[0]);
fa d[22:1] (a[22:1], b[22:1], c[21:0], out[22:1], c[22:1]);
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

module barrel_shifter_32bit (in, ctrl, out);
    input [31:0] in;
    input [4:0] ctrl;
    output [31:0] out;
    wire [31:0] x0, x1, x2, x3;
//16 bit shift right
mux2X1 mux16_1[31:16] (in[31:16], 1'b0, ctrl[4], x0[31:16]);
mux2X1 mux16_2[15:0] (in[15:0], in[31:16], ctrl[4], x0[15:0]);

// 8 bit shift right
mux2X1 mux8_1[31:24] (x0[31:24], 1'b0, ctrl[3], x1[31:24]);
mux2X1 mux8_2[23:0] (x0[23:0], x0[31:8], ctrl[3], x1[23:0]);

//4 bit shift right
mux2X1 mux4_1[31:28] (x1[31:28], 1'b0, ctrl[2], x2[31:28]);
mux2X1 mux4_2[27:0] (x1[27:0], x1[31:4], ctrl[2], x2[27:0]);

//2 bit shift right
mux2X1 mux2_1[31:30] (x2[31:30], 1'b0, ctrl[1], x3[31:30]);
mux2X1 mux2_2[29:0] (x2[29:0], x2[31:2], ctrl[1], x3[29:0]);

//1 bit shift right
mux2X1 mux1_1 (x3[31], 1'b0, ctrl[0], out[31]);
mux2X1 mux1_2[30:0] (x3[30:0], x3[31:1], ctrl[0], out[30:0]);
endmodule

module div(a, b, out, div_cout);
input [47:0] a, b;
output [47:0] out;
output div_cout;

wire [47:0] a, b;
reg [47:0] out;
reg div_cout;

reg [47:0] sub_a_in, sub_b_in;
reg sub_op;
wire [47:0] sub_out;
wire sub_cout;

fa_48b sub_48b
(
	.a(sub_a_in),
	.b(sub_b_in),
	.op(sub_op),
	.out(sub_out),
	.cout(sub_cout)
);

always @ (*) begin
	sub_a_in = a;
	sub_b_in = ~b;
	sub_op = 1'b1;
	//If carry = 1 then return value, else restore
	out = (sub_cout) ? sub_out : a;
	div_cout = sub_cout;
end
endmodule

module div_module (a, b, out);
input [47:0] a, b;
output [23:0] out;

wire [47:0] a, b;
reg [23:0] out;

reg [48:0] q, r;

reg [47:0] div_a_in0; wire [47:0] div_out0; wire div_cout0;
div div_m0 (.a(div_a_in0), .b(b), .out(div_out0), .div_cout(div_cout0));
reg [47:0] div_a_in1; wire [47:0] div_out1; wire div_cout1;
div div_m1 (.a(div_a_in1), .b(b), .out(div_out1), .div_cout(div_cout1));
reg [47:0] div_a_in2; wire [47:0] div_out2; wire div_cout2;
div div_m2 (.a(div_a_in2), .b(b), .out(div_out2), .div_cout(div_cout2));
reg [47:0] div_a_in3; wire [47:0] div_out3; wire div_cout3;
div div_m3 (.a(div_a_in3), .b(b), .out(div_out3), .div_cout(div_cout3));
reg [47:0] div_a_in4; wire [47:0] div_out4; wire div_cout4;
div div_m4 (.a(div_a_in4), .b(b), .out(div_out4), .div_cout(div_cout4));
reg [47:0] div_a_in5; wire [47:0] div_out5; wire div_cout5;
div div_m5 (.a(div_a_in5), .b(b), .out(div_out5), .div_cout(div_cout5));
reg [47:0] div_a_in6; wire [47:0] div_out6; wire div_cout6;
div div_m6 (.a(div_a_in6), .b(b), .out(div_out6), .div_cout(div_cout6));
reg [47:0] div_a_in7; wire [47:0] div_out7; wire div_cout7;
div div_m7 (.a(div_a_in7), .b(b), .out(div_out7), .div_cout(div_cout7));
reg [47:0] div_a_in8; wire [47:0] div_out8; wire div_cout8;
div div_m8 (.a(div_a_in8), .b(b), .out(div_out8), .div_cout(div_cout8));
reg [47:0] div_a_in9; wire [47:0] div_out9; wire div_cout9;
div div_m9 (.a(div_a_in9), .b(b), .out(div_out9), .div_cout(div_cout9));
reg [47:0] div_a_in10; wire [47:0] div_out10; wire div_cout10;
div div_m10 (.a(div_a_in10), .b(b), .out(div_out10), .div_cout(div_cout10));
reg [47:0] div_a_in11; wire [47:0] div_out11; wire div_cout11;
div div_m11 (.a(div_a_in11), .b(b), .out(div_out11), .div_cout(div_cout11));
reg [47:0] div_a_in12; wire [47:0] div_out12; wire div_cout12;
div div_m12 (.a(div_a_in12), .b(b), .out(div_out12), .div_cout(div_cout12));
reg [47:0] div_a_in13; wire [47:0] div_out13; wire div_cout13;
div div_m13 (.a(div_a_in13), .b(b), .out(div_out13), .div_cout(div_cout13));
reg [47:0] div_a_in14; wire [47:0] div_out14; wire div_cout14;
div div_m14 (.a(div_a_in14), .b(b), .out(div_out14), .div_cout(div_cout14));
reg [47:0] div_a_in15; wire [47:0] div_out15; wire div_cout15;
div div_m15 (.a(div_a_in15), .b(b), .out(div_out15), .div_cout(div_cout15));
reg [47:0] div_a_in16; wire [47:0] div_out16; wire div_cout16;
div div_m16 (.a(div_a_in16), .b(b), .out(div_out16), .div_cout(div_cout16));
reg [47:0] div_a_in17; wire [47:0] div_out17; wire div_cout17;
div div_m17 (.a(div_a_in17), .b(b), .out(div_out17), .div_cout(div_cout17));
reg [47:0] div_a_in18; wire [47:0] div_out18; wire div_cout18;
div div_m18 (.a(div_a_in18), .b(b), .out(div_out18), .div_cout(div_cout18));
reg [47:0] div_a_in19; wire [47:0] div_out19; wire div_cout19;
div div_m19 (.a(div_a_in19), .b(b), .out(div_out19), .div_cout(div_cout19));
reg [47:0] div_a_in20; wire [47:0] div_out20; wire div_cout20;
div div_m20 (.a(div_a_in20), .b(b), .out(div_out20), .div_cout(div_cout20));
reg [47:0] div_a_in21; wire [47:0] div_out21; wire div_cout21;
div div_m21 (.a(div_a_in21), .b(b), .out(div_out21), .div_cout(div_cout21));
reg [47:0] div_a_in22; wire [47:0] div_out22; wire div_cout22;
div div_m22 (.a(div_a_in22), .b(b), .out(div_out22), .div_cout(div_cout22));
reg [47:0] div_a_in23; wire [47:0] div_out23; wire div_cout23;
div div_m23 (.a(div_a_in23), .b(b), .out(div_out23), .div_cout(div_cout23));
reg [47:0] div_a_in24; wire [47:0] div_out24; wire div_cout24;
div div_m24 (.a(div_a_in24), .b(b), .out(div_out24), .div_cout(div_cout24));
reg [47:0] div_a_in25; wire [47:0] div_out25; wire div_cout25;
div div_m25 (.a(div_a_in25), .b(b), .out(div_out25), .div_cout(div_cout25));
reg [47:0] div_a_in26; wire [47:0] div_out26; wire div_cout26;
div div_m26 (.a(div_a_in26), .b(b), .out(div_out26), .div_cout(div_cout26));
reg [47:0] div_a_in27; wire [47:0] div_out27; wire div_cout27;
div div_m27 (.a(div_a_in27), .b(b), .out(div_out27), .div_cout(div_cout27));
reg [47:0] div_a_in28; wire [47:0] div_out28; wire div_cout28;
div div_m28 (.a(div_a_in28), .b(b), .out(div_out28), .div_cout(div_cout28));
reg [47:0] div_a_in29; wire [47:0] div_out29; wire div_cout29;
div div_m29 (.a(div_a_in29), .b(b), .out(div_out29), .div_cout(div_cout29));
reg [47:0] div_a_in30; wire [47:0] div_out30; wire div_cout30;
div div_m30 (.a(div_a_in30), .b(b), .out(div_out30), .div_cout(div_cout30));
reg [47:0] div_a_in31; wire [47:0] div_out31; wire div_cout31;
div div_m31 (.a(div_a_in31), .b(b), .out(div_out31), .div_cout(div_cout31));
reg [47:0] div_a_in32; wire [47:0] div_out32; wire div_cout32;
div div_m32 (.a(div_a_in32), .b(b), .out(div_out32), .div_cout(div_cout32));
reg [47:0] div_a_in33; wire [47:0] div_out33; wire div_cout33;
div div_m33 (.a(div_a_in33), .b(b), .out(div_out33), .div_cout(div_cout33));
reg [47:0] div_a_in34; wire [47:0] div_out34; wire div_cout34;
div div_m34 (.a(div_a_in34), .b(b), .out(div_out34), .div_cout(div_cout34));
reg [47:0] div_a_in35; wire [47:0] div_out35; wire div_cout35;
div div_m35 (.a(div_a_in35), .b(b), .out(div_out35), .div_cout(div_cout35));
reg [47:0] div_a_in36; wire [47:0] div_out36; wire div_cout36;
div div_m36 (.a(div_a_in36), .b(b), .out(div_out36), .div_cout(div_cout36));
reg [47:0] div_a_in37; wire [47:0] div_out37; wire div_cout37;
div div_m37 (.a(div_a_in37), .b(b), .out(div_out37), .div_cout(div_cout37));
reg [47:0] div_a_in38; wire [47:0] div_out38; wire div_cout38;
div div_m38 (.a(div_a_in38), .b(b), .out(div_out38), .div_cout(div_cout38));
reg [47:0] div_a_in39; wire [47:0] div_out39; wire div_cout39;
div div_m39 (.a(div_a_in39), .b(b), .out(div_out39), .div_cout(div_cout39));
reg [47:0] div_a_in40; wire [47:0] div_out40; wire div_cout40;
div div_m40 (.a(div_a_in40), .b(b), .out(div_out40), .div_cout(div_cout40));
reg [47:0] div_a_in41; wire [47:0] div_out41; wire div_cout41;
div div_m41 (.a(div_a_in41), .b(b), .out(div_out41), .div_cout(div_cout41));
reg [47:0] div_a_in42; wire [47:0] div_out42; wire div_cout42;
div div_m42 (.a(div_a_in42), .b(b), .out(div_out42), .div_cout(div_cout42));
reg [47:0] div_a_in43; wire [47:0] div_out43; wire div_cout43;
div div_m43 (.a(div_a_in43), .b(b), .out(div_out43), .div_cout(div_cout43));
reg [47:0] div_a_in44; wire [47:0] div_out44; wire div_cout44;
div div_m44 (.a(div_a_in44), .b(b), .out(div_out44), .div_cout(div_cout44));
reg [47:0] div_a_in45; wire [47:0] div_out45; wire div_cout45;
div div_m45 (.a(div_a_in45), .b(b), .out(div_out45), .div_cout(div_cout45));
reg [47:0] div_a_in46; wire [47:0] div_out46; wire div_cout46;
div div_m46 (.a(div_a_in46), .b(b), .out(div_out46), .div_cout(div_cout46));
reg [47:0] div_a_in47; wire [47:0] div_out47; wire div_cout47;
div div_m47 (.a(div_a_in47), .b(b), .out(div_out47), .div_cout(div_cout47));
always@(*) begin
	q = 0; r = 0;
r[0] = a[47]; div_a_in47 = r; r = div_out47; q[0] = div_cout47; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[46]; div_a_in46 = r; r = div_out46; q[0] = div_cout46; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[45]; div_a_in45 = r; r = div_out45; q[0] = div_cout45; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[44]; div_a_in44 = r; r = div_out44; q[0] = div_cout44; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[43]; div_a_in43 = r; r = div_out43; q[0] = div_cout43; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[42]; div_a_in42 = r; r = div_out42; q[0] = div_cout42; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[41]; div_a_in41 = r; r = div_out41; q[0] = div_cout41; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[40]; div_a_in40 = r; r = div_out40; q[0] = div_cout40; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[39]; div_a_in39 = r; r = div_out39; q[0] = div_cout39; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[38]; div_a_in38 = r; r = div_out38; q[0] = div_cout38; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[37]; div_a_in37 = r; r = div_out37; q[0] = div_cout37; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[36]; div_a_in36 = r; r = div_out36; q[0] = div_cout36; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[35]; div_a_in35 = r; r = div_out35; q[0] = div_cout35; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[34]; div_a_in34 = r; r = div_out34; q[0] = div_cout34; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[33]; div_a_in33 = r; r = div_out33; q[0] = div_cout33; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[32]; div_a_in32 = r; r = div_out32; q[0] = div_cout32; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[31]; div_a_in31 = r; r = div_out31; q[0] = div_cout31; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[30]; div_a_in30 = r; r = div_out30; q[0] = div_cout30; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[29]; div_a_in29 = r; r = div_out29; q[0] = div_cout29; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[28]; div_a_in28 = r; r = div_out28; q[0] = div_cout28; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[27]; div_a_in27 = r; r = div_out27; q[0] = div_cout27; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[26]; div_a_in26 = r; r = div_out26; q[0] = div_cout26; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[25]; div_a_in25 = r; r = div_out25; q[0] = div_cout25; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[24]; div_a_in24 = r; r = div_out24; q[0] = div_cout24; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[23]; div_a_in23 = r; r = div_out23; q[0] = div_cout23; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[22]; div_a_in22 = r; r = div_out22; q[0] = div_cout22; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[21]; div_a_in21 = r; r = div_out21; q[0] = div_cout21; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[20]; div_a_in20 = r; r = div_out20; q[0] = div_cout20; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[19]; div_a_in19 = r; r = div_out19; q[0] = div_cout19; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[18]; div_a_in18 = r; r = div_out18; q[0] = div_cout18; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[17]; div_a_in17 = r; r = div_out17; q[0] = div_cout17; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[16]; div_a_in16 = r; r = div_out16; q[0] = div_cout16; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[15]; div_a_in15 = r; r = div_out15; q[0] = div_cout15; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[14]; div_a_in14 = r; r = div_out14; q[0] = div_cout14; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[13]; div_a_in13 = r; r = div_out13; q[0] = div_cout13; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[12]; div_a_in12 = r; r = div_out12; q[0] = div_cout12; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[11]; div_a_in11 = r; r = div_out11; q[0] = div_cout11; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[10]; div_a_in10 = r; r = div_out10; q[0] = div_cout10; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[9]; div_a_in9 = r; r = div_out9; q[0] = div_cout9; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[8]; div_a_in8 = r; r = div_out8; q[0] = div_cout8; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[7]; div_a_in7 = r; r = div_out7; q[0] = div_cout7; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[6]; div_a_in6 = r; r = div_out6; q[0] = div_cout6; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[5]; div_a_in5 = r; r = div_out5; q[0] = div_cout5; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[4]; div_a_in4 = r; r = div_out4; q[0] = div_cout4; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[3]; div_a_in3 = r; r = div_out3; q[0] = div_cout3; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[2]; div_a_in2 = r; r = div_out2; q[0] = div_cout2; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[1]; div_a_in1 = r; r = div_out1; q[0] = div_cout1; q = {q[47:0], 1'b0}; r = {r[47:0], 1'b0};
r[0] = a[0]; div_a_in0 = r; r = div_out0; q[0] = div_cout0;
	out = q[24:1];
end
endmodule