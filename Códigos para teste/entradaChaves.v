module main(
input clk_50,
output led1,
output led2,
output led3,
output led4,
input sw1,
input sw2,
input sw3,
input sw4
);

integer chave1;
integer chave2;
integer chave3;
integer chave4;

always @(posedge clk_50)
begin
chave1 = sw1;
chave2 = sw2;
chave3 = sw3;
chave4 = sw4;
end

assign led1 = sw1;
assign led2 = sw2;
assign led3 = sw3;
assign led4 = sw4;

endmodule
