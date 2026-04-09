module ass_iteration;
	
	initial begin 
		int data [ string ] ;
		string k; // create a variable to store the string/ KEY 
		data["zebra"] = 1;
		data["owl"]=2;
		data["pig"] = 4;
		data["fig"]=3;
		
		// Method 1: Foreach 
		$display(" --- FOREACH --");
		foreach(data[key]) // the String is assigned to the KEY here 
			$display("%s = %0d",key,data[key]);
			
		// Method 2: first/next ( gives more control ) where to start and can end earlier 
		// Note : the iteration happen Alphabetically in strings 
		$display("\n --- First/Next ---");
		
		if(data.first(k)) begin 
			do 
				$display("%s = %0d",k,data[k]);
			while(data.next(k));
		end 
		
		// Method 3: last/Prev 
		if(data.last(k)) begin // this Finds the Last Key in sorted order and stores in k 
			do 
				$display("%s = %0d",k,data[k]);
			while(data.prev[k]);
		end 
	end 
endmodule 

