module packet_memory;
  
  typedef enum bit [1:0] { CMD_READ=0, CMD_WRITE=1, CMD_CLEAR=2, CMD_NOP=3 } cmd_t;
  
  typedef struct packed {
    cmd_t         cmd;        // 2 bits
    logic [5:0]   addr;       // 6 bits
    logic [7:0]   data;       // 8 bits
  } pkt_t;                    // 16 bits
  
  // Storage
  logic [7:0] memory [64];    // 64 locations of 8 bits each
  
  // Transaction log
  pkt_t log_q [$];            // Queue of all transactions
  
  function void execute(pkt_t p);
    case (p.cmd)
      CMD_WRITE: begin
        memory[p.addr] = p.data;
        $display("  WRITE: mem[%0d] = 0x%h", p.addr, p.data);
      end
      CMD_READ: begin
        $display("  READ:  mem[%0d] = 0x%h", p.addr, memory[p.addr]);
      end
      CMD_CLEAR: begin
        memory[p.addr] = '0;
        $display("  CLEAR: mem[%0d] = 0x00", p.addr);
      end
      CMD_NOP: begin
        $display("  NOP");
      end
    endcase
    log_q.push_back(p);
  endfunction
  
  function void print_stats();
	int addr[$];
    int writes[$] = log_q.find(p) with (p.cmd == CMD_WRITE);
    int reads[$]  = log_q.find(p) with (p.cmd == CMD_READ);
    int clears[$] = log_q.find(p) with (p.cmd == CMD_CLEAR);
    int nops[$]   = log_q.find(p) with (p.cmd == CMD_NOP);
    
    $display("\n=== Transaction Stats ===");
    $display("  Total:  %0d", log_q.size());
    $display("  Writes: %0d", writes.size());
    $display("  Reads:  %0d", reads.size());
    $display("  Clears: %0d", clears.size());
    $display("  NOPs:   %0d", nops.size());
    
    // Find unique addresses accessed
    // YOUR TASK: Use array methods to find how many unique addresses were accessed
    // YOUR CODE HERE
	foreach(log_q[i])
		addrs[i].push_back(log_q[i].addr);
	int unique_addr[$] = addrs.unique();
	$display("  Unique addresses: %0d", uq_addrs.size());
		
  endfunction
  
  initial begin
    pkt_t p;
    
    // Initialize memory to 0
    foreach (memory[i]) memory[i] = '0;
    
    // Execute some transactions
    p = '{CMD_WRITE, 6'd10, 8'hAA}; execute(p);
    p = '{CMD_WRITE, 6'd20, 8'hBB}; execute(p);
    p = '{CMD_WRITE, 6'd10, 8'hCC}; execute(p);   // Overwrite addr 10
    p = '{CMD_READ,  6'd10, 8'h00}; execute(p);    // Read addr 10
    p = '{CMD_READ,  6'd20, 8'h00}; execute(p);    // Read addr 20
    p = '{CMD_NOP,   6'd0,  8'h00}; execute(p);
    p = '{CMD_CLEAR, 6'd10, 8'h00}; execute(p);    // Clear addr 10
    p = '{CMD_READ,  6'd10, 8'h00}; execute(p);    // Read cleared addr
    
    print_stats();
  end
endmodule