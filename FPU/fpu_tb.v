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
 clock = 0;op = 2'b10;
a = 32'b11001010101011001111000011011111;
b = 32'b01101010011110111001010111100001;
correct = 32'b10011111101011111111100110111001;
#400 //-5666927.5 DIV 7.603704e+25 = -7.4528514e-20
if (correct[31:12] != out[31:12]) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b00010010000000000010101100101000;
b = 32'b00010001100000111110000010010100;
correct = 32'b00111111111110001100110011111100;
#400 //4.0442873e-28 DIV 2.0806563e-28 = 1.9437556
if (correct[31:12] != out[31:12]) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b01101110111001001011100101001100;
b = 32'b01000110101110100010010100010000;
correct = 32'b01100111100111010100011101100111;
#400 //3.5393296e+28 DIV 23826.531 = 1.4854574e+24
if (correct[31:12] != out[31:12]) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b01000000001000001011001010011101;
b = 32'b11101100011001111010001101101110;
correct = 32'b10010011001100011001100100110010;
#400 //2.5109017 DIV -1.12013456e+27 = -2.2416072e-27
if (correct[31:12] != out[31:12]) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b11110000101001001011001010000011;
b = 32'b11011101100000100110110111010011;
correct = 32'b01010010101000011010000101010000;
#400 //-4.077708e+29 DIV -1.1748e+18 = 347098050000.0
if (correct[31:12] != out[31:12]) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
$display ("Done.");
$stop;
 // stop the simulation
 end

endmodule