class Transaction;
  
  rand bit [DATA_WIDTH-1:0] data_a, data_b;
  rand bit [ADD_WIDTH-1:0] addr_a, addr_b;
  rand bit we_a, we_b;
  bit [DATA_WIDTH-1:0] q_a, q_b;
  
  function void display(string str  = "Transaction");
    $display("[%0s] | [%0t]",str,$time);
    $display("DATA_A: %0h | DATA_B: %0h | ADDR_A : %0h | ADDR_B: %0h | WE_A: %b | WE_B: %b | Q_A: %0h | Q_B: %0h",data_a,data_b,addr_a, addr_b, we_a, we_b, q_a, q_b);
    $display("--------------------------------------");
  endfunction
  
endclass : Transaction
