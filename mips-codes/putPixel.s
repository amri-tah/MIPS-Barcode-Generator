# "putPixel.asm"  is responsible for setting the color of a specified pixel in a bitmap image. 
.eqv BYTES_PER_ROW 1536

.text
.globl put_pixel

put_pixel:
#	sets the color of specified pixel

#	$a0 - x coordinate
#	$a1 - y coordinate - (0,0) - bottom left corner
#	$a2 - 0RGB - pixel color

	sub $sp, $sp, 4		
	sw $ra,($sp)

	la $t1, image + 44	# address of file offset to pixel array
	lw $t2, ($t1)		# file offset to pixel array in $t2
	la $t1, image		# address of bitmap
	add $t2, $t1, $t2	# address of pixel array in $t2
	
#	pixel address calculation
	mul $t1, $a1, BYTES_PER_ROW 		# t1= y*BYTES_PER_ROW
	move $t3, $a0		
	sll $a0, $a0, 1
	add $t3, $t3, $a0					# $t3 = 3*x
	add $t1, $t1, $t3					# $t1 = 3x + y*BYTES_PER_ROW
	add $t2, $t2, $t1					# pixel address 
	
#	set new color
	sb $a2,($t2)		# store B
	srl $a2,$a2,8
	sb $a2,1($t2)		# store G
	srl $a2,$a2,8
	sb $a2,2($t2)		# store R

	lw $ra, ($sp)		
	add $sp, $sp, 4
	jr $ra
