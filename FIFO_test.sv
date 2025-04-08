package FIFO_test_package;
import uvm_pkg::*;
import FIFO_env_package::*;
import FIFO_sequence_package::*;
import FIFO_rst_sequence_package::*;
import FIFO_main_sequence_package::*;
import FIFO_rd_sequence_package::*;
import FIFO_config_package::*;
import FIFO_sequencer_package::*;
`include "uvm_macros.svh"

class FIFO_test extends uvm_test;
`uvm_component_utils(FIFO_test)
FIFO_env env;
virtual FIFO_if FIFO_vif;
FIFO_rd_seq rd_seq;
FIFO_wr_seq wr_seq;
FIFO_rst_seq rst_seq;
FIFO_main_seq main_seq;
FIFO_config cfg;

    function new(string name="FIFO_test" , uvm_component parent=null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg=FIFO_config::type_id::create("cfg",this);
        env=FIFO_env::type_id::create("env" , this);
        rd_seq=FIFO_rd_seq::type_id::create("rd_seq" , this);
        wr_seq=FIFO_wr_seq::type_id::create("wr_seq",this);
        rst_seq=FIFO_rst_seq::type_id::create("rst_seq" , this);
        main_seq=FIFO_main_seq::type_id::create("main_seq" , this);

        if(!uvm_config_db #(virtual FIFO_if)::get(this , "" , "FIFO_if" ,cfg.FIFO_vif))
        `uvm_fatal("build_phase" , "couldnt get interface" );
        uvm_config_db #(FIFO_config)::set(this,"*" , "CFG" , cfg);

    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        rst_seq.start(env.agt.seq);

        
        wr_seq.start(env.agt.seq);
       
        rd_seq.start(env.agt.seq);

       
        main_seq.start(env.agt.seq);
        
        rd_seq.start(env.agt.seq);

        phase.drop_objection(this);


    endtask //
endclass //FIFO_test extends uvm_test
    
endpackage