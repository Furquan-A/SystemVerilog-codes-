class Bottle;
  // YOUR CODE: static counter and instance id
  static int count;
  int id;
  
  
  function new();
    // YOUR CODE: increment counter, assign id
	count++;
	this.id = count;
  endfunction
  
  function void display();
    // YOUR CODE: show id and total count
	$display("id = %0d and the count is %0d",this.id,this.count);
  endfunction
endclass

module test;
  initial begin
    Bottle b1, b2, b3;
    
    b1 = new();
    b2 = new();
    b3 = new();
    
    b1.display();   // Expected: id=1, total=3
    b2.display();   // Expected: id=2, total=3
    b3.display();   // Expected: id=3, total=3
  end
endmodule