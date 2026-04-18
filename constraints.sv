//Problem 1: "Write a constraint for a packet where address is aligned to 4 bytes."

constraint addr_size {
  addr % 4 == 0;
  //or Equivalant 
  addr[1:0] == 2'b00;
}

//Problem 2: "Write a constraint where if packet type is SHORT, length < 64. If LONG, length >= 64 and < 1024."
constraint pkt_length {
  (length < 64) -> pkt_type == SHORT;
  ((length >=64) && (length <1024)) -> pkt_type == LONG;
}

// or 
constraint pkt_type {
  if(type == 0)
    length inside {[0:63]};
  else 
    length inside {[64:1023]};
}

//"Generate a valid CAN frame: DLC 0-8, data bytes beyond DLC must be zero."

rand logic [3:0] dlc;
rand logic [7:0] data[8];

constraint valid_can {
  dlc inside {[0:8]};
  foreach(data[i])
    if(i > dlc)
      data[i] == 0;
}

//  "Generate a packet where exactly 3 out of 8 flag bits are set."4
rand bit [7:0] flags;

constraint three_set {
  $countones(flags) == 3;
}




//Exercise 1: Basic Randomization
//Create a Dice class with randc bit [2:0] face. Randomize 16 times and observe that each full cycle of 8 values has no repeats.