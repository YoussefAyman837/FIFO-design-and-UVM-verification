package FIFO_seq_item_package;
import uvm_pkg::*;
`include "uvm_macros.svh"
class FIFO_seq_item extends uvm_sequence_item;  
`uvm_object_utils(FIFO_seq_item)
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
rand logic [FIFO_WIDTH-1:0] data_in;
rand logic  rst_n, wr_en, rd_en;
 logic [FIFO_WIDTH-1:0] data_out;
 logic wr_ack, overflow;
 logic full, empty, almostfull, almostempty, underflow;
 integer RD_EN_ON_DIST,WR_EN_ON_DIST;

    function new(string name="FIFO_seq_item");
        super.new(name);
    endfunction //new()

function string convert2string();
    return $sformatf("rst_n=0b%0b , wr_en=0b%0b , rd_en=0b%0b , data_in=0b%0b ,
     wr_ack=0b%0b , overflow=0b%0b , full=0b%0b , empty=0b%0b , almostfull=0b%0b , almostempty=0b%0b , underflow=0b%0b" ,super.convert2string(), rst_n , wr_en , rd_en, data_in , 
     wr_ack , overflow , full , empty , almostfull , almostempty , underflow);
    
endfunction

        constraint c1{rst_n dist{1:=90 , 0:=10};};
    constraint c2{wr_en dist{1:=WR_EN_ON_DIST , 0:=(100-WR_EN_ON_DIST)};};
    constraint c3{rd_en dist{1:=RD_EN_ON_DIST , 0:=(100-RD_EN_ON_DIST)};};
endclass //className extends superClass
    
endpackage