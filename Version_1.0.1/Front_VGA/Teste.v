module Teste(
    input clk_50,
    output reg [9:0] vga_r,
    output reg [9:0] vga_g,
    output reg [9:0] vga_b,
    output hsync_out,
    output vsync_out,
    output vga_sync,
    output vga_blank,
    output vga_clk,
	 input sw1,
	 input sw2,
	 input sw3,
	 input sw4
);

	
	reg sw1Estado = 0;
	reg sw2Estado = 0;
	reg sw3Estado = 0;
	reg sw4Estado = 0;
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [8:0] CounterY;
	wire clk_25;

	integer x = 320;
	integer y = 240;

	/*integer chave1;
	integer chave2;
	integer chave3;
	integer chave4;*/

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
	 
		sw1Estado <= sw1;
		sw2Estado <= sw2;
		sw3Estado <= sw3;
		sw4Estado <= sw4;
		
		// BATATA-FRITA ---------------------------------------
			// Batata 
			if(inDisplayArea &&
			((CounterX > 60 && CounterX < 70  && CounterY > 150 && CounterY <= 180) || 
			(CounterX > 70 	&& CounterX < 80  && CounterY > 160 && CounterY <= 180) || 
			(CounterX > 80 	&& CounterX < 90  && CounterY > 150 && CounterY <= 180) ||
			(CounterX > 90 	&& CounterX < 100  && CounterY > 160 && CounterY <= 180) || 
			(CounterX > 100 && CounterX < 110  && CounterY > 150 && CounterY <= 180)))		
			begin
				vga_r <= 1023;
				vga_g <= 1023;
				vga_b <= 0; 
			end
			// Sacola da batata 
				else if(inDisplayArea && ((CounterX > 60 && CounterX < 110  && CounterY > 180 && CounterY <= 255)))
			begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
			end

		// HAMBURGUER ---------------------------------------
			 // Pão do hambúrguer
				else if(inDisplayArea &&
				((CounterX > 180 && CounterX < 270  && CounterY > 160 && CounterY <= 190) ||
				(CounterX > 180 && CounterX < 270  && CounterY > 225 && CounterY <= 255)))
			begin
				vga_r <= 1023;
				vga_g <= 800;
				vga_b <= 0; 
			end
			// Carne do hambúrguer
				else if(inDisplayArea &&
				((CounterX > 190 && CounterX < 260  && CounterY > 190 && CounterY <= 210))) 
			begin
				vga_r <= 800;
				vga_g <= 400;
				vga_b <= 0; 
			end
			// Tomate do hambúrguer
				else if(inDisplayArea &&
				((CounterX > 185 && CounterX < 265  && CounterY > 210 && CounterY <= 220)))
			  begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
			end
			// Alface do hambúrguer 
				else if(inDisplayArea && 
				((CounterX > 190 && CounterX < 260  && CounterY > 220 && CounterY <= 225))) 
			begin
				vga_r <= 0;
				vga_g <= 1023;
				vga_b <= 0; 
			end
			
		// OVO
			// Clara
				else if(inDisplayArea && 
				((CounterX > 340  && CounterX < 370  && CounterY > 165 && CounterY <235) ||
				 (CounterX > 400  && CounterX < 420  && CounterY > 165 && CounterY <235) ||
				 (CounterX >= 360  && CounterX < 410  && CounterY > 145 && CounterY <=175) ||
				 (CounterX > 350  && CounterX <= 400  && CounterY >= 225 && CounterY <=255)))
			begin
				vga_r <= 1023;
				vga_g <= 1023;
				vga_b <= 1023; 
			end
			// Gema
			else if(inDisplayArea && 
			((CounterX >= 370  && CounterX < 400  && CounterY > 165 && CounterY <235) ||
			 (CounterX >= 400  && CounterX < 420  && CounterY > 165 && CounterY <235)))
			begin
				vga_r <= 1023;
				vga_g <= 800;
				vga_b <= 0; 
			end
		// CAFÉ
			// Xícara
			else if(inDisplayArea && 
			 ((CounterX >= 490  && CounterX < 550  && CounterY > 170 && CounterY <=255) ||
			 (CounterX >= 550  && CounterX < 570  && CounterY > 185 && CounterY <=200) ||
			 (CounterX >= 550  && CounterX < 570  && CounterY > 230 && CounterY <=245) || 
			 (CounterX >= 570  && CounterX < 580  && CounterY > 185 && CounterY <=245)))
			begin
				vga_r <= 1023;
				vga_g <= 1023;
				vga_b <= 1023; 
			end
			// Fumaça
			else if(inDisplayArea && 	 
			 ((CounterX >= 550  && CounterX < 570  && CounterY > 135 && CounterY <=145) ||
			 (CounterX >= 530  && CounterX < 550  && CounterY > 155 && CounterY <=165)  || // fum
			 (CounterX >= 540  && CounterX < 560  && CounterY > 145 && CounterY <=155)))
			begin
				vga_r <= 900;
				vga_g <= 900;
				vga_b <= 1000; 
			end
			else if(inDisplayArea && (CounterX > 300  && CounterX < 300  && CounterY > 565)) 
			begin
				vga_r <= 528;
				vga_g <= 472;
				vga_b <= 950; 
			end
	    		// Caixa de verificação 1
	    		else if(inDisplayArea && ((CounterX > 60 && CounterX < 110  && CounterY > 280 && CounterY <= 330)))
			begin
				if(sw1Estado ==0)
				begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
				end
				else 
				begin
				vga_r <= 0;
				vga_g <= 1023;
				vga_b <= 0; 
				end 
			end
			    // Caixa de verificação 2
	    		else if(inDisplayArea && ((CounterX > 200 && CounterX < 250  && CounterY > 280 && CounterY <= 330)))
			begin
				if(sw2Estado ==0)
				begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
				end
				else 
				begin
				vga_r <= 0;
				vga_g <= 1023;
				vga_b <= 0; 
				end
			end
				// Caixa de verificação 3
				else if(inDisplayArea && ((CounterX > 360  && CounterX < 410  && CounterY > 280 && CounterY <= 330)))
			begin
				if(sw3Estado ==0)
				begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
				end
				else 
				begin
				vga_r <= 0;
				vga_g <= 1023;
				vga_b <= 0; 
				end
			end
				// Caixa de verificação 4
			else if(inDisplayArea && 
				 ((CounterX >= 500  && CounterX < 550  && CounterY > 280 && CounterY <= 330)))
			begin
				if(sw4Estado ==0)
				begin
				vga_r <= 1023;
				vga_g <= 0;
				vga_b <= 0; 
				end
				else 
				begin
				vga_r <= 0;
				vga_g <= 1023;
				vga_b <= 0; 
				end
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


