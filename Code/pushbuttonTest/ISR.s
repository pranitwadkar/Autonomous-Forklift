.equ ledAddr, 0xff200000
.equ ADDR_PUSHBUTTONS, 0xFF200050


.section .exceptions, "ax"

ISR:
	addi sp, sp, -20
	stw r4, (sp)
	stw r5, 4(sp)
	stw r6, 8(sp)
	stw r7, 12(sp)
	stw r8, 16(sp)

	movia r2,ADDR_PUSHBUTTONS
	rdctl et, ipending
	andi et, et, 0x2
	bne et, r0, pushButton
	br exit
	

pushButton:
	
	movia r4, ledAddr
	
	ldwio r5, 12(r2) 
	andi r7, r5, 0x1
	bne r0, r7, switchOn
	
	andi r7, r5, 0x2
	bne r0, r7, switchOff
	
	br exit
	
	switchOn:
		movia r6, 1
		stwio r6, (r4)
		br exit
	
	switchOff:
		movia r6, 0
		stwio r6, (r4)
		br exit
		
		
exit: 
	movi r7, 0xf
	stwio r7, 12(r2)
	
	ldw r4, (sp)
	ldw r5, 4(sp)
	ldw r6, 8(sp)
	ldw r7, 12(sp)
	ldw r8, 16(sp)
	addi sp, sp, 20
	
	subi ea, ea, 4
	eret
	