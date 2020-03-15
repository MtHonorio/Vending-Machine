module fsm(clock, botao, led0, led1, led2, led3);

input clock, botao;
input led0, led1, led2, led3;

reg estadoLed0, estadoLed1, estadoLed2, estadoLed3;
reg [1:0] estado;
reg[31:0] contador; // REGISTRA 32 DIGITOS

initial begin
contador <= 32'b0;// ZERA O CONTADOR
end

parameter zero=0, um=1, dois=2, tres=3;

always @(estado) 
begin
	case (estado)
		zero:
			begin
			estadoLed0 <= 1'b1;
			estadoLed1 <= 1'b0;
			estadoLed2 <= 1'b0;
			estadoLed3 <= 1'b0;
			end
		um:
			begin
			estadoLed0 <= 1'b0;
			estadoLed1 <= 1'b1;
			estadoLed2 <= 1'b0;
			estadoLed3 <= 1'b0; 
			end
		dois:
			begin
			estadoLed0 <= 1'b0;
			estadoLed1 <= 1'b0;
			estadoLed2 <= 1'b1;
			estadoLed3 <= 1'b0;
			end
		tres:
			begin
			estadoLed0 <= 1'b0;
			estadoLed1 <= 1'b0;
			estadoLed2 <= 1'b0;
			estadoLed3 <= 1'b1;
			end
		default:
			begin
			estadoLed0 <= 1'b0;
			estadoLed1 <= 1'b0;
			estadoLed2 <= 1'b0;
			estadoLed3 <= 1'b0;
			end
	endcase
end

always @(posedge clock) // SEMPRE NO PULSO DO CLOCK
begin
	if(~botao)
	begin
	contador <= contador + 1'b1; // SOMA UM AO CONTADOR
	end
	
	if(contador > 15000000) // SE O CONTADOR = MÁXIMO
	begin
		case (estado)
			zero:
				 estado = um;
			um:
				 estado = dois;
			dois:
				 estado = tres;
			tres:
				 estado = zero;
        endcase
		contador <= 0; // ZERA CONTADOR
	end
end

assign led0 = estadoLed0; // LED É ASSOCIADO AO ESTADO
assign led1 = estadoLed1; // LED É ASSOCIADO AO ESTADO
assign led2 = estadoLed2; // LED É ASSOCIADO AO ESTADO
assign led3 = estadoLed3; // LED É ASSOCIADO AO ESTADO

endmodule