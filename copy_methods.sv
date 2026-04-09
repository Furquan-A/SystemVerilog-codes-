class Packet;
  int          id;
  logic [31:0] data;
  bit          is_write;
  
  function new(int id = 0);
    this.id = id;
  endfunction
  
  // YOUR CODE: copy() method
  function Packet copy();
	Packet p;
	p = new();
	p.id = this.id;
	p.data= this.data;
	p.is_write = this.is_write;
	return p;
	endfunction 
  
  function void display();
    $display("Packet id=%0d data=%h is_write=%b", id, data, is_write);
  endfunction
endclass

module test;
  initial begin
    Packet p1, p2;
    
    p1 = new(10);
    p1.data = 32'hAAAA;
    p1.is_write = 1;
    
    p2 = p1.copy();
    
    // Modify p2 — should NOT affect p1
    p2.id = 99;
    p2.data = 32'hBBBB;
    p2.is_write = 0;
    
    $display("After modifying p2:");
    $write("p1: "); p1.display();
    $write("p2: "); p2.display();
    
    // p1 should still be id=10, data=AAAA, is_write=1
  end
endmodule