////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////
module FIFO(FIFO_if.DUT fif);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;

 
localparam max_fifo_addr = $clog2(FIFO_DEPTH);

logic [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

logic [max_fifo_addr-1:0] wr_ptr, rd_ptr;
logic [max_fifo_addr:0] count;

always @(posedge fif.clk or negedge fif.rst_n) begin
	if (!fif.rst_n) begin
		wr_ptr <= 0;
		fif.wr_ack <=0; 
		fif.overflow<=0;                                
	end
	else if (fif.wr_en && count < FIFO_DEPTH) begin
		mem[wr_ptr] <= fif.data_in;
		fif.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;                               //overflow handling
	end
	else if(fif.wr_en && fif.full) begin 
		fif.overflow<=1;
	end
	else begin
		fif.overflow<=0;
		fif.wr_ack<=0;
	end
end

always @(posedge fif.clk or negedge fif.rst_n) begin
	if (!fif.rst_n) begin
		rd_ptr <= 0;
		fif.underflow<=0;
	end
	else if (fif.rd_en && count != 0) begin
		fif.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
	else if(fif.rd_en && fif.empty)begin
		fif.underflow<=1;
	end                                                       //underflow handling
	else begin
		fif.underflow<=0; 
	end
end

always @(posedge fif.clk or negedge fif.rst_n) begin
	if (!fif.rst_n) begin
		count <= 0;
	end
	else begin
		if	( ({fif.wr_en, fif.rd_en} == 2'b10) && !fif.full) 
			count <= count + 1;
		else if ( ({fif.wr_en, fif.rd_en} == 2'b01) && !fif.empty)
			count <= count - 1;
	end
end

assign fif.full = (count == FIFO_DEPTH)? 1 : 0;
assign fif.empty = (count == 0)? 1 : 0;
assign fif.almostfull = (count == FIFO_DEPTH-1)? 1 : 0;   //FIFO_DEPTH -2 is wrong
assign fif.almostempty = (count == 1)? 1 : 0;


assert property(@(posedge fif.clk)(fif.wr_en && fif.full |=> fif.overflow));

assert property(@(posedge fif.clk)(fif.rd_en &&fif.empty |=>fif.underflow));     

assert property (@(posedge fif.clk) disable iff(!fif.rst_n) (fif.wr_en && fif.almostfull && !fif.rd_en) |=> fif.full); 
assert property (@(posedge fif.clk) disable iff(!fif.rst_n) (fif.almostempty && fif.rd_en && !fif.wr_en) |=> fif.empty);
assert property(@(posedge fif.clk)((fif.wr_en && !fif.full) |=> fif.wr_ack));

assert property(@(posedge fif.clk)(count==FIFO_DEPTH) |-> fif.full);

assert property(@(posedge fif.clk)(count==FIFO_DEPTH-1) |-> fif.almostfull);

assert property(@(posedge fif.clk)(count==0) |-> fif.empty);

assert property(@(posedge fif.clk)(count==1) |-> fif.almostempty);

endmodule