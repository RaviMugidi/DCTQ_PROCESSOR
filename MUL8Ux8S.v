module mult8ux8s(
clk, // Declare the design module and 
 n1, 
 n2, 
 result 
 ) ;
 input clk ; 
input [10:0] n1 ; 
input [7:0] n2 ; 
output [18:0] result ; 
wire n1orn2z ; // Declare combinational 
wire [10:0] p1 ; // circuit signals. 
wire [10:0] p2 ; 
wire [10:0] p3 ; 
wire [10:0] p4 ; 
wire [10:0] p5 ; 
wire [10:0] p6 ; 
wire [10:0] p7 ; 
wire [10:0] p8 ; 
wire [6:0] s11a ; 
wire [6:0] s12a ; 
wire [6:0] s13a ; 
wire [6:0] s14a ; 
wire [5:0] s11b ; 
wire [5:0] s12b ; 
wire [5:0] s13b ; 
wire [5:0] s14b ; 
wire [12:0] s11 ; 
wire [12:0] s12 ; 
wire [12:0] s13 ; 
wire [12:0] s14 ; 
wire [7:0] s21a ; 
wire [7:0] s22a ; 
wire [6:0] s21b ; 
wire [6:0] s22b ;
wire [14:0] s21 ; 
wire [14:0] s22 ; 
wire [8:0] s31a ; 
wire [7:0] s31b ; 
wire [17:0] s31 ; 
wire res_sign ; 
wire [18:0] res ; 
reg [10:0] n1_mag ; // Declare all registers. 
reg [7:0] n2_mag ; 
reg [10:0] p1_reg1 ; 
reg [10:0] p2_reg1 ; 
reg [10:0] p3_reg1 ; 
reg [10:0] p4_reg1 ; 
reg [10:0] p5_reg1 ; 
reg [10:0] p6_reg1 ; 
reg [10:0] p7_reg1 ; 
reg [10:0] p8_reg1 ; 
reg [6:0] s11a_reg2 ; 
reg [6:0] s12a_reg2 ; 
reg [6:0] s13a_reg2 ; 
reg [6:0] s14a_reg2 ; 
reg n1_reg1; 
reg n1_reg2; 
reg n1_reg3; 
reg n1_reg4; 
reg n1_reg5; 
reg n1_reg6; 
reg n1_reg7; 
reg n2_reg1; 
reg n2_reg2; 
reg n2_reg3; 
reg n2_reg4; 
reg n2_reg5; 
reg n2_reg6; 
reg n2_reg7; 
reg n1orn2z_reg1 ; 
reg n1orn2z_reg2 ; 
reg n1orn2z_reg3 ; 
reg n1orn2z_reg4 ; 
reg n1orn2z_reg5 ; 
reg n1orn2z_reg6 ; 
reg n1orn2z_reg7 ; 
reg [10:0] p1_reg2 ; 
reg [10:0] p2_reg2 ; 
reg [10:0] p3_reg2 ; 
reg [10:0] p4_reg2 ; 
reg [10:0] p5_reg2 ; 
reg [10:0] p6_reg2 ; 
reg [10:0] p7_reg2 ; 
reg [10:0] p8_reg2 ; 
reg [12:0] s11_reg3 ; 
reg [12:0] s12_reg3 ; 
reg [12:0] s13_reg3 ; 
reg [12:0] s14_reg3 ; 
reg [12:0] s11_reg4 ; 
reg [12:0] s12_reg4 ; 
reg [12:0] s13_reg4 ; 
reg [12:0] s14_reg4 ; 
reg [7:0] s21a_reg4 ; 
reg [7:0] s22a_reg4 ; 
reg [14:0] s21_reg5 ; 
reg [14:0] s22_reg5 ; 
reg [14:0] s21_reg6 ; 
reg [14:0] s22_reg6 ; 
reg [8:0] s31a_reg6 ; 
reg [17:0] s31_reg7 ; 
reg [18:0] result ; 
always @(n1) 
begin 
if(n1[10] == 1'b0) 
n1_mag = n1[10:0] ; 
else 
n1_mag = ~n1[10:0] + 1 ; // Evaluate twos complement. 
end 
always @(n2) 
begin 
if(n2[7] == 1'b0) 
n2_mag = n2[7:0] ; 
else 
n2_mag = ~n2[7:0] + 1 ; // Evaluate twos complement. 
end 
assign n1orn2z = ((n1 == 11'b0)||(n2 == 7'b0)) ?1'b1:1'b0 ; 
 // If n1 or n2 is zero, make final result +0. 
assign p1 = n1_mag[10:0] & {11{n2_mag[0]}}; 
// Compute the partial products. Multiply n1 by n2 bit '0', etc. 
assign p2 = n1_mag[10:0] & {11{n2_mag[1]}} ; 
assign p3 = n1_mag[10:0] & {11{n2_mag[2]}} ; 
assign p4 = n1_mag[10:0] & {11{n2_mag[3]}} ;
assign p5 = n1_mag[10:0] & {11{n2_mag[4]}} ; 
assign p6 = n1_mag[10:0] & {11{n2_mag[5]}} ; 
assign p7 = n1_mag[10:0] & {11{n2_mag[6]}} ; 
assign p8 = n1_mag[10:0] & {11{n2_mag[7]}} ;
always @ (posedge clk) // These are the first pipeline registers at clk (1) stage. 
begin 
p1_reg1 <= p1 ; 
p2_reg1 <= p2 ; 
p3_reg1 <= p3 ; 
p4_reg1 <= p4 ; 
p5_reg1 <= p5 ; 
p6_reg1 <= p6 ; 
p7_reg1 <= p7 ; 
p8_reg1 <= p8 ; 
n1_reg1 <= n1[10] ; // Preserve sign bits and the status 
n2_reg1 <= n2[7] ; 
n1orn2z_reg1 <= n1orn2z ; // whether result is zero or not 
end
assign s11a[6:0] = p1_reg1[6:1] + p2_reg1[5:0] ; 
 // LSBs are added here after left shifting 
 // p1_reg1 by one bit. 
assign s12a[6:0] = p3_reg1[6:1] + p4_reg1[5:0] ; 
assign s13a[6:0] = p5_reg1[6:1] + p6_reg1[5:0] ; 
assign s14a[6:0] = p7_reg1[6:1] + p8_reg1[5:0] ; 
 // Note: the left shifts are taken care of 
 // for p1, p3, p5 and p7. 
 // p1_reg1[0], etc. will be processed at the clk (2). 
 // s11a[6], etc. are the carry bits. 
always @ (posedge clk) // These are the second pipeline registers @ clk (2). 
begin 
s11a_reg2 <= s11a ; // Store LSB partial sums. 
s12a_reg2 <= s12a ; 
s13a_reg2 <= s13a ; 
s14a_reg2 <= s14a ; 
p1_reg2[10:7] <= p1_reg1[10:7] ; // Store MSB of partial products. 
p2_reg2[10:6] <= p2_reg1[10:6] ; 
p3_reg2[10:7] <= p3_reg1[10:7] ; 
p4_reg2[10:6] <= p4_reg1[10:6] ; 
p5_reg2[10:7] <= p5_reg1[10:7] ; 
p6_reg2[10:6] <= p6_reg1[10:6] ; 
p7_reg2[10:7] <= p7_reg1[10:7] ;
p8_reg2[10:6] <= p8_reg1[10:6] ; 
p1_reg2[0] <= p1_reg1[0] ; // Store '0' th bit since 
p3_reg2[0] <= p3_reg1[0] ; //it is not yet processed. 
p5_reg2[0] <= p5_reg1[0] ; 
p7_reg2[0] <= p7_reg1[0] ; 
n1_reg2 <= n1_reg1 ; // Also store sign bits and zero status. 
n2_reg2 <= n2_reg1 ; 
n1orn2z_reg2 <= n1orn2z_reg1 ; 
end 
assign s11b[5:0] = {1'b0, p1_reg2[10:7]} + p2_reg2[10:6] + s11a_reg2[6] ; 
assign s12b[5:0] = {1'b0, p3_reg2[10:7]} + p4_reg2[10:6] + s12a_reg2[6] ; 
assign s13b[5:0] = {1'b0, p5_reg2[10:7]} + p6_reg2[10:6] + s13a_reg2[6] ; 
assign s14b[5:0] = {1'b0, p7_reg2[10:7]} + p8_reg2[10:6] + s14a_reg2[6] ; 
 // MSBs & LSBs are concatenated here. 
assign s11[12:0] = {s11b, s11a_reg2[5:0], p1_reg2[0]} ; 
 // Concatenate MSB, LSB, '0' th bit respectively. 
assign s12[12:0] = {s12b, s12a_reg2[5:0], p3_reg2[0]} ; 
assign s13[12:0] = {s13b, s13a_reg2[5:0], p5_reg2[0]} ; 
assign s14[12:0] = {s14b, s14a_reg2[5:0], p7_reg2[0]} ;
always @ (posedge clk) 
 // These are the third pipeline registers @ clk (3). First stage results. 
begin 
s11_reg3 <= s11; // Store for further processing. 
s12_reg3 <= s12; 
s13_reg3 <= s13; 
s14_reg3 <= s14; 
n1_reg3 <= n1_reg2; 
n2_reg3 <= n2_reg2; 
n1orn2z_reg3 <= n1orn2z_reg2; 
end 
assign s21a[7:0] = s11_reg3[8:2] + s12_reg3[6:0] ; // s21a[7] is the carry. 
assign s22a[7:0] = s13_reg3[8:2] + s14_reg3[6:0] ; // LSB sum, 2nd stage. 
always @ (posedge clk) // These are the fourth pipeline registers @ clk (4). 
begin 
s11_reg4[12:9] <= s11_reg3[12:9] ; // Store bits not yet processed. 
s11_reg4[1:0] <= s11_reg3[1:0] ; 
s12_reg4[12:7] <= s12_reg3[12:7] ; 
s13_reg4[12:9] <= s13_reg3[12:9] ; 
s13_reg4[1:0] <= s13_reg3[1:0] ; 
s14_reg4[12:7] <= s14_reg3[12:7] ; 
s21a_reg4 <= s21a ; 
s22a_reg4 <= s22a ; 
n1_reg4 <= n1_reg3 ; 
n2_reg4 <= n2_reg3 ; 
n1orn2z_reg4 <= n1orn2z_reg3 ; 
end
assign s21b[6:0] = {2'b0, s11_reg4[12:9]} +s12_reg4[12:7] + s21a_reg4[7]; 
assign s22b[6:0] = {2'b0, s13_reg4[12:9]} +s14_reg4[12:7] + s22a_reg4[7]; 
assign s21[14:0] = {s21b[5:0], s21a_reg4[6:0], s11_reg4[1:0]} ; 
 // {MSB, LSB, [1:0]} 
// Result will never effect s21b[6], which is always 0. 
assign s22[14:0] = {s22b[5:0], s22a_reg4[6:0], s13_reg4[1:0]} ; 
always @ (posedge clk) // These are the fifth pipeline registers @ clk (5). 
begin 
s21_reg5 <= s21 ; // Store for further processing. 
s22_reg5 <= s22 ; 
n1_reg5 <= n1_reg4 ; 
n2_reg5 <= n2_reg4 ; 
n1orn2z_reg5 <= n1orn2z_reg4 ; 
end
assign s31a[8:0] = s21_reg5[11:4] + s22_reg5[7:0] ; 
 // Third stage LSB is computed here. 
always @ (posedge clk) // These are the sixth pipeline registers @ clk (6). 
begin 
s21_reg6 [14:12] <= s21_reg5[14:12] ; // Preserve MSBs. 
s22_reg6 [14:8] <= s22_reg5[14:8] ; 
s21_reg6 [3:0] <= s21_reg5[3:0] ; 
s31a_reg6 <= s31a ; //Third stage LSB is registered here. 
n1_reg6 <= n1_reg5 ; 
n2_reg6 <= n2_reg5 ; 
n1orn2z_reg6<= n1orn2z_reg5 ; 
end 
assign s31b[7:0] = {4'b0, s21_reg6[14:12]} + s22_reg6[14:8] + s31a_reg6[8] ; 
 // Third stage MSB is computed 
here. 
assign s31[17:0] = {s31b[5:0], s31a_reg6[7:0], s21_reg6[3:0]} ; 
 // Put MSB, LSB and [3:0] bits together. 
// Note that the third stage result will never effect s31b[6:5], which is always 0. 
always @ (posedge clk) // These are the seventh pipeline registers @ clk (7). 
begin 
n1_reg7 <= n1_reg6 ; // Store intermediate results. 
n2_reg7 <= n2_reg6 ; 
s31_reg7 <= s31 ; 
n1orn2z_reg7 <= n1orn2z_reg6 ; 
end 
assign res_sign = n1_reg7^n2_reg7 ; // “1” means a -ve no. 
assign res[18:0] = (res_sign ) ? {1'b1, (~s31_reg7 + 1'b1)}:{1'b0, s31_reg7} ; 
always @ (posedge clk) // This is the eighth pipeline register registered @ clk (8). 
begin 
if (n1orn2z_reg7 == 1'b1) 
result[18:0] <= 19'b0 ; 
else 
result[18:0] <= res ; // This is the final result (product of two 
 // numbers) in twos complement form. 
end 
endmodule
