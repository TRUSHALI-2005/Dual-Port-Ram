class Scoreboard;
  mailbox #(Transaction) mon2sco;
  int num;

  logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  bit [DATA_WIDTH-1:0] exp_q_a, exp_q_b;

  task reference(Transaction trans);

  // READ PORT A
  if (!trans.we_a)
    exp_q_a = mem[trans.addr_a];

  // READ PORT B
  if (!trans.we_b)
    exp_q_b = mem[trans.addr_b];

  // WRITE PORT A
  if (trans.we_a)
    mem[trans.addr_a] = trans.data_a;

  // WRITE PORT B
  if (trans.we_b)
    mem[trans.addr_b] = trans.data_b;

  endtask

  function new(mailbox #(Transaction) mon2sco);
    this.mon2sco = mon2sco;
  endfunction : new

  task main();
    Transaction trans;
    forever
    begin
      trans = new();
      mon2sco.get(trans);
      reference(trans);
      num++;
      //$display(" SCO NUM: %0d",num);
      if(exp_q_a == trans.q_a && exp_q_b == trans.q_b)
      begin
        $display("************PASS******************");
        trans.display("SCO");
      end
      else
      begin
        $display("************FAIL******************");
        trans.display("SCO");
        $display("[%0s] | [%0t]","REF",$time);
        $display("EXP q_a : %0h q_b: %0h",exp_q_a, exp_q_b);
        $display("--------------------------------------");
      end
    end
  endtask : main

endclass : Scoreboard
