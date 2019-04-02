module FA_4b_Testbench();

// Inputs
reg [3:0] a;
reg [3:0] b;
reg cin;

// Outputs
wire [3:0] sum;
wire cout;

// Init UUT
full_adder_4b UUT(
.a(a),
.b(b),
.cin(cin),
.sum(sum),
.cout(cout)
);

initial begin
// Init Inputs
a = 4'b0;
b = 4'b0;
cin = 4'b0;

// Wait 10ns for global reset
#10

// Stimulus
for(cin = 0; cin<1; cin = cin + 1) begin
for(b = 0; b < 15; b = b + 1) begin
for(a = 0; a < 15; a = a + 1) begin
#10;
end
end
end

// Wait for the last cycle
#10;
end
endmodule