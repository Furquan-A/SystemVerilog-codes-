module test;
	int arr[];
	
	task push_front(input int value);
		int temp;
		int n;
		
		n = arr.size();
		temp = new[n+1];
		
		for(int i =0; i<n ; i++)
			temp[i+1] = arr[i];
		temp[0] = value;
		arr = temp;
	endtask 
	
	initial begin 
		arr = '{12,13,14};
		
		push_front(1);
		push_front(0);
		push_front(11);
		
		$display("arr = %p",arr);
	end 
endmodule 