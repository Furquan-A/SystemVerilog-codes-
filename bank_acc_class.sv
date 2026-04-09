class BankAccount;
  // Properties
  string name;
  int    balance;
  
  // Static (class-wide) properties
  static int total_accounts = 0;
  static int total_money = 0;
  
  function new(string name, int balance = 0);
    this.name = name;
    this.balance = balance;
    total_accounts++;
    total_money += balance;
  endfunction
  
  function void deposit(int amount);
    if (amount <= 0) begin
      $display("ERROR: deposit must be positive");
      return;
    end
    balance += amount;
    total_money += amount;
    $display("[%s] Deposited %0d, balance = %0d", name, amount, balance);
  endfunction
  
  function void withdraw(int amount);
    if (amount <= 0) begin
      $display("ERROR: withdraw must be positive");
      return;
    end
    if (amount > balance) begin
      $display("[%s] ERROR: insufficient funds (have %0d, need %0d)", 
                name, balance, amount);
      return;
    end
    balance -= amount;
    total_money -= amount;
    $display("[%s] Withdrew %0d, balance = %0d", name, amount, balance);
  endfunction
  
  function void display();
    $display("Account: %s, Balance: %0d", name, balance);
  endfunction
  
  static function void bank_summary();
    $display("=== BANK SUMMARY ===");
    $display("Total accounts: %0d", total_accounts);
    $display("Total money:    %0d", total_money);
  endfunction
  
  function BankAccount copy();
    BankAccount a = new(this.name, this.balance);
    return a;
    // Note: this calls new() which increments total_accounts and total_money
    // If you don't want that behavior, you'd need a different approach
  endfunction
endclass

module test;
  initial begin
    BankAccount alice, bob, charlie;
    
    alice   = new("Alice", 1000);
    bob     = new("Bob", 500);
    charlie = new("Charlie", 2000);
    
    alice.display();
    bob.display();
    charlie.display();
    
    BankAccount::bank_summary();   // 3 accounts, 3500 total
    
    $display("\n--- Transactions ---");
    alice.deposit(500);             // alice: 1500
    bob.withdraw(200);              // bob: 300
    charlie.withdraw(5000);         // ERROR: insufficient
    
    BankAccount::bank_summary();   // 3 accounts, 3800 total
  end
endmodule