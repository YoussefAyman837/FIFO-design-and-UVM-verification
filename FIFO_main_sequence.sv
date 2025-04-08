package FIFO_main_sequence_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"

class FIFO_main_seq extends uvm_sequence #(FIFO_seq_item);
FIFO_seq_item main_seq_item;
`uvm_object_utils(FIFO_main_seq)

    function new(string name="FIFO_main_seq");
        super.new(name);
    endfunction //new()

    task body();
    repeat(100)begin
        main_seq_item=FIFO_seq_item::type_id::create("main_seq_item");
        start_item(main_seq_item);
        main_seq_item.wr_en=1;
        main_seq_item.rd_en=1;
        main_seq_item.rst_n=1;
        main_seq_item.data_in=$random;
        finish_item(main_seq_item);
    end
    endtask //


endclass //FIFO_rst_seq extends superClass
endpackage