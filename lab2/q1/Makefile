GHDL = ghdl
FLAGS = "--std=08"

and : 
	@$(GHDL) -a and_gate.vhd and_gate_tb.vhd
	@$(GHDL) -e TestBenchAnd
	@$(GHDL) -r TestBenchAnd --wave=wave.ghw --stop-time=1us

or : 
	@$(GHDL) -a or_gate.vhd or_gate_tb.vhd
	@$(GHDL) -e TestBenchOr
	@$(GHDL) -r TestBenchOr --wave=wave.ghw --stop-time=1us

not : 
	@$(GHDL) -a not_gate.vhd not_gate_tb.vhd
	@$(GHDL) -e TestBenchNot
	@$(GHDL) -r TestBenchNot --wave=wave.ghw --stop-time=1us

mux4x1 :
	@$(GHDL) -a mux4x1.vhd mux4x1_tb.vhd
	@$(GHDL) -e TestBenchMux4x1
	@$(GHDL) -r TestBenchMux4x1 --wave=wave.ghw --stop-time=1us

encoder4x2 :
	@$(GHDL) -a encoder4x2.vhd encoder4x2_tb.vhd
	@$(GHDL) -e TestBenchEncoder4x2
	@$(GHDL) -r TestBenchEncoder4x2 --wave=wave.ghw --stop-time=1us