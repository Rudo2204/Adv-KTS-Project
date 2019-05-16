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
a = 32'b01110001111000111010000101011001;
b = 32'b11110010010011001010101111101111;
correct = 32'b11110001101101011011011010000101;
#400 //2.254341e+30 ADD -4.053939e+30 = -1.799598e+30
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b11000010001101000010111001000001;
b = 32'b00101110001111001000111101011100;
correct = 32'b11000010001101000010111001000001;
#400 //-45.04517 ADD 4.287358e-11 = -45.04517
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b00110110011100110010100111101100;
b = 32'b01010001101010111010000101111110;
correct = 32'b01010001101010111010000101111110;
#400 //3.6234223e-06 ADD 92143600000.0 = 92143600000.0
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b00010111110010111110101100010001;
b = 32'b00111000010010111101000111010111;
correct = 32'b00111000010010111101000111010111;
#400 //1.3177907e-24 ADD 4.85944e-05 = 4.85944e-05
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
a = 32'b10110111011111010001101100111110;
b = 32'b01000101110111101100101001001110;
correct = 32'b01000101110111101100101001001110;
#400 //-1.5086318e-05 ADD 7129.288 = 7129.288
if ((correct - out > 2) && (out - correct > 2)) begin
$display ("A      : %b %b %b %h", a[31], a[30:23], a[22:0], a);
$display ("B      : %b %b %b %h", b[31], b[30:23], b[22:0], b);
$display ("Output : %b %b %b %h", out[31], out[30:23], out[22:0], out);
$display ("Correct: %b %b %b %h",correct[31], correct[30:23], correct[22:0], correct); $display();end
$display ("Done.");
$stop;
 // stop the simulation
 end

endmodule