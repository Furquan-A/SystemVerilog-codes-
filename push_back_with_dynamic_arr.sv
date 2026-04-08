module test;
	int arr[];
	
	task push_back(input int value;
		int temp[];
		int n;
		
		n = arr.size();
		temp = new[n+1];
		
		for(int i = 0; i< n; i++) 
			temp[i] = arr[i];
		
		temp[n] = value ;
		arr = temp;
	endtask 
	
	initial begin 
		arr = '{12,11,13};
		
		push_back(10);
		push_back(1);
		push_back(2);
		
		$display("arr = %p",arr);
	end 
endmodule 