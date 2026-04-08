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
		
		// Check stop bit
		if (f.stop_bit !== 1) begin
		  $display("  FAIL: stop bit = %b (expected 1)", f.stop_bit);
		  return 0;
		end
		
		// Check parity
		if (ptype == PARITY_EVEN) begin
		  if (f.parity !== calc_even_parity(f.data)) begin
			$display("  FAIL: even parity incorrect");
			return 0;
		  end
		end else if (ptype == PARITY_ODD) begin
		  if (f.parity !== ~calc_even_parity(f.data)) begin
			$display("  FAIL: odd parity incorrect");
			return 0;
		  end
		end
		// PARITY_NONE: skip check
    return 1;
  endfunction
  
	function void display_frame(uart_struct_t f);
    $display("  Start=%b Data=%h Parity=%b Stop=%b (raw=%b)", 
              f.start_bit, f.data, f.parity, f.stop_bit, f);
  endfunction
  
  initial begin 
	uart_struct_t good_frame,bad_frame;
	
	// Valid frame 
	good_frame.start_bit = 1'b0;
	good_frame.data = 8'hAB;
	good_frame.parity = calc_parity(good_frame.data);
	good_frame.stop_bit = 1'b1;
	
	// Display Good Frame 
	$display("Good Frame:");
	display_frame(good_frame);
	$display("  Valid: %s\n", validate(good_frame, PARITY_EVEN) ? "PASS" : "FAIL");
    
    // Invalid frame: wrong parity
    bad_frame.start_bit = 0;
    bad_frame.data = 8'hA5;
    bad_frame.parity = 1;   // Wrong! Even parity of A5 should be 0
    bad_frame.stop_bit = 1;
    
    $display("Bad frame:");
    display_frame(bad_frame);
    $display("  Valid: %s\n", validate(bad_frame, EVEN) ? "PASS" : "FAIL");
    
    // Invalid frame: wrong stop bit
    bad_frame.stop_bit = 0;
    $display("Bad stop bit:");
    display_frame(bad_frame);
    $display("  Valid: %s", validate(bad_frame, EVEN) ? "PASS" : "FAIL");
  end
		
		
	
endmodule