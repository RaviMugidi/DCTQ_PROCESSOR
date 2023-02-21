`include “ram_rc.v” 
module dualram(
clk, // I/O ports. 
 pci_clk, 
 rnw, 
 be, 
 ra, 
 wa, 
 di, 
 din_valid, 
 do 
 ) ; 
 input clk ; // System clock. 
 input pci_clk ; // PCI clock for inputting data, di 
 // synchronously. 
 input rnw ; // Sets one RAM in write only mode 
 // and the other RAM in read only mode. 
 input din_valid ; // Data in (di) valid. 
 input [7:0] be ; // Byte enable. 
 input [2:0] ra, wa ; // Read/write address. 
 input [63:0] di ; // Data input and 
 output [63:0] do ; // Data output of dual RAM. 
 wire switch_bank; // Declare net outputs. 
 wire [63:0] do1 ; 
 wire [63:0] do2 ; 
 wire [63:0] do_next ; 
 
 reg [63:0] do; // Declare registered outputs. 
reg rnw_delay ; 
assign switch_bank = ~rnw; 
ram_rc ram1 ( .clk(clk), // Instantiate the first RAM. 
// ‘rc’ stands for write row-wise and 
.pci_clk(pci_clk), // read column-wise. 
 .rnw(rnw), // If rnw =1, ram1 is configured for 
 .be(be), // write mode. Otherwise, read mode. 
 .ra(ra), 
 .wa(wa), 
 .di(di), 
 .din_valid(din_valid), 
 .do(do1) 
 ) ; 
 
ram_rc ram2( .clk(clk), // Instantiate the second RAM. 
 .pci_clk(pci_clk), 
 .rnw(switch_bank), // If rnw =1, ram2 is configured for 
.be(be), // read mode. Otherwise, write mode. 
 .ra(ra), 
 .wa(wa), 
 .di(di), 
 .din_valid(din_valid), 
 .do(do2) 
 ) ; 
assign do_next = (rnw_delay) ? do2 : do1 ; // Read ram2 or ram1. 
always @ (posedge clk) 
begin 
rnw_delay <= rnw ; // Delay the rnw signal by one clock. 
 do <= do_next ; // Register the selected RAM output. 
end 
 


endmodule
