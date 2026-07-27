class ahb_rr_item extends uvm_sequence_item;
  
  logic  [3:0] hbusreq;
  logic  [3:0] hlock;
  logic [31:0] haddr;
  
  logic [ 1:0] htrans;

  logic        hwrite;
 
  logic [ 2:0] hsize;
  
  logic [31:0] hwdata;
  
  logic [ 3:0] hgrant;
  logic [ 1:0] hmaster;
  logic        hmastlock;
  logic [31:0] hrdata;
  logic        hready;
  logic [ 1:0] hresp;

  
  `uvm_object_utils(ahb_rr_item)
  
  function new(string name="ahb_rr_item");
    super.new(name);
  endfunction
  
  function string convert2string_with_index(int i = 0);
    string s;
    s = super.convert2string();
    s = {s, $sformatf("\n===== AHB RR Transaction =====")};
    s = {s, $sformatf("\n  hbusreq = 0b%4b | hlock = 0b%4b", hbusreq, hlock)};
    
    s = {s, $sformatf("\n  --- Master %d ---", i)};
    s = {s, $sformatf("\n    haddr%d=%0h htrans%d=%0b hwrite%d=%0b hsize%d=%0b hwdata%d=%0h", i, haddr, i, htrans, i, hwrite, i, hsize, i, hwdata)};
        
    s = {s, $sformatf("\n  --- Arbiter/Slave Response ---")};
    s = {s, $sformatf("\n    hgrant=%0b hmaster=%0d hmastlock=%0b", hgrant, hmaster, hmastlock)};
    s = {s, $sformatf("\n    hrdata=%0h hready=%0b hresp=%0b", hrdata, hready, hresp)};
    s = {s, $sformatf("\n================================")};
    return s;
  endfunction
   
  
endclass
