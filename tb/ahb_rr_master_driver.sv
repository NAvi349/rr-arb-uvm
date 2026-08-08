/*
Description: This is the driver of input. The driver respects the AHB protocol.
*/

class ahb_rr_master_driver extends uvm_driver #(ahb_rr_item);

  `uvm_component_utils(ahb_rr_master_driver)
    int id = 0;
  virtual ahb_rr_if xif;
   
  //uvm_sequence_item tx;
  ahb_rr_item i_tx;
  
  function new(string name = "ahb_rr_master_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual ahb_rr_if)::get(this, "", "ahb_rr_if", xif);
        uvm_config_db#(int)::get(this, "", "agent_id", id);
  endfunction
  
  task run_phase (uvm_phase phase);
    
   `uvm_info("INPUT_DRV", "Starting driver", UVM_LOW)
    
    reset_dut();
    
    forever begin
     `uvm_info("INPUT_DRV", "Getting next item from sequence in input driver", UVM_LOW)
      seq_item_port.get_next_item(i_tx);
      drive_request();
      
      fork
        begin
          while (xif.hgrant === 0) begin
           `uvm_info("INPUT_DRV", "Waiting for grant", UVM_LOW)
            @(posedge xif.clock);
          end
        end
        
        begin
          repeat (100) @(posedge xif.clock);
          `uvm_info("INPUT_DRV", "Grant not got after 100 clock cycles", UVM_LOW)
        end
        
      join_any
      
      disable fork;
      if (xif.hgrant === 1) begin
        drive_address();
        drive_data();
        @(posedge xif.clock);
            xif.hbusreq <= 0;
        
        fork
          begin
            while (xif.hready != 1) begin
              `uvm_info("INPUT_DRV", "Hready not asserted yet", UVM_LOW)
              @(posedge xif.clock);  
            end
          end
          
          begin
            repeat (4) @(xif.clock);
            `uvm_info("INPUT_DRV", "Hready not asserted till timeout", UVM_LOW)
          end
        join_any

      end      

        
      seq_item_port.item_done();
    end
    
  endtask
  
        
  virtual task reset_dut();
    
    `uvm_info("MST_DRV", "Reset driven, initializing DUT inputs", UVM_LOW)
    xif.hwrite  <= 'h0;
    xif.hbusreq <= 'h0;
    xif.haddr   <= 'h0;
    xif.hsize   <= 'h0;
    xif.htrans  <= 'h0;
    xif.hwdata  <= 'h0;
    
    fork 
      begin
        wait (xif.rst_n);
       `uvm_info("MST_DRV", "Reset released", UVM_LOW)
      end
      
      begin
        repeat (20) @(posedge xif.clock);
        `uvm_fatal("MST_DRV", "Initial Reset not released, ending simulation")
      end
    join_any
    

  endtask
  
  virtual task drive_request();
    @(posedge xif.clock);
    xif.hbusreq <= 'b1;
    xif.hlock   <= 'b0;
   `uvm_info("MST_DRV", "Drove bus request", UVM_LOW)
  endtask
  
  virtual task drive_address();
    @(posedge xif.clock);
    xif.haddr  <= i_tx.haddr;
    xif.htrans <= 'b10;
    xif.hwrite <= 1;
    xif.hsize  <= 0;
   `uvm_info("MST_DRV", "Drove bus address", UVM_LOW)
  endtask
  
  virtual task drive_data();
    @(posedge xif.clock);
    xif.hwdata <= i_tx.hwdata;

   `uvm_info("MST_DRV", "Drove bus data", UVM_LOW)
  endtask
 
  endclass: ahb_rr_master_driver
