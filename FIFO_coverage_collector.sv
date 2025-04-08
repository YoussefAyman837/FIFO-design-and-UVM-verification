package FIFO_coverage_collector_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"

class FIFO_cover extends uvm_component;
`uvm_component_utils(FIFO_cover)
uvm_analysis_port #(FIFO_seq_item) cov_export;
uvm_tlm_analysis_fifo #(FIFO_seq_item) cov_fifo;
FIFO_seq_item seq_item;

covergroup g1;
cross seq_item.wr_en,seq_item.rd_en,seq_item.wr_ack;
cross seq_item.wr_en,seq_item.rd_en,seq_item.overflow;
cross seq_item.wr_en,seq_item.rd_en,seq_item.underflow;
cross seq_item.wr_en,seq_item.rd_en,seq_item.almostempty;
cross seq_item.wr_en,seq_item.rd_en,seq_item.almostfull;
cross seq_item.wr_en,seq_item.rd_en,seq_item.full;
cross seq_item.wr_en,seq_item.rd_en,seq_item.empty;

endgroup


    function new(string name="FIFO_cover" , uvm_component parent=null);
        super.new(name,parent);
        g1=new();
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cov_export=new("cov_export",this);
        cov_fifo=new("cov_fifo",this);
        
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            cov_fifo.get(seq_item);
            g1.sample();
        end
    endtask //

endclass //FIFO_cover extends superClass
    
endpackage