module array_find_practice;
  initial begin
    int nums[] = '{10, 25, 3, 47, 8, 25, 99, 3, 15};
    
    // Task 1: Find all elements greater than 20
    int big[$] = nums.find(x) with (x > 20);
    $display("Greater than 20: %p", big);
    
    // Task 2: Find all elements equal to 25
    int twentyfives[$] = nums.find(x) with (x == 25);
    $display("Equal to 25: %p", twentyfives);
    $display("How many 25s? %0d", twentyfives.size());
    
    // Task 3: Find INDEX of first element equal to 99
    int idx[$] = nums.find_index(x) with (x == 99);
    $display("99 is at index: %0d", idx[0]);
    
    // Task 4: Find INDICES of all elements less than 10
    int small_idx[$] = nums.find_index(x) with (x < 10);
    $display("Indices of elements < 10: %p", small_idx);
    
    // YOUR TURN:
    // Task 5: Find all elements that are odd
    // YOUR CODE
	int odds[$] = nums.find(x) with (x%2 == 1);
	$display("odds are %p",odds);
    
    // Task 6: Find the index of the first element equal to 3
    // YOUR CODE
	int index = nums.find(x) with (x == 3);
	$display("First 3 at index: %0d", index[0]);
	
    
    // Task 7: How many elements are >= 15?
    // YOUR CODE
	int greater[$] = nums.find(x) with (x >= 15);
	$display(" nums gt than 15 are %p",greater.size());
  end
endmodule