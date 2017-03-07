.equ JP1, 0xFF200060
.equ ledAddr, 0xff200000
.equ ADDR_PUSHBUTTONS, 0xFF200050
.equ ADDR_7SEG1, 0xFF200020

.equ sen0MotorOn, 0xFFFFFBFE
.equ sen0MotorOff, 0xFFFFFBFF

.section .text
.global _start

#general register: r10, r11

_start:		movia r5, 0 #initial value loaded flag
			movia r14, 0 #initial value for second sensor
			movia r6, 0 #start/stop flag
			movia r7, 0 #current state
	
			movia sp, 0x4000000 #initialize stack pointer
			
			movia r8, JP1
			movia r9, 0xFFFFFFFF
			stwio r9, (r8) #switch off all motors and sensors
		
			movia r9, 0x07F557FF 	
			stwio r9, 4(r8) #set direction register values

			movia r10, sen0MotorOn
			stwio r10, (r8)
			
			movia r11, ADDR_PUSHBUTTONS
			movia r10, 0x3
			stwio r10, 8(r11)  # Enable interrupts on push buttons 0 and 1
			
			movia r10, 0x2
			wrctl ctl3, r10 #enable irq line 2
			
			movia r10, 1
			wrctl ctl0, r10 #enable global interrupt

			beq r6, r0, switchedOffState
	
PollSen0:	movia r8, JP1
			ldwio r10, (r8)
			srli r10, r10, 11
			andi r10, r10, 1
			beq r10, r0, afterPoll
			
			ldwio r11, (r8)
			srli r11, r11, 13
			andi r11, r11, 1
			beq r11, r0, afterPoll
			
			br PollSen0 #keep checking till valid input
			
			#after polling
afterPoll:	ldwio r10, (r8)
			srli r10, r10, 27
			andi r10, r10, 0x000F #r10 stores the sensor0 value
			
			beq r6, r0, switchedOffState
			beq r5, r0, saveValue
			blt r10, r5, obstacle
			
motorOn:
			beq r7, r0, dontAddMO #if not found and state==0 do nothing
			
			movia r10, 2 #if state==2 do nothing
			beq r10, r7, dontAddMO
			
			movia r10, 3 #if state==3 make state 0
			beq r10, r7, resetZeroMO
			
			addi r7, r7, 1 
			br dontAddMO
			
resetZeroMO:
			movia r6, 0
			movia r7, 0
			br switchedOffState
			
dontAddMO:	call moveForward
			br PollSen0
			
obstacle:
			call obstacleDetected
			br PollSen0
			
saveValue:	mov r5, r10
			addi r5, r5, -1
			
			mov r14, r10
			addi r14, r14, -1
			
			br PollSen0
			
switchedOffState:
			movia r8, JP1
			movia r10, sen0MotorOff
			stwio r10, (r8)
			
			movia r10, 0b01111110111000101110001
			movia r11, ADDR_7SEG1
			stwio r10, (r11)
			
			call drawOff #draw to vga
			
			beq r6, r0, switchedOffState
			
			movia r5, 0
			movia r7, 0
			br PollSen0
			
			
			
			
			