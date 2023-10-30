module cmos_8_16bit(
	input              rst,
	input              pclk,
	input [7:0]        pdata_i,
	input              de_i,
	output wire[15:0]   pdata_o,
	output reg	       hblank,
	output reg         de_o
);
reg[7:0] pdata_i_d0;
reg x_cnt;
always@(posedge pclk)
begin
	pdata_i_d0 <= pdata_i;
end

always@(posedge pclk)
begin
	if(de_i & !de_d1)
		x_cnt <= 1;
	else
		x_cnt <= ~x_cnt ;

end

always@(posedge pclk or posedge rst)
begin
	if(rst)
		de_o <= 1'b0;
	else if(x_cnt)
		de_o <= 1'b1;
	else
		de_o <= 1'b0;
end

reg de_d1,de_d2;
always@(posedge pclk)begin 
	de_d1 <= de_i;
	de_d2 <= de_d1;

 	hblank <= de_d2;
end 

reg [15:0]  pdata_r;
assign pdata_o = { pdata_r[4:0], pdata_r[10:5], pdata_r[15:11] };

always@(posedge pclk or posedge rst)
begin
	if(rst)
		pdata_r <= 16'd0;
	else if(de_i && x_cnt)
		pdata_r <= {pdata_i_d0,pdata_i};
		//pdata_r <= {pdata_i_d0[7:3], pdata_i_d0[7:2], pdata_i_d0[7:3]};
	else
		pdata_r <= pdata_r;
end

endmodule 
