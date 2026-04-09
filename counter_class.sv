class counter;
	 int count;
	
	function new();
		count = 0;
	endfunction 
	
	function void increment();
		count++;
	endfunction 
	
	function void decrement();
		count--;
	endfunction 
	
	function void display();
		$display("Count value is %0d",count);
	endfunction
endclass 

module test;
	initial begin 
		counter c1,c2;
		c1 = new();
		c2 = new();
		
		c1.increment();
		c1.display();
		c1.increment();
		c1.display;
		
		
		c2.increment();
		c2.display();
		c2.increment();
		c2.display();
		c2.decrement();
		c2.display();
		
		// verify they are independent
		if(c1.count != c2.count)
			$display("PASS: Independent Objects");
		else 
			$display("ERROR");
		
		
	end 
endmodule 