class Monitor;

  virtual inf.MON vif;
  mailbox #(Transaction) mon2sco;
  
  function new(virtual inf.MON vif, mailbox #(Transaction) mon2sco );
    this.vif = vif;
    this.mon2sco = mon2sco;
  endfunction : new

  task main();
    Transaction trans;
    forever
    begin
      trans = new();
      @(vif.cb_mon);
      if(vif.cb_mon.rst_n)
      begin
      trans.data_a = vif.cb_mon.data_a;
        trans.data_b = vif.cb_mon.data_b;
        
      trans.addr_a = vif.cb_mon.addr_a;
        trans.addr_b = vif.cb_mon.addr_b;
        
      trans.we_a = vif.cb_mon.we_a;
        trans.we_b = vif.cb_mon.we_b;
      trans.q_a = vif.cb_mon.q_a;
        trans.q_b = vif.cb_mon.q_b;
      mon2sco.put(trans);
    end
     // trans.display("MON");
    end
  endtask : main

endclass : Monitor
