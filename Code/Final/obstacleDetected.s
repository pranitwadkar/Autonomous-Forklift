.equ sen0LiftMotorUp, 0xFFFFFBFB
.equ sen0LiftMotorDown, 0xFFFFFBF3

.equ sen0MotorOff, 0xFFFFFBFF
.equ sen1MotorOff, 0xFFFFEFFF

.equ JP1, 0xFF200060
.equ ledAddr, 0xff200000
.equ ADDR_7SEG1, 0xFF200020

.equ threeSec, 0x2F0D180  #0x8F0D180

.global obstacleDetected

obstacleDetected:
				addi sp, sp, -12
				stw r17, (sp)
				stw r16, 4(sp)
				stw ra, 8(sp)
				#dont backup r7

				movi r16, 0
				movia r17, ledAddr
				stwio r16, (r17) #switch off LED
				
				movi r16, 0
				beq r16, r7, firstObstacle
				
				movi r16, 2
				beq r16, r7, secondObstacle
				
firstObstacle:
				addi r7, r7, 1
				
				
				movia r16, sen0LiftMotorUp			
				movia r17, JP1
				stwio r16, (r17)
				
				movia r16, 0x3F7C4006
				movia r17, ADDR_7SEG1 #write to 7segment display
				stwio r16, (r17)
				
				call drawUp
				
				movia r4, threeSec
				call timer
				
				movia r16, sen1MotorOff
				movia r17, JP1
				stwio r16, (r17)
				
				br exit
				

secondObstacle:
				addi r7, r7, 1
				
				movia r16, sen0LiftMotorDown
				movia r17, JP1
				stwio r16, (r17)
				
				movia r16, 0x3F7C405B
				movia r17, ADDR_7SEG1
				stwio r16, (r17)
				
				call drawDown
				
				movia r4, threeSec
				call timer #timeout for three seconds
				
				movia r16, sen0MotorOff
				movia r17, JP1
				stwio r16, (r17)
				movia r6, 0
				
				br exit
	
		
exit:			ldw r17, (sp)
				ldw r16, 4(sp)
				ldw ra, 8(sp)
				addi sp, sp, 12
				ret
				