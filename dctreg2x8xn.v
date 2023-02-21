module dctreg2x8xn(
clk, 
wa, // Pointer to p0–p7. 
din, 
enreg, 
qr0, 
qr1, 
qr2, 
qr3, 
qr4, 
qr5, 
qr6, 
qr7 
); 
parameter WIDTH = 11 ; // Change this for any other size. 
output [(WIDTH-1):0] qr0; 
output [(WIDTH-1):0] qr1; 
output [(WIDTH-1):0] qr2; 
output [(WIDTH-1):0] qr3; 
output [(WIDTH-1):0] qr4; 
output [(WIDTH-1):0] qr5; 
output [(WIDTH-1):0] qr6; 
output [(WIDTH-1):0] qr7; 
input [(WIDTH-1):0] din; 
input [2:0] wa; 
input enreg, 
input clk; 
reg [(WIDTH-1):0] qr0; 
reg [(WIDTH-1):0] qr1; 
reg [(WIDTH-1):0] qr2; 
reg [(WIDTH-1):0] qr3; 
reg [(WIDTH-1):0] qr4; 
reg [(WIDTH-1):0] qr5; 
reg [(WIDTH-1):0] qr6; 
reg [(WIDTH-1):0] qr7; 
 
reg [(WIDTH-1):0] q0; 
reg [(WIDTH-1):0] q1; 
reg [(WIDTH-1):0] q2; 
reg [(WIDTH-1):0] q3; 
reg [(WIDTH-1):0] q4; 
reg [(WIDTH-1):0] q5; 
reg [(WIDTH-1):0] q6; 
always @ (posedge clk) 
begin 
if (enreg) 
begin 
case (wa) 
3'b000: q0 <= din; // Register “p0” in clk(1) 
3'b001: q1 <= din; // Register “p1” in clk(2), 
3'b010: q2 <= din; // etc. 
3'b011: q3 <= din; 
3'b100: q4 <= din; 
3'b101: q5 <= din; 
3'b110: q6 <= din; // Register “p6” in clk(7) 
3'b111: 
 begin 
 qr0 <= q0; // Register “p0–p7” in
 qr1 <= q1; // clk(8). 
 qr2 <= q2; 
 qr3 <= q3; 
 qr4 <= q4; 
 qr5 <= q5; 
 qr6 <= q6; 
 qr7 <= din; 
 end 
endcase 
end
end



endmodule
