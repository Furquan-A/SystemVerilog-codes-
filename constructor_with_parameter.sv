class rectangle;
	int width;
	int height;
	
	function new(int new_width = 1, int new_height = 1);
		this.width = new_width;
		this.height = new_height;
	endfunction 
	
	function int area();
		return width*height;
	endfunction 
	
	function void display();
		$display("Width = %0d, Height = %0d and Area = %0d",this.width,this.height,area());
	endfunction 
endclass 


module test;		
	initial begin 
		rectangle r1;
		r1 = new(12,3);
		r1.area();
		r1.display();
	end 
endmodule 
