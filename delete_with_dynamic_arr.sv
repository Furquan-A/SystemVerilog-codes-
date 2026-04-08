module test;
	int arr[];
	
	task delete_at(input int index);
		int temp[];
		int n;
		
		n = arr.size();
		
		if (index < 0 || index >= n) begin
			$display("delete_at: invalid index %0d", index);
			return;
		end
		
		temp = new[n-1];
		
		for(int i = 0; i < index; i++)
			temp[i] = arr[i];
			
		for(int i = index+1; i < n ; i++)
			temp[i-1] = arr[i];
			
		arr = temp;
	endtask  
	
	initial begin 
		arr = '{10,20,11};
		
		delete_at(0);
		$display("arr = %p",arr);
	end 
endmodule 