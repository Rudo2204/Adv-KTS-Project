module full_adder_4b(a, b, cin, sum, cout);

// Inputs
input [3:0] a, b;
input cin;

// Outputs
output [3:0] sum;
output cout;

// Init temp variable to calcualte
reg [4:0] temp;
always @(*) // anonymous process
begin
temp = {1'b0,a} + {1'b0,b} + {1'b0,cin};
end
assign sum = temp[3:0];
assign cout = temp[4];
endmodule
