

 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /fft_ram_simple_tb/status
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/CLKA
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/ADDRA
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/DINA
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/WEA
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/ENA
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/CLKB
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/ADDRB
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/ENB
      waveform add -signals /fft_ram_simple_tb/fft_ram_simple_synth_inst/bmg_port/DOUTB

console submit -using simulator -wait no "run"
