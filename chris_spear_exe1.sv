// 3Q
bit [11:0] my_array[4];

my_array = '{12'h012, 12'h345, 12'h678, 12'h9AB};

// for loop
for (int i = 0; i < 4; i++) begin
    $display("bits [5:4] of my_array[%0d] = %0b", i, my_array[i][5:4]);
end

// foreach loop
foreach (my_array[i]) begin
    $display("bits [5:4] of my_array[%0d] = %0b", i, my_array[i][5:4]);
end

//4Q
bit [4:0][30:0] my_array2;

// 7Q
 // bit [23:0] memory [ logic[19:0]]; // o// the word size is 24 bits . for 2^20 address we need $clog2(2^20) = 20 bits 
module test;

  // Step 1: Declare associative array
  bit [23:0] memory [bit [19:0]];

  initial begin

    // Step 2: Fill memory
    memory[20'h00000] = 24'hA50400; // PC start at address 0
    memory[20'h00400] = 24'h123456; // Instruction 1
    memory[20'h00401] = 24'h789ABC; // Instruction 2
    memory[20'hFFFFF] = 24'h0F1E2D; // ISR at max address

    // Step 3: Print elements
    foreach (memory[addr])
      $display("memory[%h] = %h", addr, memory[addr]);

    // Print number of elements
    $display("Number of elements = %0d", memory.num());

  end

endmodule
		
// 8Q
module test;
  byte queue[$] = '{2, -1, 127};

  initial begin
    // b. sum
    $display("sum = %0d", queue.sum());

    // c. min and max
    $display("min = %0d", queue.min()[0]);
    $display("max = %0d", queue.max()[0]);

    // d. sort
    queue.sort();
    $display("sorted queue = %p", queue);

    // e. index of negative values
    foreach(queue[i]) begin
      if(queue[i] < 0)
        $display("negative value %0d at index %0d", queue[i], i);
    end

    // f. positive values
    byte pos_vals[$] = queue.find(x) with (x > 0);
    $display("positive values = %p", pos_vals);

    // g. reverse sort
    queue.rsort();
    $display("reverse sorted queue = %p", queue);
  end

endmodule

// 9Q
// define a user definrd 7 bit type and encapsulate the fields of the following 
// packet in the structure using your new type. Lastly, assign the header to 7'h5A 
typedef bit [6:0] sev7_bits_t;
typedef struct packet {
	sev7_bits_t crc ;
	sev7_bits_t data;
	sev7_bits_t cmd;
	sev7_bits_t header;
	} packet_t;	
	
	initial begin 
		packet_t t;
		t.header = 7'h5A;
	end 
	
// 10Q 
//a. Create a userdefined type, nibble of 4 bits 
module test;
    typedef bit [3:0] nibble_t;

    real r = 4.33;
    shortint i_pack;
    nibble_t k[4] = '{4'h0, 4'hF, 4'hE, 4'hD};

    initial begin
        // e. print k
        foreach(k[i])
            $display("k[%0d] = %h", i, k[i]);

        // f. stream bit-wise right to left
        i_pack = {<< {k}};
        $display("i_pack = %h", i_pack);

        // g. stream nibble-wise right to left
        i_pack = {<< 4 {k}};
        $display("i_pack = %h", i_pack);

        // h. type cast
        k[0] = nibble_t'(r);  // 4.33 → 4
        $display("k = %p", k);
    end
endmodule

//11Q
//a. create an enumarated type of the opcode : opcode_e
module testbench;

    // a. enum type
    typedef enum bit [1:0] {
        ADD             = 2'b00,
        SUB             = 2'b01,
        BIT_WISE_INVERT = 2'b10,
        RED_OR          = 2'b11
    } opcode_e;

    // b. variable of type opcode_e
    opcode_e opcode;

    // d. instantiate ALU
    alu dut(.opcode(opcode));

    initial begin
        // c. loop through all opcodes every 10ns
        for (opcode = opcode.first(); ; opcode = opcode.next()) begin
            #10;
            $display("opcode = %s encoding = %b", opcode.name(), opcode);
            if (opcode == opcode.last()) break;
        end
    end

endmodule



// ========= DONE ======================