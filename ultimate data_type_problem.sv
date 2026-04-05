module packet_system;
  
  typedef enum bit [2:0] {
    NOP=0, READ=1, WRITE=2, BURST_READ=3, BURST_WRITE=4
  } opcode_t;
  
  typedef struct packed {
    opcode_t       opcode;     // 3 bits
    logic          prioritys;   // 1 bit
    logic [11:0]   addr;       // 12 bits
    logic [15:0]   data;       // 16 bits
  } packet_t;                  // Total: 32 bits
  
  // Function: serialize packet to byte array
  function automatic void serialize(input packet_t pkt, output byte unsigned bytes[]);
    int num_bytes = $bits(pkt) / 8;
	logic [$bits(pkt)-1:0] flat = pkt; // this is called flattening the struct
    bytes = new[num_bytes];
    // YOUR CODE: fill bytes[] from pkt, MSB byte first
	for (int i =0 ; i < num_bytes; i++) begin 
		bytes[i] = flat[(num_bytes-1-i)*8 +: 8]; // MSB first 
	end
  endfunction
  
  // Function: deserialize byte array back to packet
  function automatic packet_t deserialize(input byte unsigned bytes[]);
    packet_t pkt;
    // YOUR CODE: reconstruct pkt from bytes[]
	logic [$bits(packet_t)-1:0] flat = '0;
    int num_bytes = bytes.size();
    for (int i = 0; i < num_bytes; i++)
      flat[(num_bytes-1-i)*8 +: 8] = bytes[i];
    pkt = packet_t'(flat);
    return pkt;
  endfunction
  
  // Function: display packet
  function void display_pkt(string label, packet_t p);
    // YOUR CODE
  endfunction
  
  initial begin
    packet_t original, restored;
    byte unsigned stream[];
    
    original.opcode   = WRITE;
    original.priority = 1;
    original.addr     = 12'hABC;
    original.data     = 16'h1234;
    
    display_pkt("Original", original);
    
    serialize(original, stream);
    $display("Serialized %0d bytes:", stream.size());
    foreach (stream[i])
      $display("  byte[%0d] = 0x%h", i, stream[i]);
    
    restored = deserialize(stream);
    display_pkt("Restored", restored);
    
    // Verify round-trip
    if (original === restored)
      $display("ROUND-TRIP: PASS");
    else
      $display("ROUND-TRIP: FAIL");
  end
endmodule