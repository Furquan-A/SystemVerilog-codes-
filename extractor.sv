module your_extractor;
  initial begin
    // CAN frame packed into a 48-bit vector:
    //   bits [47:45] = frame_type  (3 bits)
    //   bit  [44]    = ide         (1 bit)
    //   bits [43:40] = dlc         (4 bits)
    //   bits [39:32] = data_byte1  (8 bits)
    //   bits [31:24] = data_byte0  (8 bits)
    //   bits [23:13] = id_standard (11 bits)
    //   bits [12:0]  = reserved    (13 bits)
    
    logic [47:0] raw = 48'hA3_FF_DE_7F_F0;
    
    // YOUR TASK: Extract each field and display it
    // Use +: operator
    // YOUR CODE HERE
	logic [2:0] frame_type = raw[45 +: 3];
	logic ide = raw[44];
	logic [3:0] dlc  =  raw[40 +: 4];
	logic [7:0] data_byte1 = raw[32 +: 8];
	logic [7:0] data_byte0 = raw[24 +: 8];
	logic [10:0] id_standard = raw[13 +: 11];
	logic [12:0] reserved  =  raw[0 +: 13];
	
	$display("frame_type = %b",frame_type);
	
  end
endmodule