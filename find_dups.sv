module unique_practice;
  initial begin
    int data[] = '{5, 3, 8, 3, 5, 9, 1, 8, 3};
    
    $display("Original: %p (size=%0d)", data, data.size());
    
    // Get unique values
    int uq[$] = data.unique();
    $display("Unique:   %p (size=%0d)", uq, uq.size());
    
    // Are there duplicates?
    if (uq.size() < data.size())
      $display("YES, there are duplicates");
    
    // YOUR TURN: Find WHICH values are duplicated
    // Logic: if a value appears more than once, it's a duplicate
    // Use find() to count occurrences of each unique value
    
    $display("\nDuplicated values:");
    foreach (uq[i]) begin
      int count[$] = data.find(x) with (x == uq[i]);
      // YOUR CODE: print the value and count if count > 1
		if (count.size() > 1)
        $display("  %0d appears %0d times", uq[i], count.size());
    end
  end
endmodule