.equ ledAddr, 0xff200000
.equ ADDR_PUSHBUTTONS, 0xFF200050


.section .exceptions, "ax"

ISR:
	addi sp, sp, -12
	stw r16, (sp)
	stw r17, 4(sp)
	stw r18, 8(sp)
	#dont backup r6

	movia r16, ADDR_PUSHBUTTONS
	
	rdctl et, ipending
	andi et, et, 0x2
	bne et, r0, pushButton
	br exit
	

pushButton:
	
	ldwio r17, 12(r16)
	andi r18, r17, 0x1
	bne r0, r18, switchOn
	
	andi r18, r17, 0x2
	bne r0, r18, switchOff
	
	br exit
	
	switchOn:
		movia r6, 1
		br exit
	
	switchOff:
		movia r6, 0
		br exit
		
		
exit: 
	movi r17, 0xf
	stwio r17, 12(r16)
	
	ldw r16, (sp)
	ldw r17, 4(sp)
	ldw r18, 8(sp)
	addi sp, sp, 12
	
	subi ea, ea, 4
	eret
	