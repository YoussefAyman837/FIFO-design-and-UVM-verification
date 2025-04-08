package FIFO_rst_sequence_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"

class FIFO_rst_seq extends uvm_sequence #(FIFO_seq_item);
FIFO_seq_item rst_seq_item;
`uvm_object_utils(FIFO_rst_seq)

    function new(string name="FIFO_rst_seq");
        super.new(name);
    endfunction //new()

    task body();
        rst_seq_item=FIFO_seq_item::type_id::create("rst_seq_item");
        start_item(rst_seq_item);
        rst_seq_item.wr_en=0;
        rst_seq_item.rd_en=0;
        rst_seq_item.rst_n=0;
        rst_seq_item.data_in=$random;
        finish_item(rst_seq_item);
    endtask //


endclass //FIFO_rst_seq extends superClass
endpackage