// Have a seperate interface for each master

interface ahb_rr_if0(input clock, input rst_n);

  logic hbusreq;
  logic hlock;
  logic [31:0] haddr0;
  
  logic [ 1:0] htrans0;
  
  logic        hwrite0;
  
  logic [ 2:0] hsize0;
  
  logic [31:0] hwdata0;
  
  logic hgrant;
  logic [ 1:0] hmaster;
  logic        hmastlock;
  logic [31:0] hrdata;
  logic        hready;
  logic [ 1:0] hresp;
    
  
endinterface

interface ahb_rr_if1(input clock, input rst_n);

  logic   hbusreq;
  logic   hlock;
  logic [31:0] haddr1;
  
  logic [ 1:0] htrans1;

  logic        hwrite1;
  
  logic [ 2:0] hsize1;

  logic [31:0] hwdata1;

  
  logic hgrant;
  logic [ 1:0] hmaster;
  logic        hmastlock;
  logic [31:0] hrdata;
  logic        hready;
  logic [ 1:0] hresp;
    
  
endinterface

interface ahb_rr_if2(input clock, input rst_n);

  logic   hbusreq;
  logic   hlock;
  logic [31:0] haddr2;

  logic [ 1:0] htrans2;

  logic        hwrite2;

  logic [ 2:0] hsize2;

  logic [31:0] hwdata2;

  logic hgrant;
  logic [ 1:0] hmaster;
  logic        hmastlock;
  logic [31:0] hrdata;
  logic        hready;
  logic [ 1:0] hresp;
    
  
endinterface

interface ahb_rr_if3(input clock, input rst_n);

  logic  hbusreq;
  logic  hlock;
  logic [31:0] haddr3;

  logic [ 1:0] htrans3;
  
  logic        hwrite3;

  logic [ 2:0] hsize3;
 
  logic [31:0] hwdata3;
  
  logic  hgrant;
  logic [ 1:0] hmaster;
  logic        hmastlock;
  logic [31:0] hrdata;
  logic        hready;
  logic [ 1:0] hresp;
    
endinterface

interface ahb_rr_if(input clock, input rst_n);

  logic hbusreq;
  logic hlock;
  logic [31:0] haddr;
  
  logic [ 1:0] htrans;
  
  logic        hwrite;
  
  logic [ 2:0] hsize;
  
  logic [31:0] hwdata;
  
  logic hgrant;
  logic [ 1:0] hmaster;
  logic        hmastlock;
  logic [31:0] hrdata;
  logic        hready;
  logic [ 1:0] hresp;
    
  
endinterface
