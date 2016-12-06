
module enigma(char_out, char_in, position_1, position_2, position_3);
	output[4:0] char_out;
	input[4:0] char_in, position_1, position_2, position_3;
	reg [4:0] position_I, position_II, position_III;
	//set rotor position starts
	initial position_I = position_1;
	initial position_II = position_2;
	initial position_III = position_3;

	wire[4:0] out_wheel_I, out_wheel_II, out_wheel_III, out_wheel_III_2, out_wheel_II_2, reflector_out;

	wheel_type_I wheel_I(out_wheel_I, char_out, char_in, out_wheel_II_2, position_I);

	wheel_type_II wheel_II(out_wheel_II, out_wheel_II_2, out_wheel_I,out_wheel_III_2, position_II);
	wheel_type_III wheel_III(out_wheel_III, out_wheel_III_2, out_wheel_II, reflector_out, position_III);
	reflector reflect(reflector_out, out_wheel_III);
	/*
	wire[4:0] out_wheel_I, reflector_out;
	wheel_type_I wheel_I(out_wheel_I, char_out, char_in, reflector_out, position_I);
	reflector reflect(reflector_out, out_wheel_I);
	*/
	
	always @(char_in) begin
		if(char_in != 5'b11111) 
			begin
				position_I = (position_I + 1) % 26;	
				if(position_I	== 5'b10001) position_II = (position_II + 1) % 26;
				if(position_II == 5'b00110) position_III = (position_III + 1) % 26;
			end	
		
	end
		
	
endmodule //enigma


module reflector(char_out, char_in);
	output[4:0] char_out;
	input[4:0] char_in;

	//default wide reflector B used by Wehrmacht
	wire [4:0] out [25:0];
	//generated code
	/*
Contacts    = ABCDEFGHIJKLMNOPQRSTUVWXYZ                
              ||||||||||||||||||||||||||
Reflector B = YRUHQSLDPXNGOKMIEBFZCWVJAT
*/
	assign out[0] = 24;
	assign out[1] = 17;
	assign out[2] = 20;
	assign out[3] = 7;
	assign out[4] =	16; 
	assign out[5] = 18;
	assign out[6] = 11;
	assign out[7] = 3;
	assign out[8] = 15;
	assign out[9] = 23;
	assign out[10] = 13;
	assign out[11] = 6;
	assign out[12] = 14;
	assign out[13] = 10;
	assign out[14] = 12;
	assign out[15] = 8;
	assign out[16] = 4;
	assign out[17] = 1;
	assign out[18] = 5;
	assign out[19] = 25;
	assign out[20] = 2;
	assign out[21] = 22;
	assign out[22] = 21;
	assign out[23] = 9;
	assign out[24] = 0;
	assign out[25] = 19;

	
	assign char_out = out[char_in];

endmodule //reflector
module wheel_type_I(char_out1, char_out2, char_in1, char_in2, position_in);
	output[4:0] char_out1, char_out2;
	input[4:0] char_in1, char_in2, position_in;
	integer i;

	
	//wehrmacht rotor I
/*Entry = ABCDEFGHIJKLMNOPQRSTUVWXYZ (rotor right side)   
 	      ||||||||||||||||||||||||||
  I     = EKMFLGDQVZNTOWYHXUSPAIBRCJ
	*/

	wire [4:0] out [25:0];
	assign out[0] = 4;  
	assign out[1] = 10;
	assign out[2] = 12;
	assign out[3] = 5;
	assign out[4] = 11;
	assign out[5] = 6;
	assign out[6] = 3;
	assign out[7] = 16;
	assign out[8] = 21;
	assign out[9] = 25;
	assign out[10] = 13;
	assign out[11] = 19;
	assign out[12] = 14;
	assign out[13] = 22;
	assign out[14] = 24;
	assign out[15] = 7;
	assign out[16] = 23;
	assign out[17] = 20;
	assign out[18] = 18;
	assign out[19] = 15;
	assign out[20] = 0;
	assign out[21] = 8;
	assign out[22] = 1;
	assign out[23] = 17;
	assign out[24] = 2;
	assign out[25] = 9;

	function [4:0] reverse;
		input [4:0] char;
		for(i = 0; i <= 25; i = i + 1) begin
			if(out[i] == char) begin
				reverse = (i + position_in) % 26;
			end
		end
	endfunction
	wire signed [5:0] offset = (char_in1 - position_in);
	wire [4:0] position = offset[5] ? 26 + offset : offset;
	assign char_out1 = out[position];
	assign char_out2 = reverse(char_in2);


endmodule //wheel
module wheel_type_II(char_out1, char_out2, char_in1, char_in2, position_in);
	output[4:0] char_out1, char_out2;
	input[4:0] char_in1, char_in2, position_in;
	integer i;
/*
	Entry = A B C D E F G H I J K L M N O P Q R S T U V W X Y Z   
	        | | | | | | | | | | | | | | | | | | | | | | | | | |
	II    = A J D K S I R U X B L H W T M C Q G Z N P Y F V O E
*/
	wire [4:0] out [25:0];
	/*a*/ assign out[0] = 0;
	/*b*/ assign out[1] = 9;
	/*c*/ assign out[2] = 3;
	/*d*/ assign out[3] = 10; 
	/*e*/ assign out[4] = 18; 
	/*f*/ assign out[5] = 8;
	/*g*/ assign out[6] = 17;
	/*h*/ assign out[7] = 20;
	/*i*/ assign out[8] = 23;
	/*j*/ assign out[9] = 1;
	/*k*/ assign out[10] = 11;
	/*l*/ assign out[11] = 7;
	/*m*/ assign out[12] = 22;
	/*n*/ assign out[13] = 19;
	/*o*/ assign out[14] = 12;
	/*p*/ assign out[15] = 2;
	/*q*/ assign out[16] = 16;
	/*r*/ assign out[17] = 6;
	/*s*/ assign out[18] = 25;
	/*t*/ assign out[19] = 13;
	/*u*/ assign out[20] = 15;
	/*v*/ assign out[21] = 24;
	/*w*/ assign out[22] = 5;
	/*x*/ assign out[23] = 21;
	/*y*/ assign out[24] = 14;
	/*z*/ assign out[25] = 4;
	/*
	II    = A J D K S I R U X B L H W T M C Q G Z N P Y F V O E
	        | | | | | | | | | | | | | | | | | | | | | | | | | |
	Entry = A B C D E F G H I J K L M N O P Q R S T U V W X Y Z   
	*/
	
	function [4:0] reverse;
		input [4:0] char;
		for(i = 0; i <= 25; i = i + 1) begin
			if(out[i] == char) begin
				reverse = (i + position_in) % 26;
			end
		end
	endfunction
	wire signed [5:0] offset = (char_in1 - position_in);
	wire [4:0] position = offset[5] ? 26 + offset : offset;
	assign char_out1 = out[position];
	assign char_out2 = reverse(char_in2);


endmodule
module wheel_type_III(char_out1, char_out2, char_in1, char_in2, position_in);
	output[4:0] char_out1, char_out2;
	input[4:0] char_in1, char_in2, position_in;
/*
	Entry = ABCDEFGHIJKLMNOPQRSTUVWXYZ (rotor right side)   
	        ||||||||||||||||||||||||||
	III   = B D F H J L C P R T X V Z N Y E I W G A K M U S Q O
	*/
	integer i;
	wire [4:0] out [25:0];
	/*a*/ assign out[0] = 1;
	/*b*/ assign out[1] = 3;
	/*c*/ assign out[2] = 5;
	/*d*/ assign out[3] = 7;
	/*e*/ assign out[4] = 9;
	/*f*/ assign out[5] = 11;
	/*g*/ assign out[6] = 2;
	/*h*/ assign out[7] = 15;
	/*i*/ assign out[8] = 17;
	/*j*/ assign out[9] = 19;
	/*k*/ assign out[10] = 23;
	/*l*/ assign out[11] = 21;
	/*m*/ assign out[12] = 25;
	/*n*/ assign out[13] = 13;
	/*o*/ assign out[14] = 24;
	/*p*/ assign out[15] = 4;
	/*q*/ assign out[16] = 8;
	/*r*/ assign out[17] = 22;
	/*s*/ assign out[18] = 6;
	/*t*/ assign out[19] = 0;
	/*u*/ assign out[20] = 10;
	/*v*/ assign out[21] = 12;
	/*w*/ assign out[22] = 20;
	/*x*/ assign out[23] = 18;
	/*y*/ assign out[24] = 16;
	/*z*/ assign out[25] = 14;


	function [4:0] reverse;
		input [4:0] char;
		for(i = 0; i <= 25; i = i + 1) begin
			if(out[i] == char) begin
				reverse = (i + position_in) % 26;
			end
		end
	endfunction
	wire signed [5:0] offset = (char_in1 - position_in);
	wire [4:0] position = offset[5] ? 26 + offset : offset;
	assign char_out1 = out[position];
	assign char_out2 = reverse(char_in2);

endmodule
