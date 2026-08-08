`include "uvm_macros.svh"
import uvm_pkg::*;

`include "ahb_rr_if.sv"
`include "ahb_rr_item.sv"  
`include "ahb_rr_seq_lib.sv"
`include "ahb_rr_master_driver.sv"
`include "ahb_rr_master_monitor.sv"
`include "ahb_rr_output_monitor.sv"
`include "ahb_rr_scoreboard.sv"
`include "ahb_rr_reset_agent.sv"
`include "ahb_rr_master_agent.sv"
`include "ahb_rr_output_agent.sv"
`include "ahb_rr_env.sv"
`include "ahb_rr_base_test.sv"
`include "ahb_rr_write_read_test.sv"

module testbench;
    
  bit clk;
  bit rst_n;
  genvar i;  
  
  ahb_rr_rst_if ahb_rst_xif(.clock(clk));
  ahb_rr_if ahb_xif0(.clock(clk));
  ahb_rr_if ahb_xif1(.clock(clk));
  ahb_rr_if ahb_xif2(.clock(clk));
  ahb_rr_if ahb_xif3(.clock(clk));
  
  assign rst_n = ahb_rst_xif.rst_n;
  
  assign ahb_xif0.rst_n = rst_n;
  assign ahb_xif1.rst_n = rst_n;
  assign ahb_xif2.rst_n = rst_n;
  assign ahb_xif3.rst_n = rst_n;
  
  //ahb_rr_if ahb_sts_if(.clock(clk), .rst_n(rst_n));
  
  ahb_top uut(.HCLK(clk),
              .HRESETn(ahb_rst_xif.rst_n),
              .HBUSREQ({ahb_xif3.hbusreq, ahb_xif2.hbusreq, ahb_xif1.hbusreq, ahb_xif0.hbusreq}),
              .HLOCK({ahb_xif3.hlock, ahb_xif2.hlock, ahb_xif1.hlock, ahb_xif0.hlock}),
              .HADDR0(ahb_xif0.haddr),
              .HADDR1(ahb_xif1.haddr),
              .HADDR2(ahb_xif2.haddr),
              .HADDR3(ahb_xif3.haddr),
              .HTRANS0(ahb_xif0.htrans),
              .HTRANS1(ahb_xif1.htrans),
              .HTRANS2(ahb_xif2.htrans),
              .HTRANS3(ahb_xif3.htrans),
              .HWRITE0(ahb_xif0.hwrite),
              .HWRITE1(ahb_xif1.hwrite),
              .HWRITE2(ahb_xif2.hwrite),
              .HWRITE3(ahb_xif3.hwrite),
              .HSIZE0(ahb_xif0.hsize),
              .HSIZE1(ahb_xif1.hsize),
              .HSIZE2(ahb_xif2.hsize),
              .HSIZE3(ahb_xif3.hsize),
              .HWDATA0(ahb_xif0.hwdata),
              .HWDATA1(ahb_xif1.hwdata),
              .HWDATA2(ahb_xif2.hwdata),
              .HWDATA3(ahb_xif3.hwdata),
              .HGRANT({ahb_xif3.hgrant, ahb_xif2.hgrant, ahb_xif1.hgrant, ahb_xif0.hgrant}),
              .HMASTER(ahb_xif0.hmaster),
              .HMASTLOCK(),
              .HRDATA(ahb_xif0.hrdata),
              .HREADY(ahb_xif0.hready),
              .HRESP(ahb_xif0.hresp)
             );

  initial begin
    uvm_config_db#(virtual ahb_rr_rst_if)::set(null, "uvm_test_top.ahb_rr_env.*", "ahb_rr_rst_if", ahb_rst_xif);
    uvm_config_db#(virtual ahb_rr_if)::set(null, "uvm_test_top.ahb_rr_env.ahb_m[0]_agt.*", "ahb_rr_if", ahb_xif0);
    uvm_config_db#(virtual ahb_rr_if)::set(null, "uvm_test_top.ahb_rr_env.ahb_m[1]_agt.*", "ahb_rr_if", ahb_xif1);
    uvm_config_db#(virtual ahb_rr_if)::set(null, "uvm_test_top.ahb_rr_env.ahb_m[2]_agt.*", "ahb_rr_if", ahb_xif2);
    uvm_config_db#(virtual ahb_rr_if)::set(null, "uvm_test_top.ahb_rr_env.ahb_m[3]_agt.*", "ahb_rr_if", ahb_xif3);
    run_test("ahb_rr_write_read_test");
    
  end
  
  
  
  initial begin
    clk <= 0;
    //rst_n <= 0;
    
    //#20ns;
    
    //$display("reset released from testbench top");
    //rst_n <= 1;

    
    //#50ns;
    //$finish;
  end
 
  
  initial begin
        
        forever #5ns clk = ~clk;
    
  end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
