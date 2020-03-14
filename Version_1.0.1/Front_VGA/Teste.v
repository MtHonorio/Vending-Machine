module Teste(
    input clk_50,
    output reg [9:0] vga_r,
    output reg [9:0] vga_g,
    output reg [9:0] vga_b,
    output hsync_out,
    output vsync_out,
    output vga_sync,
    output vga_blank,
    output vga_clk
);
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [8:0] CounterY;
	wire clk_25;

	integer x = 320;
	integer y = 240;

	assign vga_sync = 1'b0;
	assign vga_clk = ~clk_25;
	assign vga_blank = hsync_out & vsync_out;

	DivisorFrequencia divisor(clk_50, clk_25);

	hvsync_generator hvsync(
		.clk(clk_25),
		.vga_h_sync(hsync_out),
		.vga_v_sync(vsync_out),
		.CounterX(CounterX),
		.CounterY(CounterY),
		.inDisplayArea(inDisplayArea)
	);
	 

    always @(posedge clk_25)
    begin
		// BATATA-FRITA ---------------------------------------
			// Batata 
			if(inDisplayArea &&
			((CounterX > 60 	&& CounterX < 70  && CounterY > 50 && CounterY <= 80) || 
			(CounterX > 70 	&& CounterX < 80  && CounterY > 60 && CounterY <= 80) || 
			(CounterX > 80 	&& CounterX < 90  && CounterY > 50 && CounterY <= 80) ||
			(CounterX > 90 	&& CounterX < 100  && CounterY > 60 && CounterY <= 80) || 
			(CounterX > 100 	&& CounterX < 110  && CounterY > 50 && CounterY <= 80)))		
			begin
				vga_r <= 1023;
				vga_g <= 1023;
				vga_b <= 0; 
			end
			// Sacola da batata 
				else if(inDisplayArea && ((CounterX > 60 	&& CounterX < 110  && CounterY > 80 && CounterY <= 155)))
			begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
			end
			
		// HAMBURGUER ---------------------------------------
			 // Pão do hambúrguer
				else if(inDisplayArea &&
				((CounterX > 180 	&& CounterX < 270  && CounterY > 60 && CounterY <= 90) ||
				(CounterX > 180 	&& CounterX < 270  && CounterY > 125 && CounterY <= 155)))
			begin
				vga_r <= 1023;
				vga_g <= 800;
				vga_b <= 0; 
			end
			// Carne do hambúrguer
				else if(inDisplayArea &&
				((CounterX > 190 	&& CounterX < 260  && CounterY > 90 && CounterY <= 110))) 
			begin
				vga_r <= 800;
				vga_g <= 400;
				vga_b <= 0; 
			end
			// Tomate do hambúrguer
				else if(inDisplayArea &&
				((CounterX > 185 	&& CounterX < 265  && CounterY > 110 && CounterY <= 120)))
			  begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
			end
			// Alface do hambúrguer 
				else if(inDisplayArea && 
				((CounterX > 190 	&& CounterX < 260  && CounterY > 120 && CounterY <= 125))) 
			begin
				vga_r <= 0;
				vga_g <= 1023;
				vga_b <= 0; 
			end
			
		// OVO
			// Clara
				else if(inDisplayArea && 
				((CounterX > 340  && CounterX < 370  && CounterY > 65 && CounterY <135) ||
				 (CounterX > 400  && CounterX < 420  && CounterY > 65 && CounterY <135) ||
				 (CounterX >= 360  && CounterX < 410  && CounterY > 45 && CounterY <=75) ||
				 (CounterX > 350  && CounterX <= 400  && CounterY >= 125 && CounterY <=155)))
			begin
				vga_r <= 1023;
				vga_g <= 1023;
				vga_b <= 1023; 
			end
			// Gema
			else if(inDisplayArea && 
			((CounterX >= 370  && CounterX < 400  && CounterY > 65 && CounterY <135) ||
			 (CounterX >= 400  && CounterX < 420  && CounterY > 65 && CounterY <135)))
			begin
				vga_r <= 1023;
				vga_g <= 800;
				vga_b <= 0; 
			end
		// CAFÉ
			// Xícara
			else if(inDisplayArea && 
			 ((CounterX >= 490  && CounterX < 550  && CounterY > 70 && CounterY <=155) ||
			 (CounterX >= 550  && CounterX < 570  && CounterY > 85 && CounterY <=100) ||
			 (CounterX >= 550  && CounterX < 570  && CounterY > 130 && CounterY <=145) ||
			 (CounterX >= 570  && CounterX < 5870  && CounterY > 85 && CounterY <=145)))
			begin
				vga_r <= 1023;
				vga_g <= 800;
				vga_b <= 0; 
			end
			else if(inDisplayArea && (CounterX > 300  && CounterX < 400  && CounterY > 465)) 
			begin
				vga_r <= 528;
				vga_g <= 472;
				vga_b <= 950; 
			end
			else
			begin
				vga_r <= 0;
				vga_g <= 0;
				vga_b <= 0;
			end
	end // Fim do always
endmodule 

module DivisorFrequencia(input clk_50, output reg clk_25);
	always @(posedge clk_50)
		clk_25 = ~clk_25;
endmodule
