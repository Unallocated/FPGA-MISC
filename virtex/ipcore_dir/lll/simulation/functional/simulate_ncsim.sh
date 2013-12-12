#!/bin/sh
mkdir work

echo "Compiling Core Simulation Models"
ncvhdl -v93 -work work ../../../lll.vhd

echo "Compiling Example Design"
ncvhdl -v93 -work work \
../../example_design/lll_sync_block.vhd \
../../example_design/lll_reset_sync.vhd \
../../example_design/lll_tx_elastic_buffer.vhd \
../../example_design/lll_dcm_reset.vhd \
../../example_design/lll_block.vhd \
../../example_design/lll_example_design.vhd

echo "Compiling Test Bench"
ncvhdl -v93 -work work ../stimulus_tb.vhd ../demo_tb.vhd

echo "Elaborating design"
ncelab -access +rw work.demo_tb:behav

echo "Starting simulation"
ncsim -gui work.demo_tb:behav -input @"simvision -input wave_ncsim.sv"
