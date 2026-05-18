class Driver;
  mailbox #(Transaction) gen2drv;
  virtual inf.DRV vif;

  function new(virtual inf.DRV vif, mailbox #(Transaction) gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction : new

  task main();
    Transaction trans;
    forever
    begin
      gen2drv.get(trans);
      @(vif.cb_drv);

      if(!vif.cb_drv.rst_n)
      begin
      vif.cb_drv.addr_a <= 0;
      vif.cb_drv.addr_b <= 0;
      vif.cb_drv.data_a <= 0;
      vif.cb_drv.data_b <= 0;
      vif.cb_drv.we_a <= 0;
      vif.cb_drv.we_b <= 0;
      end
      else
      begin
      vif.cb_drv.addr_a <= trans.addr_a;
      vif.cb_drv.addr_b <= trans.addr_b;
      vif.cb_drv.data_a <= trans.data_a;
      vif.cb_drv.data_b <= trans.data_b;
      vif.cb_drv.we_a <= trans.we_a;
      vif.cb_drv.we_b <= trans.we_b;
    end
    //trans.display("DRI");

    end
  endtask : main

endclass
