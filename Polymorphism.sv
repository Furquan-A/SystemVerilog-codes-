class shape;
  virtual function real area();
    return 0.0;
  endfunction

  virtual function string name();
    return "shape";
  endfunction

  function void describe();
    $display("%s with area %0.2f", name(), area());
  endfunction
endclass

class circle extends shape;
  real radius;

  function new(real r);
    radius = r;
  endfunction

  function real area();
    return 3.14159 * radius * radius;
  endfunction

  function string name();
    return "circle";
  endfunction
endclass

class rectangle extends shape;
  real width, height;

  function new(real w, real h);
    width  = w;
    height = h;
  endfunction

  function real area();
    return width * height;
  endfunction

  function string name();
    return "rectangle";
  endfunction
endclass

module test;
  initial begin
    real total;
    shape sh[$];
    circle c;
    rectangle r;

    total = 0;

    c = new(5);
    r = new(2,3);

    sh.push_back(c);
    sh.push_back(r);

    foreach (sh[i])
      sh[i].describe();

    foreach (sh[i])
      total = total + sh[i].area();

    $display("Total area: %0.2f", total);
  end
endmodule

//The magic: describe() is defined in Shape and uses name() and area(). But when you call
// it on a Circle, it gets the Circle's name and area — because those are virtual. The parent's
// code works with any child, automatically.


class job;
  virtual function int salary();
    return 0;
  endfunction 
  
  virtual function string name();
    return "Job";
  endfunction 
  
  virtual function string difficulty();
    $display("It is based up on the job");
  endfunction 
  
  function string describe();
    $display("Job of %s pays %0d",name(),salary());
  endfunction 
endclass 

class design_engineer extends job;
  string job_name;
  int amount;
  
  function new(string job_name,int amount);
    this.job_name = name;
    this.amount = amount;
  endfunction 
  
  function int salary();
    return amount;
  endfunction 
  
  function string name();
    return "design_engineer";
  endfunction 
  
  function string difficulty();
    $display("Design jobs are critical to work on ");
  endfunction 
endclass 

class design_verification extends job;
  string job_name;
  int amount;
  
  function new(string job_name,int amount);
    this.job_name=job_name;
    this.amount = amount;
  endfunction 
  
  function string name();
    return "design_verification";
  endfunction 
  
  function string difficulty();
    $display(" Its tough and enjoying too");
  endfunction 
  
  function int salary();
    return amount;
  endfunction
  
endclass 

module test;
  initial begin 
    job j[$];
    design_engineer de;
    design_verification dv;
    
    de = new("Design Engineer",120);
    dv = new("Design Verification",200);
    
    j.push_back(de);
    j.push_back(dv);
    
    foreach(j[i])
      j[i].describe();
	
	de.difficulty();
	dv.difficulty();
  end
endmodule 