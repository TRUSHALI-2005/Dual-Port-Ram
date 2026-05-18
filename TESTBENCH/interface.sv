parameter ADD_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter DEPTH = 256;

interface inf;
  logic [DATA_WIDTH-1:0] data_a,data_b;
  logic [ADD_WIDTH-1:0] addr_a,addr_b;
  logic we_a,we_b;
  logic clk,rst_n;
  logic [DATA_WIDTH-1:0] q_a, q_b;
   
  clocking cb_drv @(posedge clk);
    default input #1 output #0;
    output data_a, data_b, addr_a, addr_b, we_a, we_b;
    input rst_n;
  endclocking
  
  clocking cb_mon @(posedge clk);
    default input #0 output #0;
    input data_a, data_b, addr_a, addr_b, we_a, we_b, rst_n, q_a, q_b;
  endclocking
   
  modport DRV ( clocking cb_drv );
  modport MON ( clocking cb_mon );
      
endinterface
