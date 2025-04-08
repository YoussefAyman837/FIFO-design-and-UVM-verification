package FIFO_scoreboard_package;
import uvm_pkg::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"

class FIFO_scoreboard extends uvm_scoreboard ;
`uvm_component_utils(FIFO_scoreboard)
uvm_analysis_export #(FIFO_seq_item) sb_export;
uvm_tlm_analysis_fifo #(FIFO_seq_item) sb_fifo;
FIFO_seq_item seq_item;
bit [15:0]out_ref;
bit [15:0] queue[$];



    function new(string name="FIFO_scoreboard" , uvm_component parent=null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sb_export=new("sb_export" , this);
        sb_fifo=new("sb_fifo" , this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            sb_fifo.get(seq_item);
            ref_model(seq_item);
            if(seq_item.data_out != out_ref)begin
                `uvm_error("run_phase" , "comparison failed")
            end
        end
    endtask //

    task ref_model(FIFO_seq_item seq_item);
        if(seq_item.wr_en)begin
            queue.push_front(seq_item.data_in);
        end
        else if(seq_item.rd_en)begin
            out_ref=queue.pop_front();
        end

    endtask //

endclass //FIFO_scoreboard extends superClass
endpackage