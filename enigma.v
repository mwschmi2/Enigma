
module enigma(char_out, char_in, position_1, position_2, position_3);
	output[4:0] char_out;
	input[4:0] char_in, position_1, position_2, position_3;
	reg [4:0] positions [2:0];
	//set rotor position starts
	initial positions[0] = position_1;
	initial positions[1] = position_2;
	initial positions[2] = position_3;

	wire[4:0] out_wheel_I, out_wheel_II, out_wheel_III, out_wheel_III_2, out_wheel_II_2, reflector_out;

	wheel_type_I wheel_I(out_wheel_I, char_out, char_in, out_wheel_II_2, positions[0]);
	wheel_type_II wheel_II(out_wheel_II, out_wheel_II_2, out_wheel_I,out_wheel_III_2, positions[1]);
	wheel_type_III wheel_III(out_wheel_III, out_wheel_III_2, out_wheel_II, reflector_out, positions[2]);
	reflector reflect(reflector_out, out_wheel_III);
	
	always @(posedge char_in) begin
		if(char_in != 5'b11111) 
			begin
				positions[0] = (positions[0] + 1) % 26;	
				if(positions[0]	== 5'b01001) positions[1] = (positions[1] + 1) % 26;
				if(positions[1] == 5'b00110) positions[2] = (positions[2] + 1) % 26;
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

	wire [4:0] reverse [25:0];
	assign reverse[0] = 20; 
	assign reverse[1] = 22; 
	assign reverse[2] = 24;
	assign reverse[3] = 6;
	assign reverse[4] = 0;
	assign reverse[5] = 3;
	assign reverse[6] = 5;
	assign reverse[7] = 15;
	assign reverse[8] = 21;
	assign reverse[9] = 25;
	assign reverse[10] = 1;
	assign reverse[11] = 4;
	assign reverse[12] = 2;
	assign reverse[13] = 10;
	assign reverse[14] = 12;
	assign reverse[15] = 19;
	assign reverse[16] = 7;
	assign reverse[17] = 23;
	assign reverse[18] = 18;
	assign reverse[19] = 11;
	assign reverse[20] = 17;
	assign reverse[21] = 8;
	assign reverse[22] = 13;
	assign reverse[23] = 16;
	assign reverse[24] = 14;
	assign reverse[25] = 9;


	assign char_out1 = out[(char_in1 + position_in) % 26 ];
	assign char_out2 = reverse[(char_in1 - position_in) % 26];


endmodule //wheel
module wheel_type_II(char_out1, char_out2, char_in1, char_in2, position_in);
	output[4:0] char_out1, char_out2;
	input[4:0] char_in1, char_in2, position_in;
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
	
	wire [4:0] reverse [25:0];
	/*a*/ assign reverse[0] = 0;
	/*b*/ assign reverse[1] = 9;  
	/*c*/ assign reverse[2] = 15;
	/*d*/ assign reverse[3] = 2; 
	/*e*/ assign reverse[4] = 25; 
	/*f*/ assign reverse[5] = 22;
	/*g*/ assign reverse[6] = 17;
	/*h*/ assign reverse[7] = 11;
	/*i*/ assign reverse[8] = 5;
	/*j*/ assign reverse[9] = 1;
	/*k*/ assign reverse[10] = 3;
	/*l*/ assign reverse[11] = 10; 
	/*m*/ assign reverse[12] = 14;
	/*n*/ assign reverse[13] = 19;
	/*o*/ assign reverse[14] = 24;
	/*p*/ assign reverse[15] = 20;
	/*q*/ assign reverse[16] = 16;
	/*r*/ assign reverse[17] = 6;
	/*s*/ assign reverse[18] = 4;
	/*t*/ assign reverse[19] = 13;
	/*u*/ assign reverse[20] = 7;
	/*v*/ assign reverse[21] = 23;
	/*w*/ assign reverse[22] = 12;
	/*x*/ assign reverse[23] = 8;
	/*y*/ assign reverse[24] = 21;
	/*z*/ assign reverse[25] = 18;


	assign char_out1 = out[(char_in1 + position_in) % 26 ];
	assign char_out2 = reverse[(char_in1 - position_in) % 26];


endmodule
module wheel_type_III(char_out1, char_out2, char_in1, char_in2, position_in);
	output[4:0] char_out1, char_out2;
	input[4:0] char_in1, char_in2, position_in;
/*
	Entry = ABCDEFGHIJKLMNOPQRSTUVWXYZ (rotor right side)   
	        ||||||||||||||||||||||||||
	III   = B D F H J L C P R T X V Z N Y E I W G A K M U S Q O
	1
	3
	5
	7
	9
	11
	2
	15
	17
	19
	23
	21
	25
	13
	24
	4
	8
	22
	6
	0
	10
	12
	20
	18
	16
	14
*/
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

	wire [4:0] reverse [25:0];
	/*a*/ assign reverse[1] = 0;
	/*b*/ assign reverse[3] = 1;
	/*c*/ assign reverse[5] = 2;
	/*d*/ assign reverse[7] = 3;
	/*e*/ assign reverse[9] = 4;
	/*f*/ assign reverse[11] = 5;
	/*g*/ assign reverse[2] = 6;
	/*h*/ assign reverse[15] = 7;
	/*i*/ assign reverse[17] = 8;
	/*j*/ assign reverse[19] = 9;
	/*k*/ assign reverse[23] = 10;
	/*l*/ assign reverse[21] = 11;
	/*m*/ assign reverse[25] = 12;
	/*n*/ assign reverse[13] = 13;
	/*o*/ assign reverse[24] = 14;
	/*p*/ assign reverse[4] = 15;
	/*q*/ assign reverse[8] = 16;
	/*r*/ assign reverse[22] = 17;
	/*s*/ assign reverse[6] = 18;
	/*t*/ assign reverse[0] = 19;
	/*u*/ assign reverse[10] = 20;
	/*v*/ assign reverse[12] = 21;
	/*w*/ assign reverse[20] = 22;
	/*x*/ assign reverse[18] = 23;
	/*y*/ assign reverse[16] = 24;
	/*z*/ assign reverse[14] = 25;

	assign char_out1 = out[(char_in1 + position_in) % 26 ];
	assign char_out2 = reverse[(char_in1 - position_in) % 26];


endmodule
