interface FIFO_if(clk);
input clk;
logic [15:0] data_in;
logic  rst_n, wr_en, rd_en;
logic [15:0] data_out;
logic wr_ack, overflow;
logic full, empty, almostfull, almostempty, underflow;


modport MONITOR( input clk , rst_n , wr_en , rd_en , data_in , data_out , wr_ack , overflow , full ,empty , almostempty , almostfull , underflow);

modport DUT( input clk , rst_n , wr_en , rd_en , data_in ,
                output data_out , wr_ack , overflow , full ,empty , almostempty , almostfull , underflow);

modport TEST( output rst_n , wr_en , rd_en , data_in ,
                input clk, data_out , wr_ack , overflow , full ,empty , almostempty , almostfull , underflow);

endinterface //FIFO_if