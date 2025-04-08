package FIFO_monitor_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"
class FIFO_monitor extends uvm_monitor;
`uvm_component_utils(FIFO_monitor)
virtual FIFO_if FIFO_vif;
FIFO_seq_item seq_item;
uvm_analysis_port #(FIFO_seq_item) mon_ap;

    function new(string name="FIFO_monitor" , uvm_component parent=null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_ap=new("mon_ap",this);
    endfunction


    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item=FIFO_seq_item::type_id::create("seq_item");
            @(negedge FIFO_vif.clk);
            seq_item.rst_n=FIFO_vif.rst_n;
            seq_item.wr_en=FIFO_vif.wr_en;
            seq_item.rd_en=FIFO_vif.rd_en;
            seq_item.data_in=FIFO_vif.data_in;
            seq_item.wr_ack=FIFO_vif.wr_ack;
            seq_item.almostempty=FIFO_vif.almostempty;
            seq_item.empty=FIFO_vif.empty;
            seq_item.almostfull=FIFO_vif.almostfull;
            seq_item.full=FIFO_vif.full;
            seq_item.overflow=FIFO_vif.overflow;
            seq_item.underflow=FIFO_vif.underflow;
            mon_ap.write(seq_item);
            `uvm_info("run_phase" , seq_item.convert2string(), UVM_HIGH)
        end
    endtask //
endclass //FIFO_monitor extends superClass
    
endpackage