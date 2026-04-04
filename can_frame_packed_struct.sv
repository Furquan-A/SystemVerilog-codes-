module register_file;
  parameter int NUM_REGS = 8;
  parameter int REG_WIDTH = 32;
  localparam int ADDR_W = $clog2(NUM_REGS);
  
  logic [REG_WIDTH-1:0] regs [NUM_REGS];  // Unpacked array of packed registers
  
  function void write_reg(logic [ADDR_W-1:0] addr, logic [REG_WIDTH-1:0] data);
    if (addr < NUM_REGS) begin
      regs[addr] = data;
      $display("WRITE: reg[%0d] = 0x%h", addr, data);
    end else
      $display("ERROR: Address %0d out of bounds (max %0d)", addr, NUM_REGS-1);
  endfunction
  
  function logic [REG_WIDTH-1:0] read_reg(logic [ADDR_W-1:0] addr);
    if (addr < NUM_REGS) begin
      $display("READ:  reg[%0d] = 0x%h", addr, regs[addr]);
      return regs[addr];
    end else begin
      $display("ERROR: Address %0d out of bounds", addr);
      return 'x;  // Return X for invalid read
    end
  endfunction
  
  function void display_all();
    $display("\n=== Register File Contents ===");
    $display("Config: %0d regs x %0d bits, addr width = %0d", 
              NUM_REGS, REG_WIDTH, ADDR_W);
    for (int i = 0; i < NUM_REGS; i++)
      $display("  reg[%0d] = 0x%h", i, regs[i]);
    $display("==============================\n");
  endfunction
  
  initial begin
    logic [REG_WIDTH-1:0] readback;
    
    // Initialize all regs to 0
    foreach (regs[i]) regs[i] = '0;
    
    display_all();
    
    // Write pattern
    write_reg(0, 32'hDEADBEEF);
    write_reg(3, 32'hCAFEBABE);
    write_reg(7, 32'h12345678);
    
    // Read back and verify
    readback = read_reg(0);
    $display("Verify reg[0]: %s", (readback === 32'hDEADBEEF) ? "PASS" : "FAIL");
    
    readback = read_reg(3);
    $display("Verify reg[3]: %s", (readback === 32'hCAFEBABE) ? "PASS" : "FAIL");
    
    // Read unwritten register (should be 0)
    readback = read_reg(5);
    $display("Verify reg[5] unwritten: %s", (readback === '0) ? "PASS" : "FAIL");
    
    display_all();
    
    // Overwrite and verify
    write_reg(0, 32'hAAAABBBB);
    readback = read_reg(0);
    $display("Verify overwrite: %s", (readback === 32'hAAAABBBB) ? "PASS" : "FAIL");
  end
endmodule