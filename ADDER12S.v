module adder12s(
clk, 
n0, 
n1, 
n2, 
n3, 
n4, 
n5, 
n6, 
n7, 
sum 
) ;
input clk ; 
input [11:0] n0 ; 
input [11:0] n1 ; 
input [11:0] n2 ; 
input [11:0] n3 ; 
input [11:0] n4 ; 
input [11:0] n5 ; 
input [11:0] n6 ; 
input [11:0] n7 ; 
output [14:0] sum ;
wire [7:0] s00_lsb ; 
wire [7:0] s01_lsb ; 
wire [7:0] s02_lsb ; 
wire [7:0] s03_lsb ; 
wire [5:0] s00_msb ; 
wire [5:0] s01_msb ; 
wire [5:0] s02_msb ; 
wire [5:0] s03_msb ; 
wire [7:0] s10_lsb ; 
wire [7:0] s11_lsb ; 
wire [6:0] s10_msb ; 
wire [6:0] s11_msb ; 
wire [7:0] s20_lsb ; 
reg [11:7] n0_reg1 ; 
reg [11:7] n1_reg1 ; 
reg [11:7] n2_reg1 ; 
reg [11:7] n3_reg1 ; 
reg [11:7] n4_reg1 ; 
reg [11:7] n5_reg1 ; 
reg [11:7] n6_reg1 ; 
reg [11:7] n7_reg1 ; 
reg [7:0] s00_lsbreg1 ; 
reg [7:0] s01_lsbreg1 ; 
reg [7:0] s02_lsbreg1 ; 
reg [7:0] s03_lsbreg1 ; 
reg [5:0] s00_msbreg2 ; 
reg [5:0] s01_msbreg2 ; 
reg [5:0] s02_msbreg2 ; 
reg [5:0] s03_msbreg2 ; 
reg [6:0] s00_lsbreg2 ; 
reg [6:0] s01_lsbreg2 ; 
reg [6:0] s02_lsbreg2 ; 
reg [6:0] s03_lsbreg2 ; 
reg [7:0] s10_lsbreg3 ; 
reg [7:0] s11_lsbreg3 ; 
reg [5:0] s00_msbreg3 ;
reg [5:0] s01_msbreg3 ; 
reg [5:0] s02_msbreg3 ; 
reg [5:0] s03_msbreg3 ; 
reg [6:0] s10_lsbreg4 ; 
reg [6:0] s11_lsbreg4 ; 
reg [6:0] s10_msbreg4 ; 
reg [6:0] s11_msbreg4 ; 
reg [6:0] s10_msbreg5 ; 
reg [6:0] s11_msbreg5 ; 
reg s20_lsbreg5cy ; 
reg [6:0] s20_lsbreg5 ; 
assign s00_lsb[7:0] = n0[6:0]+n1[6:0] ; 
// Add lsb first - s00_lsb[7] is the carry 
assign s01_lsb[7:0] = n2[6:0]+n3[6:0] ; 
// n0-n7 lsb need not be registered since addition is already carried out here. 
assign s02_lsb[7:0] = n4[6:0]+n5[6:0] ; 
assign s03_lsb[7:0] = n6[6:0]+n7[6:0] ; 
always @ (posedge clk) 
// Pipeline 1: clk (1). Register msb to continue 
// addition of msb. 
begin 
 n0_reg1[11:7] <= n0[11:7] ; 
 // Preserve all inputs for msb addition during the clk(2). 
 n1_reg1[11:7] <= n1[11:7] ; 
 n2_reg1[11:7] <= n2[11:7] ; 
 n3_reg1[11:7] <= n3[11:7] ; 
 n4_reg1[11:7] <= n4[11:7] ; 
 n5_reg1[11:7] <= n5[11:7] ; 
 n6_reg1[11:7] <= n6[11:7] ; 
 n7_reg1[11:7] <= n7[11:7] ; 
 s00_lsbreg1[7:0] <= s00_lsb[7:0] ; 
// Preserve all lsb sum. s00_lsbreg1[7] is the registered carry from lsb addition. 
 s01_lsbreg1[7:0] <= s01_lsb[7:0] ; 
 s02_lsbreg1[7:0] <= s02_lsb[7:0] ; 
 s03_lsbreg1[7:0] <= s03_lsb[7:0] ; 
end 
// Sign extended & msb added with carry. 
assign s00_msb[5:0] = {n0_reg1[11], n0_reg1[11:7]}+ 
 {n1_reg1[11], n1_reg1[11:7]}+s00_lsbreg1[7]; 
//s00_msb[6] is ignored. 
assign s01_msb[5:0] = {n2_reg1[11], n2_reg1[11:7]}+ 
 {n3_reg1[11], n3_reg1[11:7]}+s01_lsbreg1[7]; 
 assign s02_msb[5:0] = {n4_reg1[11], n4_reg1[11:7]}+ 
 {n5_reg1[11], n5_reg1[11:7]}+s02_lsbreg1[7]; 
assign s03_msb[5:0] = {n6_reg1[11], n6_reg1[11:7]}+ 
 {n7_reg1[11], n7_reg1[11:7]}+s03_lsbreg1[7]; 
always @ (posedge clk) 
// Pipeline 2: clk (2). Register msb to continue addition of msb. 
begin 
 s00_msbreg2[5:0] <= s00_msb[5:0] ; // Preserve all msb sum. 
 s01_msbreg2[5:0] <= s01_msb[5:0] ; 
 s02_msbreg2[5:0] <= s02_msb[5:0] ; 
 s03_msbreg2[5:0] <= s03_msb[5:0] ; 
 s00_lsbreg2[6:0] <= s00_lsbreg1[6:0] ; // Preserve all lsb sum. 
 s01_lsbreg2[6:0] <= s01_lsbreg1[6:0] ; 
 s02_lsbreg2[6:0] <= s02_lsbreg1[6:0] ; 
 s03_lsbreg2[6:0] <= s03_lsbreg1[6:0] ; 
end 
assign s10_lsb[7:0] = s00_lsbreg2[6:0]+s01_lsbreg2[6:0] ; 
 //Add lsb first : s10_lsb[7] is the carry. 
assign s11_lsb[7:0] = s02_lsbreg2[6:0] +s03_lsbreg2[6:0] ; 
 //s00, s01 lsbs need not be registered 
 //since addition is already carried out here. 
always @ (posedge clk) 
// Pipeline 3: clk (3). Register msb to continue addition of msb. 
begin 
 s10_lsbreg3[7:0] <= s10_lsb[7:0] ; // Preserve all lsb sum. 
 s11_lsbreg3[7:0] <= s11_lsb[7:0] ; 
 s00_msbreg3[5:0] <= s00_msbreg2[5:0] 
 // Preserve all msb sum. 
 s01_msbreg3[5:0] <= s01_msbreg2[5:0] ; 
 s02_msbreg3[5:0] <= s02_msbreg2[5:0] ; 
 s03_msbreg3[5:0] <= s03_msbreg2[5:0] ; 
end 
assign s10_msb[6:0] = {s00_msbreg3[5], 
 s00_msbreg3[5:0]}+{s01_msbreg3[5], 
 s01_msbreg3[5:0]}+s10_lsbreg3[7] ; 
// Add MSB of second stage with sign extension and carry in from LSB. 
// s10_msb[7] is ignored. 
assign s11_msb[6:0] = {s02_msbreg3[5], s02_msbreg3[5:0]}+ 
 {s03_msbreg3[5], s03_msbreg3[5:0]}+ 
 s11_lsbreg3[7] ; 
 always @ (posedge clk)
 begin 
 s10_lsbreg4[6:0] <= s10_lsbreg3[6:0] ; // Preserve all lsb sum. 
 s11_lsbreg4[6:0] <= s11_lsbreg3[6:0] ; 
 s10_msbreg4[6:0] <= s10_msb[6:0] ; // Preserve all msb sum. 
 s11_msbreg4[6:0] <= s11_msb[6:0] ; 
end
assign s20_lsb[7:0] = s10_lsbreg4[6:0]+ s11_lsbreg4[6:0] ; 
 //Add lsb first : s20_lsb[7] is the carry. 
always @ (posedge clk) 
// Pipeline 5: clk (5). Register msb to continue addition of msb. 
begin 
 s10_msbreg5[6:0] <= s10_msbreg4[6:0]; //Preserve all msb sum. 
 s11_msbreg5[6:0] <= s11_msbreg4[6:0] ; 
 s20_lsbreg5cy <= s20_lsb[7]; // Preserve all lsb sum. 
 s20_lsbreg5[6:0] <= s20_lsb[6:0]; 
end 
// Add third stage MSB results and concatenate 
// with LSB result to get the final result. 
assign sum[14:0] = {({s10_msbreg5[6], s10_msbreg5[6:0]}+ 
 {s11_msbreg5[6], s11_msbreg5[6:0]}+ 
 s20_lsbreg5cy), s20_lsbreg5[6:0]}; 
endmodule



endmodule
