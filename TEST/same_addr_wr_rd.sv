class Same_addr_wr_rd extends Baseclass;
  function new(virtual inf vif);
    super.new(vif);
  endfunction
  extern virtual task main();
endclass : Same_addr_wr_rd 
    
task Same_addr_wr_rd::main();
  Transaction trans;
  int num;
  bit [ADD_WIDTH-1:0] value1;
  reset();
  env.run();
  if($value$plusargs ("NUM=%d",num))
    $info("NUM = %0d",num);
  else
    num = 1;
  repeat(num) begin
    trans = new();
    if(!trans.randomize() with { we_a == 1; we_b == 1; addr_a == addr_b;})
      $error("RANDOMIZATION FAILED");
    else
      send_data_gen(trans);
    array.push_back(trans.addr_b);
    count++;
  end
  repeat(num) begin
    trans = new();
    value1 = array.pop_front();
    if(!trans.randomize() with { we_a == 0; we_b == 0; addr_a == value1;  addr_b == value1; })
      $error("RANDOMIZATION FAILED");
    else
      send_data_gen(trans);
    count++;
  end
endtask
