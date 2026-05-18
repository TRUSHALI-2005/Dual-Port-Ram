class Baseclass extends Test;
  bit [DATA_WIDTH-1:0] array[$];
  function new(virtual inf vif);
    super.new(vif);
  endfunction : new
  extern task write();
  extern task read();
    extern task write_a();
  extern task write_b();
endclass : Baseclass

task Baseclass::write_a();
  Transaction trans;
  trans = new();
  if (!trans.randomize() with { we_a == 1; we_b == 0;})
    $error("Randomization Failed");
  else
    send_data_gen(trans);
  count++;
  array.push_back(trans.addr_a);
endtask : write_a
    
task Baseclass::write_b();
  Transaction trans;
  trans = new();
      if (!trans.randomize() with { we_a == 0; we_b == 1;})
    $error("Randomization Failed");
  else
    send_data_gen(trans);
  count++;
  array.push_back(trans.addr_b);
endtask : write_b

    //------------READ BOTH----------------------
task Baseclass::read();
  Transaction trans;
  int val_a, val_b;
  trans = new();
  val_a = array.pop_front();
  val_b = array.pop_front();
      if (!trans.randomize() with { we_a == 0; we_b == 0; addr_a == val_a; addr_b == val_b; })
    $error("Randomization Failed");
  else
    send_data_gen(trans);
  count++;
endtask : read
    
//-------------------Para Write-----------------------
task Baseclass::write();
  Transaction trans;
  trans = new();

      if (!trans.randomize() with { we_a == 1; we_b == 1;})
    $error("Randomization Failed");
  else
    send_data_gen(trans);
  count++;
  array.push_back(trans.addr_a);
  array.push_back(trans.addr_b);
endtask : write
