module test;
	int arr[];
	
	task pop_front(output int value);
		int temp[];
		int n;
		
		n = arr.size();
		
		if(n == 0) begin 
			$display("pop_front: Arr is empty");
			value = 0 ;
			return;
		end 
		
		value = arr[0];
		temp = new[n-1];
		
		for(int i =0; i < n-1; i++)
			temp[i-1] = arr[i];
			
	endtask 
	
	initial begin
    int value;
    
    arr = '{12,13,14};
    
    pop_front(value);
    $display("arr = %p", arr);
    $display("pop value = %0d", value);
  end
endmodule
	