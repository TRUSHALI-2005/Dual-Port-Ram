class Random_test extends Baseclass;
  function new(virtual inf vif);
    super.new(vif);
  endfunction
  extern virtual task main();
endclass : Random_test
    
task Random_test::main();
    Transaction trans;
  int num;
  reset();
  env.run();
  if($value$plusargs ("NUM=%d",num))
    $info("NUM = %0d",num);
  else
    num = 1;
    repeat(num) begin
    trans = new();
      if(!trans.randomize())
        $error("RANDOMIZATION FAILED");
      else
        send_data_gen(trans);
      count++;
  end
endtask
