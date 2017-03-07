.equ ADDR_PUSHBUTTONS, 0xFF200050
.equ IRQ_PUSHBUTTONS, 0x02
.equ ledAddr, 0xff200000

.section .text
.global _start

_start:
	movia sp, 0x4000000
	
	movia r2,ADDR_PUSHBUTTONS
	movia r3,0x3
	stwio r3,8(r2)  # Enable interrupts on push buttons 1,2, and 3 

	movia r8,IRQ_PUSHBUTTONS
	wrctl ctl3,r8   # Enable bit 5 - button interrupt on Processor 

	movia r8,1
	wrctl ctl0,r8   # Enable global Interrupts on Processor 
	
loop:	br loop

	