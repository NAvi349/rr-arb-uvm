module arbiter_tb ();

  logic clk;
  logic rst;
  
  logic [3:0] req;
  logic [3:0] ack;
  
  logic [3:0] gnt;
  logic       gnt_valid;
  
  logic [1:0] gnt_enc;
  
  arbiter uut (.clk(clk),
               .rst(rst),
               .request(req),
               .acknowledge(ack),
               .grant(gnt),
               .grant_valid(gnt_valid),
               .grant_encoded(gnt_enc)
              );
  
  
  
  initial begin
    rst = 1;
    clk = 0;
    req = 0;
    ack = 0;
    #10ns;
    rst = 0;
    
    repeat (2) @(posedge clk);
    #1ns
    req <= 4'b1111;
    
    repeat (2) @(posedge clk);
    #5ns;
    ack[0] <= 1;
    
    repeat (2) @(posedge clk);
    #5ns
    req[1] <= 1;
    ack[1] <= 1;
    
    #100ns
    
    $finish;    
    
  end
  
  initial begin
    forever begin
    #5ns clk = ~clk;
    end
    

  end
  
  

    always @(posedge clk) begin
      
      if (gnt[0] & gnt_valid) begin
        req[0] <= 0;
        ack[0] <= 0;
      end
      
      if (gnt[1] & gnt_valid) begin
        req[1] <= 0;
        ack[1] <= 0;
      end
      
      if (gnt[2] & gnt_valid) begin
        req[2] <= 0;
        ack[2] <= 0;
      end
      
      if (gnt[3] & gnt_valid) begin
        req[3] <= 0;
        ack[3] <= 0;
      end

    
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
endmodule
