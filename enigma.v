
module wheel(char_out1, char_out2, char_in1, char_in2, position_in);
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

module enigma(char_out, char_in, /* wheel and reflector settings */);
	output[4:0] char_out;
	input[4:0] char_in;
	wire [4:0] positions [2:0];
	//all rotors start in position 0
	assign positions[0] = 0;
	assign positions[1] = 0;
	assign positions[2] = 0;

	wire[4:0] out_wheel_I, reflector_out;
	wheel wheel_I(out_wheel_I, char_out, char_in, reflector_out, positions[0]);
	reflector reflect(reflector_out, out_wheel_I);
	
	


	


endmodule //enigma
