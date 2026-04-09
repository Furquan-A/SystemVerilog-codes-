typedef struct {
  int          id;
  logic [31:0] data;
  logic [7:0]  addr;
  string       source;
} transaction_t;

module scoreboard_queue;
  transaction_t expected_q[$];
  
  function void add_expected(transaction_t t);
    expected_q.push_back(t);
    $display("Added expected: id=%0d addr=%h data=%h", t.id, t.addr, t.data);
  endfunction
  
  function bit check_actual(transaction_t actual);
    transaction_t exp;

    if (expected_q.size() == 0) begin
      $display("ERROR: Unexpected transaction received! id=%0d", actual.id);
      return 0;
    end
    
    exp = expected_q.pop_front();
    
    if (exp.data !== actual.data || exp.addr !== actual.addr) begin
      $display("MISMATCH: id=%0d", actual.id);
      $display("  Expected: addr=%h data=%h", exp.addr, exp.data);
      $display("  Actual:   addr=%h data=%h", actual.addr, actual.data);
      return 0;
    end
    
    $display("MATCH: id=%0d addr=%h data=%h", actual.id, actual.addr, actual.data);
    return 1;
  endfunction
  
  function void final_check();
    if (expected_q.size() > 0) begin
      $display("ERROR: %0d expected transactions never received:", expected_q.size());
      foreach (expected_q[i])
        $display("  id=%0d addr=%h data=%h", expected_q[i].id, expected_q[i].addr, expected_q[i].data);
    end
    else
      $display("ALL TRANSACTIONS MATCHED");
  endfunction
  
  initial begin
    transaction_t t;
    
    t = '{0, 32'hAAAA, 8'h10, "driver"};  add_expected(t);
    t = '{1, 32'hBBBB, 8'h20, "driver"};  add_expected(t);
    t = '{2, 32'hCCCC, 8'h30, "driver"};  add_expected(t);
    
    $display("\n--- Checking ---");
    t = '{0, 32'hAAAA, 8'h10, "monitor"};  void'(check_actual(t));
    t = '{1, 32'hBBBB, 8'h20, "monitor"};  void'(check_actual(t));
    t = '{2, 32'hDDDD, 8'h30, "monitor"};  void'(check_actual(t));
    
    $display("\n--- Final ---");
    final_check();
  end
endmodule