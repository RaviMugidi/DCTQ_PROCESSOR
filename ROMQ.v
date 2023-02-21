module romq(clk,a,d);
input clk; // Declare I/Os. 
 input [5:0] a; // This is the 6-bit address and 
 output [7:0] d; // data output of ROM. 
 reg [7:0] d; // Declare as the register. 
 wire [7:0] d_next ; // Declare as the wire. 
 reg [63:0] mem [7:0] ; // ROM organized as 8x64 
reg [7:0] byte_data [7:0] ; // bits, but read byte-by-byte. 
wire [63:0] mem_data ; // Declare ‘assign’ outputs as wire. 
wire [63:0] loc0 ; 
wire [63:0] loc1 ; 
 wire [63:0] loc2 ; 
 wire [63:0] loc3 ; 
 wire [63:0] loc4 ; 
 wire [63:0] loc5 ; 
 wire [63:0] loc6 ; 
 wire [63:0] loc7 ; 
 assign loc0 = 64'hFF806C5D4F4C473C ; 
 assign loc1 = 64'h80805D554C473C37 ; 
 assign loc2 = 64'h6C5D4F4C473C3C36 ; 
 assign loc3 = 64'h5D5D4F4C473C3733 ; 
 assign loc4 = 64'h5D4F4C47403B332B ; 
 assign loc5 = 64'h4F4C47403B332B23 ; 
 assign loc6 = 64'h4F4C473C362D251E ; 
 assign loc7 = 64'h4C473B362D251E19 ; 
 always @ (loc0 or loc1 or loc2 or loc3 or loc4 or loc5 or loc6 or loc7) 
begin 
 // Bytes from each row is accessed in a raster scan order (MSB first, etc). 
 mem [0] = loc0 ; 
 mem [1] = loc1 ; 
 mem [2] = loc2 ; 
 mem [3] = loc3 ; 
 mem [4] = loc4 ; 
 mem [5] = loc5 ; 
 mem [6] = loc6 ; 
 mem [7] = loc7 ; 
end
always @ (mem_data) 
begin 
byte_data [0] = mem_data [63:56] ; // MSB is assigned as 
byte_data [1] = mem_data [55:48] ; // LSB. 
byte_data [2] = mem_data [47:40] ; 
byte_data [3] = mem_data [39:32] ; 
byte_data [4] = mem_data [31:24] ; 
byte_data [5] = mem_data [23:16] ; 
byte_data [6] = mem_data [15:8] ; 
byte_data [7] = mem_data [7:0] ; // LSB is assigned as MSB. 
end 
assign mem_data = mem [a[5:3]] ; // Get 64 bits data. 
assign d_next = byte_data [a[2:0]] ; // Get byte data. 
always @ (posedge clk) 
 d <= d_next ; // Register byte data. 



endmodule
