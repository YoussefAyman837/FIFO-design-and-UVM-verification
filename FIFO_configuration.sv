package FIFO_config_package;
import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_config extends uvm_object;
`uvm_object_utils(FIFO_config)
virtual FIFO_if FIFO_vif;
    function new(string name= "FIFO_config" );
        super.new(name);
    endfunction //new()
endclass //FIFO_config extends superClass
    
endpackage