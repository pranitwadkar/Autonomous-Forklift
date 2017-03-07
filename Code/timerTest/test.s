.equ JP1, 0xFF200060

.equ sen0MotorOff, 0xFFFFFBFF
.equ sen0MotorOn, 0xFFFFFBFE
.equ sen0LiftMotorUp, 0xFFFFFBFB
.equ sen0LiftMotorDown, 0xFFFFFBF3

.equ ledAddr, 0xff200000
.equ motorForward, 0xFFFFFFFE

.equ timerAddr, 0xFF202000
.equ threeSec, 0x8F0D180
.equ oneSec, 0x2FAF080

.section .text
.global _start

_start:
	movi r16, 1
	movia r5, ledAddr
	stwio r16, (r5) #switch on LED
	
	movia r4, oneSec
	#movia r5, %hi(oneSec)
	call timer
	
	movi r16, 0
	movia r5, ledAddr
	stwio r16, (r5) #switch on LED
	
	movia r4, oneSec
	#movia r5, 0x0000
	call timer
	
	br _start
	

	