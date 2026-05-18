class Sanity_diff extends Baseclass;
  function new(virtual inf vif);
    super.new(vif);
  endfunction
  extern virtual task main();
endclass : Sanity_diff
    
task Sanity_diff::main();
  Transaction trans;
  int num;
  bit [ADD_WIDTH-1:0] addr_wr;
  reset();
  env.run();
  if($value$plusargs ("NUM=%d",num))
    $info("NUM = %0d",num);
  else
    num = 1;
    repeat(num) begin
    trans = new();
      if(!trans.randomize() with { we_a == 1; we_b == 0; })
        $error("RANDOMIZATION FAILED");
      else
        send_data_gen(trans);
      addr_wr = trans.addr_a;
      count++;
      trans = new();
      if(!trans.randomize() with { we_a == 1; we_b == 0; addr_wr == addr_b; })
        $error("RANDOMIZATION FAILED");
      else
        send_data_gen(trans);
      count++;
  end
endtask
