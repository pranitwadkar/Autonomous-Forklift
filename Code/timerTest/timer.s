.equ timerAddr, 0xFF202000
.equ oneSec, 0x2FAF080

.global timer

timer:	
	movia sp, 0x40000000 #backup used registers
	addi sp, sp, -16
	stw ra, (sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r4, 12(sp)
	
	movia r16, timerAddr
	stwio r4, 8(r16) #save the lower 16 bits of the timeout period
	srli r4, r4, 16
	stwio r4, 12(r16) #save the upper 16 bits of the timeout period
	stwio r0, (r16) #reset timeout
	movi r17, 0b100 
	stwio r17, 4(r16) #start=1, cont=0, interrupt=0
	
poll:
	ldwio r17, (r16) #load the value of timeout
	andi r17, r17, 1
	beq r17, r0, poll #keep checking if not 1
	
	#after geting value 
	#reset register values
	ldw ra, (sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r4, 12(sp)
	addi sp, sp, 16
	ret

	
	
	