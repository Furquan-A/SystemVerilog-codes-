module test;
  int arr[];
  
  task insert_at(input int value, input int index);
    int temp[];
    int n;
    
    n = arr.size();
    
    if (index < 0 || index > n) begin
      $display("insert_at: Invalid index %0d", index);
      return;
    end
    
    temp = new[n+1];
    
    for (int i = 0; i < index; i++)
      temp[i] = arr[i];
    
    temp[index] = value;
    
    for (int i = index; i < n; i++)
      temp[i+1] = arr[i];
    
    arr = temp;
  endtask
  
  initial begin
    arr = '{10,20,30};
    
    insert_at(99, 1);
    $display("arr = %p", arr);

    insert_at(88, 3);
    $display("arr = %p", arr);
  end
endmodule