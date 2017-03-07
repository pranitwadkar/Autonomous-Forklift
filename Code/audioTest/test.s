
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
	movia sp, 0x4000000 #backup used registers
	
	#movia r4, 0x30000
	#call timerTwo
	call audio
	
	movia r4, 0x1000000
	call timerTwo
	
	#call audioKill
	
	#call timerTwo
	
loop: br _start
	