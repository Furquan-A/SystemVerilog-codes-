module array_challenge;
  initial begin
    int data [] = '{15, 3, 8, 3, 22, 7, 15, 1, 8, 42, 3, 7};
    int un[$];
    int seen[$];
    int dups[$];
    int count[$];
    int already[$];
    int sorted_copy[];
    int unique_sorted[$];
    int evens[$];
    int even_sum;
    int big[$];
    
    // Task 1: Find how many unique values exist
    un = data.unique();
    $display("Task 1: Unique values = %p", un);
    $display("Task 1: Number of unique values = %0d", un.size());
    
    // Task 2: Find all values that appear more than once (duplicates)
    foreach (data[i]) begin
      count = data.find(x) with (x == data[i]);
      if (count.size() > 1) begin
        already = dups.find(x) with (x == data[i]);
        if (already.size() == 0) begin
          dups.push_back(data[i]);
          $display("  %0d appears %0d times", data[i], count.size());
        end
      end
    end
    $display("Task 2: Duplicates = %p", dups);
    
    // Task 3: Find the second largest value
    sorted_copy = new[data.size()];
    foreach (data[i]) sorted_copy[i] = data[i];
    sorted_copy.rsort();
    unique_sorted = sorted_copy.unique();
    unique_sorted.rsort();
    $display("Task 3: Second largest = %0d", unique_sorted[1]);
    
    // Task 4: Find the sum of all even numbers
    evens = data.find(x) with ((x % 2) == 0);
    even_sum = evens.sum();
    $display("Task 4: Even numbers = %p", evens);
    $display("Task 4: Sum of evens = %0d", even_sum);
    
    // Task 5: Create a new array containing only values > 10, sorted
    big = data.find(x) with (x > 10);
    big.sort();
    $display("Task 5: Values > 10 sorted = %p", big);
  end
endmodule