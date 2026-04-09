class Bottle;
  static int count = 0;
  int id;
  
  function new();
    count++;
    id = count;
  endfunction
  
  // YOUR CODE: add static function get_count()
  static function int get_count();
	return count++;
  endfunction 
  
endclass

module test;
  initial begin
    // Call static method WITHOUT creating an object
    $display("Initial count: %0d", Bottle::get_count());   // 0
    
    Bottle b1 = new();
    Bottle b2 = new();
    
    $display("After 2 bottles: %0d", Bottle::get_count());  // 2
  end
endmodule