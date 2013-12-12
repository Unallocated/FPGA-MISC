view structure
view signals
view wave

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {System Signals}
add wave -noupdate -format logic /demo_tb/reset
add wave -noupdate -format logic /demo_tb/gtx_clk
add wave -noupdate -format logic /demo_tb/signal_detect
add wave -noupdate -divider {Management I/F}
add wave -noupdate -format logic /demo_tb/mdc
add wave -noupdate -format logic /demo_tb/mdio_i
add wave -noupdate -format logic /demo_tb/mdio_o
add wave -noupdate -format logic /demo_tb/mdio_t
add wave -noupdate -format logic -binary /demo_tb/phyad
add wave -noupdate -format logic -binary /demo_tb/status_vector
add wave -noupdate -divider {Tx GMII}
add wave -noupdate -format logic -hex /demo_tb/gmii_txd
add wave -noupdate -format logic /demo_tb/gmii_tx_en
add wave -noupdate -format logic /demo_tb/gmii_tx_er
add wave -noupdate -divider {Rx GMII}
add wave -noupdate -format logic -hex /demo_tb/gmii_rxd
add wave -noupdate -format logic /demo_tb/gmii_rx_dv
add wave -noupdate -format logic /demo_tb/gmii_rx_er
add wave -noupdate -divider {Tx TBI}
add wave -noupdate -format logic /demo_tb/pma_tx_clk
add wave -noupdate -format logic -hex /demo_tb/tx_code_group
add wave -noupdate -divider {Rx TBI}
add wave -noupdate -format logic /demo_tb/pma_rx_clk0
add wave -noupdate -format logic -hex /demo_tb/rx_code_group
add wave -noupdate -divider {Auto-Neg control}
add wave -noupdate -format logic -hex /demo_tb/link_timer_value
add wave -noupdate -format logic /demo_tb/an_interrupt
add wave -noupdate -divider {Tx Monitor}
add wave -noupdate -format logic /demo_tb/stimulus/mon_tx_clk
add wave -noupdate -format logic -hex /demo_tb/stimulus/tx_pdata
add wave -noupdate -format logic /demo_tb/stimulus/tx_is_k
add wave -noupdate -divider {Rx Stimulus}
add wave -noupdate -format logic /demo_tb/stimulus/stim_rx_clk
add wave -noupdate -format logic /demo_tb/stimulus/rx_even
add wave -noupdate -format logic -hex /demo_tb/stimulus/rx_pdata
add wave -noupdate -format logic /demo_tb/stimulus/rx_is_k
add wave -noupdate -format logic /demo_tb/stimulus/rx_rundisp_pos
add wave -noupdate -divider {Test semaphores}
add wave -noupdate -format logic /demo_tb/configuration_finished
add wave -noupdate -format logic /demo_tb/tx_monitor_finished
add wave -noupdate -format logic /demo_tb/rx_monitor_finished
add wave -noupdate -format logic /demo_tb/simulation_finished
TreeUpdate [SetDefaultTree]
