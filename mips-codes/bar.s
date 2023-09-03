# "bar.asm" is used to generate a bar 
# it does so, with the help of the put_pixel function
.globl bar

bar:

#	$a0 - x starting position
#	$a1 - bar width
#	$a2 - bar count

	sub $sp, $sp, 4		
	sw 	$ra,($sp)
	sub	$sp, $sp, 4		
	sw 	$s0, ($sp)
	sub	$sp, $sp, 4		
	sw 	$s1, ($sp)
	sub $sp, $sp, 4		
	sw 	$s2, ($sp)

	mul	$s0, $a1, $a2		# bar width * count = x max width 
	add	$s0, $s0, $a0	    # x starting position + x current position
	move $s1, $a0			# x starting position
	li 	$s2, 5				# y position
	
bar_loop:
#	loop for generating bar, returns the final x position

#	$a0 - x position
#	$a1 - y position
#	$a2 - pixel color

	move $a0, $s1	
	move $a1, $s2	
	jal setcolor	
	jal  put_pixel
	
	add	$s2, $s2, 1			# y position++
	bne  $s2, 55, bar_loop	# continue if not reach the top
	li	$s2, 5				# y position
	add	$s1, $s1, 1			# x position++
	bne	$s1, $s0, bar_loop	#new line until reaching total width
	move $v0, $s1	
	
	lw 	$s2, ($sp)		
	add  $sp, $sp, 4
	lw 	$s1, ($sp)		
	add $sp, $sp, 4
	lw 	$s0, ($sp)		
	add  $sp, $sp, 4
	lw 	$ra, ($sp)		
	add $sp, $sp, 4
	jr 	$ra

