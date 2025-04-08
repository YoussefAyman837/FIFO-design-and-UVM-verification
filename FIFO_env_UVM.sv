package FIFO_env_package;
import uvm_pkg::*;
import FIFO_coverage_collector_package::*;
import FIFO_scoreboard_package::*;
import FIFO_agent_package::*;
`include "uvm_macros.svh"
class FIFO_env extends uvm_env;
FIFO_agent agt;
FIFO_scoreboard sb;
FIFO_cover cov;
`uvm_component_utils(FIFO_env)
    function new(string name="FIFO_env" , uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt=FIFO_agent::type_id::create("agt",this);
        sb=FIFO_scoreboard::type_id::create("sb",this);
        cov=FIFO_cover::type_id::create("cov",this);
    endfunction
function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.aport.connect(sb.sb_export);
    agt.aport.connect(cov.cov_export);
    
endfunction

endclass //FIFO_env extends uvm_enviroment


endpackage