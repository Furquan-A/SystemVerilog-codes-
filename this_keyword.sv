class person;
	string name;
	int age;
	
	function new(string name = "Alice", int age = 24);
		this.name = name;
		this.age = age;
	endfunction 
	
	function void display();
		$display("Name = %s and Age = %0d",this.name,this.age);
	endfunction 
endclass 

module test;
  initial begin
    person p1, p2;
    
    p1 = new("Alice", 25);
    p2 = new("Bob", 30);
    
    p1.display();
    p2.display();
  end
endmodule