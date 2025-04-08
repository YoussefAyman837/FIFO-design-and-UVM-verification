vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.FIFO_top_uvm -cover
add wave /FIFO_top_uvm/clk
add wave /FIFO_top_uvm/FIFO_if/*
coverage save -du FIFO FIFO_top_uvm.ucdb -onexit
run -all