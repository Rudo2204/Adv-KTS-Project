//-----------------------------------------------------------
// File: fpu_tb.v
// FPU Test Bench
//-----------------------------------------------------------
`timescale 1 ns/100 ps
module fpu_tb ();
 //----------------------------------------------------------
 // inputs to the DUT are reg type
 reg clock;
 reg [31:0] a, b;
 reg [1:0] op;
 reg [31:0] correct;
 //----------------------------------------------------------
 // outputs from the DUT are wire type
 wire [31:0] out;
 wire [49:0] pro;
 //----------------------------------------------------------
 // instantiate the Device Under Test (DUT)
 // using named instantiation
 fpu U1 (
          .clk(clock),
          .A(a),
          .B(b),
          .opcode(op),
          .O(out)
        );
 //----------------------------------------------------------
 // create a 10Mhz clock
 always
 #100 clock = ~clock; // every 100 nanoseconds invert
 //----------------------------------------------------------
 // initial blocks are sequential and start at time 0
 initial
 begin
 $dumpfile("fpu_tb.vcd");
 $dumpvars(0,clock, a, b, op, out);
 clock = 0;op = 2'b00;
a = 32'b11110100010100110001010111111001;
b = 32'b00100001101010000111001101011010;
correct = 32'b11110100010100110001010111111001;
#400 //-6.689577e+31 * 1.1414656e-18 = -6.689577e+31
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b11100101011101101001110011010001;
b = 32'b10110110011100111001011010110000;
correct = 32'b11100101011101101001110011010001;
#400 //-7.278718e+22 * -3.6297533e-06 = -7.278718e+22
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b00000100000000011110011011011001;
b = 32'b00111101001111100011111111001111;
correct = 32'b00111101001111100011111111001111;
#400 //1.5269877e-36 * 0.04644757 = 0.04644757
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b01001000100000011101100101111001;
b = 32'b00001101010110100011011010010110;
correct = 32'b01001000100000011101100101111001;
#400 //265931.78 * 6.724214e-31 = 265931.78
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b10000111011010100010100010000010;
b = 32'b01000101111111011001111010010001;
correct = 32'b01000101111111011001111010010001;
#400 //-1.7616108e-34 * 8115.821 = 8115.821
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
$display ("Done.");
 // stop the simulation
 end

endmodule