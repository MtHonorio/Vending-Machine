module piscaLed(
     input clock, // CLOCK
     input botao,
     output led // LED
     );
     
reg[31:0] contador; // REGISTRA 32 DIGITOS
reg ledLigado; // SALVA STATUS DO LED

initial begin
contador <= 32'b0;// ZERA O CONTADOR
ledLigado <= 0; // ESTADO DO LED É FALSO

end

always @(posedge clock) // SEMPRE NO PULSO DO CLOCK
begin
	if(~botao)
	begin
	contador <= contador + 1'b1; // SOMA UM AO CONTADOR
	end
	
	if(contador > 15000000) // SE O CONTADOR = MÁXIMO
	begin
		ledLigado <= !ledLigado; //TOGGLE
		contador <= 0; // ZERA CONTADOR
	end
end

assign led = ledLigado; // LED É ASSOCIADO AO ESTADO


endmodule