module LCD(
  input CLOCK_50,    //    50 MHz clock
  output LCD_ON,    // LCD Power ON/OFF
  output LCD_BLON,    // LCD Back Light ON/OFF
  output LCD_RW,    // LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,    // LCD Enable
  output LCD_RS,    // LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA,   // LCD Data bus 8 bits
  input botao,
  output led0,led1, led2, led3,
  input botao0,botao1,botao2,
  input [0:3]chave4, //Escolher produto
  output reg [9:0] vga_r,
  output reg [9:0] vga_g,
  output reg [9:0] vga_b,
  output hsync_out,
  output vsync_out,
  output vga_sync,
  output vga_blank,
  output vga_clk
);

wire [6:0] myclock;
wire RST;

wire DLY_RST;
Reset_Delay r0(    .iCLK(CLOCK_50),.oRESET(DLY_RST) );

// turn LCD ON
assign    LCD_ON        =    1'b1;
assign    LCD_BLON    =    1'b1;

wire [3:0] hex1, hex0;

LCD_Display u1(
// Host Side
   .iCLK_50MHZ(CLOCK_50),
   .iRST_N(DLY_RST),
   .hex0(hex0),
   .hex1(hex1),
// LCD Side
   .DATA_BUS(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_E(LCD_EN),
   .LCD_RS(LCD_RS),
   .botao(botao),
	.led0(led0),
	.led1(led1),
	.led2(led2),
	.led3(led3),
	.botao0(botao0),
	.botao1(botao1),
	.botao2(botao2),
	.chave4(chave4)
   
);

FrontEnd u2(
    .clk_50(CLOCK_50),
    .vga_r(vga_r),
    .vga_g(vga_g),
    .vga_b(vga_b),
    .hsync_out(hsync_out),
    .vsync_out(vsync_out),
    .vga_sync(vga_sync),
    .vga_blank(vga_blank),
    .vga_clk(vga_clk),
    .sw1(chave4[0]),
    .sw2(chave4[1]),
    .sw3(chave4[2]),
    .sw4(chave4[3])
);


endmodule
