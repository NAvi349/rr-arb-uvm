/*
Description: This is the monitor for master input/slave output.
There are two monitors here for both input (master) and output (slave).

Implementation plan:
1. Analysis port for scoreboard
2. get inputs of dut task
3. forever loop is used for monitor as it will act on
4. It gets the signals from dut and send to scoreboard through the analysis port

*/


class ahb_rr_master_monitor extends uvm_monitor;
  `uvm_component_utils(ahb_rr_master_monitor)
  
  virtual ahb_rr_if ahb_xif;
  
  uvm_analysis_port #(ahb_rr_item) dut_tx_out;
  
  ahb_rr_item ahb_tx_in;
  
  function new(string name = "ahb_rr_master_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dut_tx_out = new("dut_m_tx", this);
    uvm_config_db#(virtual ahb_rr_if)::get(this, "", "ahb_rr_if", ahb_xif);
  endfunction
  
  
  task run_phase(uvm_phase phase);
    
    fork 
    
      begin
        forever begin
          //create seq item
          ahb_tx_in = ahb_rr_item::type_id::create("ahb_tx_in", this);
          get_dut_signals();
          get_dut_outputs();
          `uvm_info("AHB_MON", $sformatf("%s", ahb_tx_in.convert2string_with_index(0)), UVM_HIGH)
          dut_tx_out.write(ahb_tx_in);
        end
      end
      
    join
    
  endtask
  
  task get_dut_signals();
    @(posedge ahb_xif.clock);
    ahb_tx_in.hbusreq <= ahb_xif.hbusreq;
    ahb_tx_in.hlock   <= ahb_xif.hlock;
    ahb_tx_in.haddr   <= ahb_xif.haddr;
    ahb_tx_in.htrans  <= ahb_xif.htrans;
    ahb_tx_in.hwrite  <= ahb_xif.hwrite;
    ahb_tx_in.hsize   <= ahb_xif.hsize;
    ahb_tx_in.hwdata  <= ahb_xif.hwdata;
  endtask
  
  task get_dut_outputs();
    @(posedge ahb_xif.clock);
    ahb_tx_in.hgrant  <= ahb_xif.hgrant;
    ahb_tx_in.hrdata  <= ahb_xif.hrdata;
    ahb_tx_in.hready  <= ahb_xif.hready;
    ahb_tx_in.hresp   <= ahb_xif.hresp;
 endtask 
  
endclass
