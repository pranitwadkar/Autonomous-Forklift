.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000

TEST: .incbin "up.bin"

.global drawUp

drawUp:		
				addi sp, sp, -24
				stw r16, (sp)
				stw r17, 4(sp)
				stw r18, 8(sp)
				stw r19, 12(sp)
				stw r20, 16(sp)
				stw r21, 20(sp)
				
				movui r16, 0 #x
				movui r17, 239 #y
				movia r18, TEST #white pixel
				#movia r19, ADDR_VGA
				addi r18, r18, 54
				
	
loop:			
				movia r19, ADDR_VGA
				muli r20, r16, 2
				add r19, r19, r20
				muli r20, r17, 1024
				add r19, r19, r20
				#addi r19, r19, -108
				
				ldhio r21, (r18) #load pixel from bin
				sthio r21, (r19) #save in pixel buffer
				
				addi r18, r18, 2 #increment pointer
				
				addi r16, r16, 1 #increment x
				
				movia r20, 320
				beq r16, r20, resetX
				br loop

resetX:			movia r16, 0
				addi r17, r17, -1
				
				movi r20, -1
				beq r17, r20, done
				br loop

				
done:			ldw r16, (sp)
				ldw r17, 4(sp)
				ldw r18, 8(sp)
				ldw r19, 12(sp)
				ldw r20, 16(sp)
				ldw r21, 20(sp)
				addi sp, sp, 24
				ret

	