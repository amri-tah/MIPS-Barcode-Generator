# "space.asm" is used to generate spaces in the barcode by returning the updated x position

.globl space
space:

#	$a0 - x starting position
#	$a1 - bar width
#	$a2 - space count

	subi $sp, $sp, 4		
	sw $ra,($sp)
	
	mul	$t1, $a1, $a2
	add	$t1, $t1, $a0
	move $v0, $t1		
	
	lw 	$ra, ($sp)		
	add $sp, $sp, 4
	jr $ra