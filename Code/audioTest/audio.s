.equ ADDR_AUDIODACFIFO, 0xFF203040
.equ time_alarm, 8000
.equ ALARM_SOUND, 0x7000000 
.equ ALARM_SOUND1, 0x8000000

.global audio

audio: 
	addi sp, sp, -24
	stw ra, (sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r4, 12(sp)
	stw r18, 16(sp)
	stw r19, 20(sp)
	
	movia r18, 0
	movia r19, 1000000
	
loop: 
	addi r18, r18, 1
	movia 	r16, ADDR_AUDIODACFIFO
	movia 	r17, ALARM_SOUND
	stwio 	r17,	8(r16)      /* Echo to left channel */
	stwio 	r17,	12(r16)     /* Echo to right channel */
	#movui 	r4, %lo(time_alarm) 	
	#movui 	r5, %hi(time_alarm)
	#movui 	r4, time_alarm
	#subi	sp, sp, 4
	#stw 	ra, 0(sp)
	#call 	timer
	movia 	r17, ALARM_SOUND1
	stwio 	r17,	8(r16)      /* Echo to left channel */
	stwio 	r17,	12(r16)     /* Echo to right channel */
	#movia 	r4, time_alarm
	#call 	timer
	
	bne r18, r19, loop
	
	ldw ra, (sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r4, 12(sp)
	stw r18, 16(sp)
	stw r19, 20(sp)
	addi sp, sp, 24
	ret
	