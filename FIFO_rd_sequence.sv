package FIFO_rd_sequence_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"

class FIFO_rd_seq extends uvm_sequence #(FIFO_seq_item);
FIFO_seq_item rd_seq_item;
`uvm_object_utils(FIFO_rd_seq)

    function new(string name="FIFO_rd_seq");
        super.new(name);
    endfunction //new()

    task body();
    repeat(10)begin
        rd_seq_item=FIFO_seq_item::type_id::create("rd_seq_item");
        start_item(rd_seq_item);
        rd_seq_item.wr_en=0;
        rd_seq_item.rd_en=1;
        rd_seq_item.rst_n=1;
        rd_seq_item.data_in=$random;
        finish_item(rd_seq_item);
    end
    endtask //


endclass //FIFO_rst_seq extends superClass
endpackage