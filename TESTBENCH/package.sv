package port_pkg;
parameter ADD_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter DEPTH = 256;
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
`include "testcase.sv"
// `include "seq_wr_rd.sv"
// `include "mul_wr_rd.sv"
// `include "wr_rd.sv"
// `include "same_addr_write.sv"
// `include "same_addr_read.sv"
// `include "write_a_read_b.sv"
// `include "write_b_read_a.sv"
`include "mul_wr_rd_same.sv"
 `include "random.sv"
`include "sanity_same.sv"
`include "sanity_diff.sv"
`include "same_addr_wr_rd.sv"
endpackage
