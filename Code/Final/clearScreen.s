.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000

.global clearScreen

clearScreen:					
				movia r16, 0 #x
				movia r17, 239 #y
				movia r18, 0x0000 #black pixel
				#movia r19, ADDR_VGA
	
loop:			movia r19, ADDR_VGA
				muli r20, r16, 2
				add r19, r19, r20
				muli r20, r17, 1024
				add r19, r19, r20
				
				sthio r18, (r19) #save in pixel buffer
				
				
				addi r16, r16, 1 #increment x
				
				movia r20, 320
				beq r16, r20, resetX
				br loop

resetX:			movia r16, 0
				addi r17, r17, -1
				
				movia r20, 0xffffffff
				beq r17, r20, done
				br loop

				
done:			ret

	