
.equ ADDR_7SEG1, 0xFF200020
.equ ADDR_7SEG2, 0x10000030

.section .text
.global _start

_start:
	movia r2, ADDR_7SEG1
	movia r3, 0x3F7C405B # bits 0000110 will activate segments 1 and 2 
	stwio r3, 0(r2)        # Write to 7-seg display 
	#movia r2,ADDR_7SEG2
	#stwio r0, 0(r2) 
loop:	br loop

	