module your_struct;
  // YOUR TASK: Build a UART frame struct
  //
  // A UART frame has:
  //   start_bit  : 1 bit (always 0)
  //   data       : 8 bits
  //   parity     : 1 bit
  //   stop_bit   : 1 bit (always 1)
  //
  // Also create an enum for parity type: EVEN, ODD, NONE
  //
  // Write:
  //   1. The enum typedef
  //   2. The packed struct typedef
  //   3. A function that calculates correct parity (XOR of all data bits)
  //   4. A function that validates the frame (start=0, stop=1, parity correct)
  //   5. Test with a valid and invalid frame
  
  // YOUR CODE HERE
  typedef enum logic [1:0] {
	EVEN = 2'b00,
	ODD = 2'b01,
	NONE = 2'b10
	} parity_type_t;
	
	typedef struct packed {
		bit start_bit; // always 0
		logic [7:0] data;
		bit parity;
		bit stop_bit;
	} uart_struct_t;
	
	function bit calc_parity(logic [7:0] data);
		return ^data;
	endfunction 
	
	function void validate(uart_struct_t st, parity_type_t ptype);
		if(st.start_bit !== 0) begin
			$display("  FAIL: start bit = %b (expected 0)", f.start_bit);
			return 0;
		end
		
		
		
	
endmodule