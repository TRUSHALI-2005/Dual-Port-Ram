`include "package.sv"
`include "interface.sv"
import port_pkg::*;

module testbench;

inf inff();

Test t1;

dual_port_ram #(
    .ADD_WIDTH (ADD_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH     (DEPTH)
) DUT (
    .clk   (inff.clk),
    .rst_n (inff.rst_n),
    .data_a (inff.data_a),
    .addr_a (inff.addr_a),
    .we_a   (inff.we_a),
    .q_a    (inff.q_a),
    .data_b (inff.data_b),
    .addr_b (inff.addr_b),
    .we_b   (inff.we_b),
    .q_b    (inff.q_b)
);
  
always #10 inff.clk = ~inff.clk;

  string testname;
  initial begin
    inff.clk = 1'b0;
    testcase();
    t1.main();
    wait(t1.count == t1.env.sco.num );
    $info("WAIT DONE %0t",$time);
    @(posedge inff.clk);
    $finish;
  end

initial
begin
  $dumpfile("dump.vcd");
  $dumpvars;
end

  task testcase();
    if($value$plusargs ("TESTNAME=%s",testname))
    begin
      case(testname)
        "random_test": begin t1 = Random_test::new(inff); end
        "sanity_same": begin t1 = Sanity_same::new(inff); end
        "sanity_diff": begin t1 = Sanity_diff::new(inff); end
        "same_addr_wr_rd": begin t1 = Same_addr_wr_rd::new(inff); end
        "para_wr_rd": begin t1 = Para_wr_rd::new(inff); end
        default: $fatal("TESTCASE NOT FOUND");
      endcase
    end
  endtask : testcase
endmodule : testbench
