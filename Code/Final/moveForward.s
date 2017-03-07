.equ JP1, 0xFF200060
.equ ledAddr, 0xff200000
.equ ADDR_7SEG1, 0xFF200020

.equ sen0MotorOn, 0xFFFFFBFE
.equ sen0MotorOff, 0xFFFFFBFF
.equ sen1MotorOff, 0xFFFFEFFF
.equ sen1MotorOn, 0xFFFFEFFE

.global moveForward

moveForward:
				addi sp, sp, -20
				stw r16, (sp)
				stw r17, 4(sp)
				stw r18, 8(sp)
				stw r19, 12(sp)
				stw ra, 16(sp)
				
				movi r18, 1
				movia r19, ledAddr
				stwio r18, (r19) #switch on led
				
				movia r18, 0x3F54 #0b011110100111111
				movia r19, ADDR_7SEG1
				stwio r18, (r19) #write to 7-seg display
				
				call drawOn #draw to vga
				
				movia r18, 2
				beq r7, r18, sen11	
				
				movia r17, sen0MotorOff
				br stop1
				
sen11:			movia r17, sen1MotorOff		
				
stop1:			movia r16, JP1
				stwio r17, (r16) #stop motor
				
				movia r4, 6000000
				call timerTwo
				
				movia r18, 2
				beq r7, r18, sen12
				
				movia r17, sen0MotorOn
				br go
				
sen12:			movia r17, sen1MotorOn 
				
				
go:				movia r16, JP1
				stwio r17, (r16) #move motor forward
				
				#movia r4, 80000
				#call timerTwo
				
				#movia r18, 2
				#beq r7, r18, sen13
				
				#movia r17, sen0MotorOff
				#br stop2
				
#sen13:			movia r17, sen1MotorOff	
				
#stop2:			movia r16, JP1
				#stwio r17, (r16) #stop motor
				
				ldw r16, (sp)
				ldw r17, 4(sp)
				ldw r18, 8(sp)
				ldw r19, 12(sp)
				ldw ra, 16(sp)
				addi sp, sp, 20
				ret
				