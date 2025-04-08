package FIFO_agent_package;
import uvm_pkg::*;
import FIFO_config_package::*;
import FIFO_monitor_package::*;
import FIFO_driver_package::*;
import FIFO_sequencer_package::*;
import FIFO_seq_item_package::*;
`include "uvm_macros.svh"

class FIFO_agent extends uvm_agent;
`uvm_component_utils(FIFO_agent)
uvm_analysis_port #(FIFO_seq_item) aport;
FIFO_driver drv;
FIFO_monitor mon;
FIFO_sequencer seq;
FIFO_config FIFO_cfg;
    function new(string name="FIFO_agent" , uvm_component parent=null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(FIFO_config)::get(this,"" , "CFG" , FIFO_cfg))
        `uvm_fatal("build_phase" , "unable to get config object " )
        aport=new("aport",this);
        drv=FIFO_driver::type_id::create("drv",this);
        mon=FIFO_monitor::type_id::create("mon",this);
        seq=FIFO_sequencer::type_id::create("seq",this);
        
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.FIFO_vif=FIFO_cfg.FIFO_vif;
        mon.FIFO_vif=FIFO_cfg.FIFO_vif;
        drv.seq_item_port.connect(seq.seq_item_export);
        mon.mon_ap.connect(aport);
    endfunction

endclass //FIFO_agent extends uvm_agent
    
endpackage