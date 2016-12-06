module enigma_test;

	reg restart = 1;
	reg [4:0] bits = 5'b11111;
	reg clk = 0;
	always #5 clk = !clk;

    initial begin
 
        $dumpfile("enigma.vcd");  
        $dumpvars(0, enigma_test);
// H
		#10 //simulate lifting finger off the key
		bits = 5'b11111;
		#10
		bits = 5'd8;
// E
		#10
		bits = 5'b11111;
		#10
		bits = 5'd23;
// L
		#10
		bits = 5'b11111;
		#10
		bits = 5'd2;
// L
		#10
		bits = 5'b11111;
		#10
		bits = 5'd10;
// O
		#10
		bits = 5'b11111;
		#10
		bits = 5'd22;

       
    end                      

	wire [4:0] out;
	enigma e(out, bits, 5'b0, 5'd2, 5'b0);

	initial 
		$monitor("At time %t, input = %d, output = %d", $time, bits, out);	
endmodule
