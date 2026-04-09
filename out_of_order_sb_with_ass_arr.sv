// This is exactly what a UVM scoreboard does internally. the key Insight is :
// Associative array keys by ID lets you look up expected data regardless of arrival order. 

typedef struct {
  int          id;
  logic [31:0] data;
  logic [7:0]  addr;
} transaction_t;

module oo_scoreboard;
  // Key = transaction ID, Value = expected transaction
  transaction_t expected_aa [int];
  int match_count = 0;
  int mismatch_count = 0;
  
  function void add_expected(transaction_t t);
    if (expected_aa.exists(t.id))
      $display("WARNING: Overwriting expected for id=%0d", t.id);
    expected_aa[t.id] = t;
    $display("Expected added: id=%0d addr=%h data=%h", t.id, t.addr, t.data);
  endfunction
  
  function void check_actual(transaction_t actual);
    // Step 1: Check if we were expecting this ID
    if (!expected_aa.exists(actual.id)) begin
      $display("ERROR: Unexpected transaction id=%0d", actual.id);
      mismatch_count++;
      return;
    end
    
    // Step 2: Get expected and compare
    transaction_t exp = expected_aa[actual.id];
    
    if (exp.data !== actual.data || exp.addr !== actual.addr) begin
      $display("MISMATCH id=%0d:", actual.id);
      $display("  exp:  addr=%h data=%h", exp.addr, exp.data);
      $display("  act:  addr=%h data=%h", actual.addr, actual.data);
      mismatch_count++;
    end else begin
      $display("MATCH id=%0d: addr=%h data=%h", actual.id, actual.addr, actual.data);
      match_count++;
    end
    
    // Step 3: Remove from expected (consumed)
    expected_aa.delete(actual.id);
  endfunction
  
  function void final_report();
    $display("\n=== SCOREBOARD REPORT ===");
    $display("Matches:    %0d", match_count);
    $display("Mismatches: %0d", mismatch_count);
    
    if (expected_aa.num() > 0) begin
      $display("PENDING:    %0d (never received!)", expected_aa.num());
      foreach (expected_aa[id])
        $display("  id=%0d addr=%h data=%h", id, expected_aa[id].addr, expected_aa[id].data);
    end
    
    if (mismatch_count == 0 && expected_aa.num() == 0)
      $display("RESULT: PASS");
    else
      $display("RESULT: FAIL");
  endfunction
  
  initial begin
    transaction_t t;
    
    // Add expected (in order)
    t = '{0, 32'hAAAA, 8'h10};  add_expected(t);
    t = '{1, 32'hBBBB, 8'h20};  add_expected(t);
    t = '{2, 32'hCCCC, 8'h30};  add_expected(t);
    t = '{3, 32'hDDDD, 8'h40};  add_expected(t);
    
    $display("\n--- Actuals arrive OUT OF ORDER ---");
    // Actuals arrive in different order!
    t = '{2, 32'hCCCC, 8'h30};  check_actual(t);   // id=2 arrives first
    t = '{0, 32'hAAAA, 8'h10};  check_actual(t);   // id=0 arrives second
    t = '{3, 32'hDDDD, 8'h40};  check_actual(t);   // id=3 arrives third
    t = '{1, 32'hBBBB, 8'h20};  check_actual(t);   // id=1 arrives last
    
    final_report();
  end
endmodule