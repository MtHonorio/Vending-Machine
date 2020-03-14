module Contador(chave1, chave2, chave5, clock);
input chave1, chave2, chave5;
interge valor;
wire [3:0]d1;
wire [3:0]d2;

conversor_decimal player1(pontuacao1, clk_50, d1, d2);
seven_seg_decoder(d1, led1);
seven_seg_decoder(d2, led2);

valor = 0;

always @(posedge clock)
begin
	
	if(~chave1)
	begin
	contador <= contador + 1'b1; // SOMA UM AO CONTADOR
	end
	
	if(contador > 15000000) // SE O CONTADOR = MÁXIMO
	begin
		valor = valor + 1;
		contador <= 0; // ZERA CONTADOR
	end
	
	if(~chave2)
	begin
	contador <= contador + 1'b1; // SOMA UM AO CONTADOR
	end
	
	if(contador > 15000000) // SE O CONTADOR = MÁXIMO
	begin
		valor = valor + 2;
		contador <= 0; // ZERA CONTADOR
	end
	
	if(~chave5)
	begin
	contador <= contador + 1'b1; // SOMA UM AO CONTADOR
	end
	
	if(contador > 15000000) // SE O CONTADOR = MÁXIMO
	begin
		valor = valor + 5
		contador <= 0; // ZERA CONTADOR
	end
end

module seven_seg_decoder(input[3:0] data, output reg[6:0] z);
  
  always @(data) begin
    case(data)
      4'b0000 : z <= ~7'h7E;
      4'b0001 : z <= ~7'h30;
      4'b0010 : z <= ~7'h6D;
      4'b0011 : z <= ~7'h79;
      4'b0100 : z <= ~7'h33;
      4'b0101 : z <= ~7'h5B;
      4'b0110 : z <= ~7'h5F;
      4'b0111 : z <= ~7'h70;
      4'b1000 : z <= ~7'h7F;
      4'b1001 : z <= ~7'h7B;
      4'b1010 : z <= ~7'h77;
      4'b1011 : z <= ~7'h1F;
      4'b1100 : z <= ~7'h4E;
      4'b1101 : z <= ~7'h3D;
      4'b1110 : z <= ~7'h4F;
      4'b1111 : z <= ~7'h47;
    endcase
  end

endmodule

module conversor_decimal(input [31:0]n,input clk, output reg [3:0]d1, output reg [3:0]d2);
	always @(posedge clk)
	begin
		d1 = n / 10;

		d2 = n - d1 * 10;
	end
	
endmodule