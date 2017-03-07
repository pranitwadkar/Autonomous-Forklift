.equ ADDR_AUDIODACFIFO, 0xFF203040
.equ time_alarm, 10000
.equ ALARM_SOUND, 0x7000000 
.equ ALARM_SOUND1, 0x8000000

.global audioKill

audioKill: 
	addi sp, sp, -16
	stw ra, (sp)
	stw r16, 4(sp)
	stw r17, 8(sp)
	stw r4, 12(sp)
	
	movia 	r16, ADDR_AUDIODACFIFO
	movia 	r17, ALARM_SOUND
	stwio 	r17,	8(r0)      /* Echo to left channel */
	stwio 	r17,	12(r0)     /* Echo to right channel */
	#movui 	r4, %lo(time_alarm) 	
	#movui 	r5, %hi(time_alarm)
	movia 	r4, time_alarm
	#subi	sp, sp, 4
	#stw 	ra, 0(sp)
	#call 	timer
	movia 	r17, ALARM_SOUND1
	stwio 	r17,	8(r0)      /* Echo to left channel */
	stwio 	r17,	12(r0)     /* Echo to right channel */
	movia 	r4, time_alarm
	#call 	timer
	
	ldw ra, (sp)
	ldw r16, 4(sp)
	ldw r17, 8(sp)
	ldw r4, 12(sp)
	addi sp, sp, 16
	ret