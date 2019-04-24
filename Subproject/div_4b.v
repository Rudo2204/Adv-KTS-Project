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

// module div_module_1b (dividend, divisor, r, q);
// input [47:0] dividend, divisor;
// output [48:0] r, q;

// wire [47:0] dividend, divisor;
// reg [48:0] r, q;

// reg [47:0] div_a_in; wire [48:0] div_out; wire div_cout;
// div h(.a(div_a_in)m .b(b), .out(div_out), .div_cout(div_cout));

// always@(*) begin
	// div_a_in = dividend;
	// div_out = 

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
	

// module div_module(a, b, out);
// input [3:0] a, b;
// output [3:0] out;

// wire [3:0] a, b;
// reg [3:0] out;

// reg [3:0] q, r;
// reg [3:0] val;

// always@(*) begin
	// q = 0; r = 0;
	// r[0] = a[3];
	// q[0] = (r >= b) ? 1'b1 : 1'b0;
	// r = (r >= b) ? (r - b) : r;
	// q = q << 1; r = r << 1;
	// r[0] = a[2];
	// q[0] = (r >= b) ? 1'b1 : 1'b0;
	// r = (r >= b) ? (r - b) : r;
	// q = q << 1; r = r << 1;
	// r[0] = a[1];
	// q[0] = (r >= b) ? 1'b1 : 1'b0;
	// r = (r >= b) ? (r - b) : r;
	// q = q << 1; r = r << 1;
	// r[0] = a[0];
	// q[0] = (r >= b) ? 1'b1 : 1'b0;
	// r = (r >= b) ? (r - b) : r;
	
	// out = q;
// end
// endmodule
	
