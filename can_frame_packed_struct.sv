module can_frame_exercise;
  
  typedef enum logic [1:0] {
    DATA_FRAME   = 2'b00,
    REMOTE_FRAME = 2'b01,
    ERROR_FRAME  = 2'b10,
    OVERLOAD     = 2'b11
  } frame_type_t;
  
  typedef struct packed {
    frame_type_t  frame_type;
    logic         ide;
    logic [28:0]  id;
    logic [3:0]   dlc;
    logic [63:0]  data;
  } can_frame_t;
  
  function bit validate_frame(can_frame_t f);
    // Rule 1: DLC must be 0-8
    if (f.dlc > 8) begin
      $display("  FAIL: DLC = %0d (must be 0-8)", f.dlc);
      return 0;
    end
    
    // Rule 2: Standard frame ID must fit in 11 bits
    if (f.ide == 0 && f.id[28:11] != 0) begin
      $display("  FAIL: Standard frame but ID uses extended bits");
      return 0;
    end
    
    // Rule 3: Remote frame should have no data
    if (f.frame_type == REMOTE_FRAME && f.data != 0) begin
      $display("  FAIL: Remote frame has non-zero data");
      return 0;
    end
    
    // Rule 4: Only bytes up to DLC should have data
    for (int i = f.dlc; i < 8; i++) begin
      if (f.data[i*8 +: 8] != 0) begin
        $display("  FAIL: Data byte %0d non-zero but DLC=%0d", i, f.dlc);
        return 0;
      end
    end
    
    return 1;
  endfunction
  
  function void display_frame(can_frame_t f);
    $display("=== CAN Frame ===");
    $display("  Type : %s", f.frame_type.name());
    $display("  IDE  : %s", f.ide ? "Extended(29-bit)" : "Standard(11-bit)");
    if (f.ide)
      $display("  ID   : 0x%h", f.id);
    else
      $display("  ID   : 0x%h", f.id[10:0]);
    $display("  DLC  : %0d", f.dlc);
    $display("  Data : 0x%h", f.data);
    $display("  Bits : %0d", $bits(f));
  endfunction
  
  initial begin
    can_frame_t frame1, frame2, frame3;
    
    frame1.frame_type = DATA_FRAME;
    frame1.ide = 0;
    frame1.id = 29'h0000_07FF;
    frame1.dlc = 4'd4;
    frame1.data = 64'h00000000_DEADBEEF;
    
    frame2.frame_type = DATA_FRAME;
    frame2.ide = 0;
    frame2.id = 29'h0000_0100;
    frame2.dlc = 4'd10;
    frame2.data = 64'h0;
    
    frame3.frame_type = DATA_FRAME;
    frame3.ide = 0;
    frame3.id = 29'h1FFF_FFFF;
    frame3.dlc = 4'd2;
    frame3.data = 64'h0000_0000_0000_AABB;
    
    display_frame(frame1);
    $display("  Valid: %s\n", validate_frame(frame1) ? "YES" : "NO");
    
    display_frame(frame2);
    $display("  Valid: %s\n", validate_frame(frame2) ? "YES" : "NO");
    
    display_frame(frame3);
    $display("  Valid: %s\n", validate_frame(frame3) ? "YES" : "NO");
  end
endmodule
