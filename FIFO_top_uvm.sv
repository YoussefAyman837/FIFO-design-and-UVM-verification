import uvm_pkg::*;
import FIFO_config_package::*;
import FIFO_test_package::*;
module FIFO_top_uvm (
);
bit clk;

initial begin
    clk=0;
    forever begin
        #1 clk = ~clk;
    end
end

FIFO_if FIFO_if(clk);

FIFO f1(FIFO_if);

initial begin
    uvm_config_db #(virtual FIFO_if)::set(null , "uvm_test_top" , "FIFO_if", FIFO_if );
    run_test("FIFO_test");
end

endmodule