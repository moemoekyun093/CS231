GHDL = ghdl
FLAGS = "--std=08"



decoder4x16 : decoder2x4 not
	@$(GHDL) -a decoder4x16.vhd decoder4x16_tb.vhd
	@$(GHDL) -e TestBenchDECODER4x16
	@$(GHDL) -r TestBenchDECODER4x16 --wave=wave.ghw --stop-time=1us

decoder2x4 : and not
	@$(GHDL) -a decoder2x4.vhd

and :
	@$(GHDL) -a and_gate.vhd

not :
	@$(GHDL) -a not_gate.vhd