module array_sort_practice;
  initial begin
    int nums[] = '{50, 10, 30, 20, 40};
    
    $display("Original:  %p", nums);
    
    // sort modifies the array in-place
    nums.sort();
    $display("Sorted:    %p", nums);
    
    nums.rsort();
    $display("Rev sort:  %p", nums);
    
    nums.reverse();
    $display("Reversed:  %p", nums);
    
    nums.shuffle();
    $display("Shuffled:  %p", nums);
    
    // IMPORTANT: min() and max() return a QUEUE, not a single value
    int mn[$] = nums.min();
    int mx[$] = nums.max();
    $display("Min = %0d, Max = %0d", mn[0], mx[0]);
    
    // Sum and product
    $display("Sum = %0d", nums.sum());
    // product can overflow with large values, be careful
    
    // YOUR TURN: Given this array of scores, find:
    int scores[] = '{85, 92, 78, 95, 88, 72, 91, 83};
    
    // 1. The top 3 scores (sorted descending, take first 3)
    // YOUR CODE
	 scores.rsort();
    $display("Top 3: %0d, %0d, %0d", scores[0], scores[1], scores[2]);
    
    // 2. The average score (sum / size)
    // YOUR CODE
	int avg = scores.sum()/scores.size();
	$display(" avg score is %0d", avg);
    
    // 3. How many scores are above the average
    // YOUR CODE
	int gr[$] = scores.find(x) with ( x > avg);
	$display(" scores > avg are %p",gr.size());
  end
endmodule