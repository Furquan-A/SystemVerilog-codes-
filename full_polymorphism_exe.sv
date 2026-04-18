virtual class Stimulus;
  int id;
  static int count = 0;

  function new();
    count++;
    id = count;
  endfunction

  pure virtual function void display();
  pure virtual function int get_size();
endclass


class SmallPacket extends Stimulus;
  logic [7:0] data;

  function new(logic [7:0] data);
    super.new();
    this.data = data;
  endfunction

  function void display();
    $display("SmallPacket: id=%0d data=%h", id, data);
  endfunction

  function int get_size();
    return 1;
  endfunction
endclass


class BigPacket extends Stimulus;
  logic [63:0] data;

  function new(logic [63:0] data);
    super.new();
    this.data = data;
  endfunction

  function void display();
    $display("BigPacket: id=%0d data=%h", id, data);
  endfunction

  function int get_size();
    return 8;
  endfunction
endclass


module test;
  initial begin
    Stimulus st[$];
    SmallPacket s1, s2, s3;
    BigPacket   b1, b2;
    BigPacket   bp;
    int total_bytes = 0;

    // Create 3 SmallPackets and 2 BigPackets
    s1 = new(8'h24);
    s2 = new(8'h34);
    s3 = new(8'h44);

    b1 = new(64'h1122334455667788);
    b2 = new(64'hAABBCCDDEEFF0011);

    // Store in Stimulus queue
    st.push_back(s1);
    st.push_back(s2);
    st.push_back(s3);
    st.push_back(b1);
    st.push_back(b2);

    // Polymorphism: display all through base-class handle
    $display("--- Display all stimuli ---");
    foreach (st[i]) begin
      st[i].display();
      total_bytes += st[i].get_size();
    end

    $display("Total bytes across all packets = %0d", total_bytes);

    // Use $cast to find only BigPackets
    $display("\n--- Only BigPackets ---");
    foreach (st[i]) begin
      if ($cast(bp, st[i]))
        $display("BigPacket found: id=%0d data=%h", bp.id, bp.data);
    end

    // Print total stimulus count
    $display("\nTotal stimulus count = %0d", Stimulus::count);
  end
endmodule