// Muxer 2 to 1 (G + H -> F) [M]
// f = (h.~m) + (g.x)
module mux_2to1(
input g,
input h,
input m,
output reg f
);
always@(*) begin
case(m)
1'b0: f = h;
1'b1: f = g;
endcase
end
endmodule

// Logic Unit
module logic_unit(
input a,
input b,
input [1:0] s,
output reg h
);
always@(*) begin
case(s)
2'b00: h = a & b; // AND op
2'b01: h = a | b; // OR op
2'b10: h = a ^ b; // XOR op
2'b11: h = ~(a ^ b); // XNOR op
endcase
end
endmodule

// Arithmetic Unit
module arithmetic_unit(
input a,
input b,
input cin,
input [1:0] s,
output reg g,
output reg cout
);
reg c1, c2, s1; // Used locally to make full-adders
always@(*) begin
case(s)
2'b00: // a + cin
begin
g = a ^ cin;
cout = a & cin;
end

2'b01: // a + b + cin
begin
s1 = a ^ b;
c1 = a & b;
g = s1 ^ cin;
c2 = s1 & cin;
cout = c1 | c2;
end

2'b10: // a + ~b + cin
begin
s1 = a ^ (~b);
c1 = a & (~b);
g = s1 ^ cin;
c2 = s1 & cin;
cout = c1 | c2;
end

2'b11: // ~a + b + cin
begin
s1 = (~a) ^ b;
c1 = (~a) & b;
g = s1 ^ cin;
c2 = s1 & cin;
cout = c1 | c2;
end
endcase
end
endmodule

// Module ALU 1 bit
module alu(
input a,
input b,
input cin,
input m,
input [1:0] s,
output f,
output cout
);
wire g, h;
logic_unit u1(a, b, s, h);
arithmetic_unit u2(a, b, cin, s, g, cout);
mux_2to1 u3(g, h, m, f);
endmodule

// Module ALU 4 bit made from 4 ALU 1 bit
module alu_4b(
input [3:0] a,
input [3:0] b,
input cin,
input m,
input [1:0] s,
output [3:0] f,
output cout
);
wire c1, c2, c3; // Used locally
alu alu1(a[0], b[0], cin, m, s, f[0], c1);
alu alu2(a[1], b[1], c1, m, s, f[1], c2);
alu alu3(a[2], b[2], c2, m, s, f[2], c3);
alu alu4(a[3], b[3], c3, m, s, f[3], cout);
endmodule