class transaction;
  int id;
  
  function new(int id);
    this.id = id;
  endfunction 
  
  function void display();
    $display("transaction id = %0d",this.id);
  endfunction 
endclass 

class can_frame extends transaction;
  int can_id;
  logic [7:0]data;
  
  function new(int id,int can_id, logic[7:0]data);
    super.new(id);
    this.can_id = can_id;
    this.data =data;
  endfunction 
  
  function void display();
    super.display();
    $display("can_id = %0d, data = %h",can_id,data);
  endfunction 
endclass 

module test;
  initial begin 
    transaction tr;
    can_frame cf;
    tr = new(3);
    cf = new(2,12,8'hAA);
    cf.display();
  end 
endmodule 