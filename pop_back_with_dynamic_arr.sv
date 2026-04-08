module test;
  int arr[];
  
  task pop_back(output int value);
    int temp[];
    int n;
    
    n = arr.size();
    
    if (n == 0) begin
      $display("pop_back: arr is empty");
      value = 0;
      return;
    end
    
    value = arr[n-1];
    temp = new[n-1];
    
    for (int i = 0; i < n-1; i++)
      temp[i] = arr[i];
    
    arr = temp;
  endtask
  
  initial begin
    int value;
    
    arr = '{12,13,14};
    
    pop_back(value);
    $display("arr = %p", arr);
    $display("pop value = %0d", value);
  end
endmodule