module dual_port_ram
  #(parameter ADD_WIDTH=8,
    parameter DATA_WIDTH=8,
    parameter DEPTH=128)
  (
    input [DATA_WIDTH-1:0] data_a, data_b,   // input data
    input [ADD_WIDTH-1:0] addr_a, addr_b,   // addresses
    input we_a, we_b,                       // write enable
    input clk,
    input rst_n,                            // active low reset
    output reg [DATA_WIDTH-1:0] q_a, q_b    // outputs
);

  reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

  integer i;

  always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
    begin
      q_a <= 0;
    end
    else
    begin
      if (we_a)
        ram[addr_a] <= data_a;
      else
        q_a <= ram[addr_a];
    end
  end

  always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
    begin
      q_b <= 0;
    end
    else
    begin
      if (we_b)
        ram[addr_b] <= data_b;
      else
        q_b <= ram[addr_b];
    end
  end

endmodule
