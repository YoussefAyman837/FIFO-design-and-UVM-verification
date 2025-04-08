package FIFO_driver_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
import FIFO_config_package::*;

`include "uvm_macros.svh"

class FIFO_driver extends uvm_driver #(FIFO_seq_item);
`uvm_component_utils(FIFO_driver)
virtual FIFO_if FIFO_vif;
FIFO_seq_item stim_seq_item;
FIFO_config FIFO_cfg;

    function new(string name="FIFO_driver" , uvm_component parent =null);
        super.new(name , parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(FIFO_config)::get(this,"" , "CFG" , FIFO_cfg))
        `uvm_fatal("build_phase" , "couldnt find config object ")
        
    endfunction


    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            stim_seq_item=FIFO_seq_item::type_id::create("stim_seq_item");
            seq_item_port.get_next_item(stim_seq_item);
            FIFO_vif.rst_n=stim_seq_item.rst_n;
            FIFO_vif.wr_en=stim_seq_item.wr_en;
            FIFO_vif.rd_en=stim_seq_item.rd_en;
            FIFO_vif.data_in=stim_seq_item.data_in;
            @(negedge FIFO_vif.clk);
            seq_item_port.item_done();
            `uvm_info("run_phase" , stim_seq_item.convert2string() , UVM_HIGH)
        end
    endtask //
endclass //FIFO_driver extends uvm_driver
endpackage