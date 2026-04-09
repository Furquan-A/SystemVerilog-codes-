/Declare a Dunamic array and assign random values in the range of 1,100 
and find the Sum , MAX and MIN of the array 
module dynamic_arr;
	int arr[];
	int sort_array[$];
	int max,min;
	int n;
	
	initial begin 
      arr = new[15];
      foreach(arr[i])
        arr[i] = $urandom_range(1,100);
		
		$display(" arr = %p",arr);
		$display("sum of the arr is %0d ", arr.sum());
		
		// MAX value of the array 
		arr.sort();
		sort_array = arr;
		$display("sorted array : %p",sort_array);
		n = sort_array.size();
		max = sort_array[n-1];
		$display("max value is %0d", max);
		
		// Min value 
		min = sort_array[0];
		$display("min value is %0d", min);
	end 
endmodule 

//  Queue: Push 5 numbers into a queue, pop them one at a time, print each as you pop.

module queue_test;
	int q[$];
	int val;
	
	initial begin ;
	$display("Initially Queue is %p",q);
	q.push_back(2);
	q.push_back(33);
	q.push_back(21);
	q.push_back(11);
	q.push_back(23);
	$display("Queue is %p",q);
	
	$display(" -- POP START --");
	
	val = q.pop_back();
	$display("Queue is %p",q);
	$display("popped value 1 = %p",val);
	
	val = q.pop_front();
	$display("Queue is %p",q);
	$display("popped value 2 = %p",val);
	
	val = q.pop_front();
	$display("Queue is %p",q);
	$display("popped value 3 = %p",val);
	
	val = q.pop_front();
	$display("Queue is %p",q);
	$display("popped value 4 = %p",val);
	
	val = q.pop_front();
	$display("Queue is %p",q);
	$display("popped value 5 = %p",val);
	
	// for(int i =1; i < 5; i++) begin 
	//	val = q.pop_back();
	//	$display("popped value %0d is %p",i, val);
	//	$display(" New Queue is %p",q);
	//end 
	end 
endmodule 

// Associative array: Create an associative array of int keyed by string. 
//Add three entries (like "alice", "bob", "charlie" with scores). 
//Print using foreach. Check if "dave" exists before reading.

module associative_arr;
	int ass_arr [string];
	
	initial begin 
		ass_arr["ALICE"] = 49;
		ass_arr["AHMED"] = 101;
		ass_arr["BOB"] = 2;
		
		// foreach Method 
		foreach(ass_arr[name]) begin 
			$display("%s scored %0d",name,ass_arr[name]);
		end 
		
		if(!ass_arr.exists("dove"))
			$display("ERROR");
		
	end 
endmodule 