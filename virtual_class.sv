virtual class shape;
  string name;
  virtual function void display();
    $display("Its an abstract Shape Clas");
  endfunction
endclass 

class circle extends shape;
  real radius;
  function real area();
    return 3.14*radius*radius;
  endfunction 
  
  function new();
    name = "CIRCLE";
    this.radius= 5.0;
  endfunction 
  
  function void display();
    $display(" Shape is %s",name);
    $display("Area is %0f",area());
  endfunction
endclass

module test;
  initial begin 
    circle c;
    shape s;
    c= new();
    s = c;
    s.display();
  end 
endmodule 