/*
Description: AHB Round robin arbter environment. This is a multi-agent env for master and slave.


*/

class ahb_rr_env extends uvm_env;
  `uvm_component_utils(ahb_rr_env)
  
  parameter int NUM_MAST = 4;
  
  ahb_rr_master_agent ahb_m_agt[NUM_MAST]; // agent for the masters  
  ahb_rr_output_agent ahb_o_agt;           // agent for the output status signals
  ahb_rr_scoreboard ahb_scbd;              // scoreboard
  ahb_rr_reset_agent ahb_rr_agt;           // reset agent
  
  
  function new(string name = "ahb_rr_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ahb_rr_agt  = ahb_rr_reset_agent::type_id::create("ahb_rr_agt", this);
    
    for (int i = 0; i < NUM_MAST; i++) begin
      ahb_m_agt[i] = ahb_rr_master_agent::type_id::create($sformatf("ahb_m[%0d]_agt", i), this);
      uvm_config_db#(int)::set(this, $sformatf("ahb_m[%0d]_agt.*", i), "agent_id", i);
    end
    
    ahb_o_agt   = ahb_rr_output_agent::type_id::create("ahb_o_agt", this);
    
    ahb_scbd    = ahb_rr_scoreboard::type_id::create("ahb_scbd", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.build_phase(phase);
    ahb_m_agt[0].ahb_rr_m_mon.dut_tx_out.connect(ahb_scbd.tx_in_fifo0.analysis_export);
    ahb_m_agt[1].ahb_rr_m_mon.dut_tx_out.connect(ahb_scbd.tx_in_fifo1.analysis_export);
    ahb_m_agt[2].ahb_rr_m_mon.dut_tx_out.connect(ahb_scbd.tx_in_fifo2.analysis_export);
    ahb_m_agt[3].ahb_rr_m_mon.dut_tx_out.connect(ahb_scbd.tx_in_fifo3.analysis_export);
    //ahb_o_agt.ahb_o_mon.dut_m_tx_out.connect(ahb_scbd.tx_out_fifo.analysis_export);
  endfunction
  
  
  
endclass
  
