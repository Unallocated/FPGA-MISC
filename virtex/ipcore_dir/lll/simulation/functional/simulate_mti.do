vlib work
vmap work work



echo "Compiling Core Simulation Models"
vcom -work work ../../../lll.vhd

echo "Compiling Example Design"
vcom -2008 -work work \
../../example_design/lll_sync_block.vhd \
../../example_design/lll_reset_sync.vhd \
../../example_design/lll_tx_elastic_buffer.vhd \
../../example_design/lll_dcm_reset.vhd \
../../example_design/lll_block.vhd \
../../example_design/lll_example_design.vhd

echo "Compiling Test Bench"
vcom -work work -novopt ../stimulus_tb.vhd ../demo_tb.vhd

echo "Starting simulation"
vsim -voptargs="+acc" -t ps work.demo_tb
do wave_mti.do
run -all
