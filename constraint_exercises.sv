//Exercise 1: Basic Randomization
//Create a Dice class with randc bit [2:0] face. Randomize 16 times and observe that each full cycle of 8 values has no repeats.

class dice;
  randc bit [2:0] face;
  constraint face_value {
    face inside {[0:6]};
  }
endclass 

module test;
  initial begin 
    dice dc = new();
    for (int i=0;i<16;i++) begin 
      dc.randomize();
      $display("face values are %d",dc.face);
    end 
  end 
endmodule 

/*Exercise 2: Constrained Packet
Create a Packet class with:

rand bit is_write
rand logic [7:0] addr
rand logic [31:0] data
rand int length

Constraints:

Address between 0x10 and 0xEF
Length is 1, 2, 4, or 8
If read, data must be 0
If write, data must be non-zero

Generate 10 packets and print each.*/

class packet;
  rand bit is_write;
  rand logic [7:0] addr;
  rand logic [31:0] data;
  rand int length;
  
  constraint packet_valid {
    addr inside {[8'h10:8'hEF]};
    length inside {1,2,4,8};
    if(is_write)
      data != 0;
    else 
      data == 0;
  }
endclass 

module test;
  initial begin 
    packet pt;
    pt = new();
    
    for (int i=0;i<10;i++) begin 
      if(pt.randomize())
    	 $display("PACKET: %s addr=%h data=%h length=%0d",
         pt.is_write ? "WRITE" : "READ",
         pt.addr, pt.data, pt.length);
      else 
        $display("Randomization Failed");
    end 
  end 
endmodule 

/*Exercise 3: CAN Frame Randomization
Create a CANFrame class with:

rand bit [10:0] id
rand bit [3:0] dlc
rand logic [7:0] data[8]
rand bit rtr (remote frame flag)

Constraints:

DLC between 0 and 8
If RTR=1 (remote frame), all data must be 0
Data bytes beyond DLC must be 0
Add a post_randomize() to calculate a simple checksum*/
class CANFrame;
  
  rand bit [10:0] id;
  rand bit [3:0]  dlc;
  rand logic [7:0] data[8];
  rand bit rtr; // remote frame 
  logic [7:0] checksum;
  
  constraint valid_fame {
    dlc inside {4,5,6,7};
    if (rtr)
      foreach (data[i])
        data[i] == 0;

    foreach (data[i])
      if (i >= dlc)
        data[i] == 0;
  }
  
  function void post_randomize();
    checksum = 0;

    for (int i = 0; i < dlc; i++)
      checksum += data[i];

    checksum += id;
    checksum += dlc;
    checksum += rtr;

    checksum = checksum & 8'hFF;
  endfunction 
  
endclass 

module test;
  initial begin 
    CANFrame cf;
    cf = new();
	
    for(int i = 0; i<10;i++) begin 
      if (cf.randomize()) begin
        $display("CANFRAME: id=%0d dlc=%0d rtr=%0b checksum=%h",
                 cf.id, cf.dlc, cf.rtr, cf.checksum);

        foreach (cf.data[i])
          $display("data[%0d] = %h", i, cf.data[i]);
      end
      else 
        $display("Randomization Failed");
    end
  end 
endmodule

//"Generate a memory transaction where the address is 4-byte aligned, the burst length is 1, 2, 4, 8, or 16, and the total transfer size (burst length × 4 bytes) never exceeds 64 bytes."

constraint mem_fields {
  addr%4 ==0;
  burst_length inside {1,2,4,8,16}; // or $countones(burst_length) ==1
  (burst_length*4) <= 64;
}
   

