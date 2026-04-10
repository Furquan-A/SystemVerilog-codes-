// 1Q
module test;

    // a. 512 element integer array
    integer array [0:511];

    // b. 9-bit address
    bit [8:0] addr;

    // e. task definition
    task my_task(ref integer array [0:511], input bit [8:0] addr);
        print_int(array[--addr]); // pre-decrement then index
    endtask

    // f. function definition
    function void print_int(input integer val);
        $display("at time = %t value = %d", $time, val);
    endfunction

    initial begin
        // c. initialize last element to 5
        array[511] = 5;

        // d. call task
        addr = 9'd512; // so --addr = 511 (last element)
        my_task(array, addr);
    end

endmodule

// 4Q
module time_test;

    initial begin
        // set time format: ps, 2 decimal places, minimum characters
        $timeformat(-12, 2, "ps", 0);

        // display current time
        $display("Time is %t", $realtime);
    end

endmodule