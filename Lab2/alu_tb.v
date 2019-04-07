module alu_tb();
// Inputs
reg [3:0] a, b;
reg cin;
reg [1:0] s;
reg m;

// Outputs
wire [3:0] f;
wire cout;

// Init UUT
alu_4b UUT(
.a(a),
.b(b),
.cin(cin),
.m(m),
.s(s),
.f(f),
.cout(cout)
);

initial begin
// Init inputs
s = 2'b00;
m = 1'b0;
a = 4'h00;
b = 4'h00;
cin = 1'b0;
#10;

s = 2'b10;
m = 1'b1;
a = 4'h05;
b = 4'h08;
cin = 1'b1;
#10;

s = 2'b01;
m = 1'b0;
a = 4'h07;
b = 4'h05;
cin = 1'b1;
#10;

s = 2'b01;
m = 1'b1;
a = 4'h05;
b = 4'h08;
cin = 1'b0;
#10;
end
endmodule
