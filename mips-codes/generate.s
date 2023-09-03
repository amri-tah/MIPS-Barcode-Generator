# "generate.asm" is used for generating encoded data
# it uses the width table in the "code128.asm" file for getting the bar and space widths for each character

.globl generate

generate:

#	$a0 - x position
#	$a1 - bar width
#	$a2 - character value

	sub  $sp, $sp, 4	
	sw 	$ra,($sp)
	subi $sp, $sp, 4	
	sw 	$s0, ($sp)
	sub $sp, $sp, 4	
	sw 	$s1, ($sp)
	sub $sp, $sp, 4	
	sw 	$s2, ($sp)
	
	move $s0, $a1	
	move $s1, $a2	
	la	$s2, Code128	# width table
	mul	$t1, $s1, 6		# 6 * symbol value -since every character has 6 width values
	add	$s2, $s2, $t1	# table + 6 * value
	
# 	generating 3 bar, 3 space in order with the given widths 
	move $a1, $s0		# width
	lb	$a2, ($s2)		# count
	jal	bar
	
	add	$s2, $s2, 1		# table++
	
	move $a0, $v0	
	move $a1, $s0	
	lb	$a2, ($s2)	
	jal	space
		
	add	$s2, $s2, 1
	move $a0, $v0
	move $a1, $s0	
	lb	$a2, ($s2)	
	jal	bar
	
	add	$s2, $s2, 1
	move $a0, $v0
	move $a1, $s0	
	lb	$a2, ($s2)	
	jal	space
		
	add	$s2, $s2, 1
	move $a0, $v0
	move $a1, $s0		
	lb	$a2, ($s2)	
	jal	bar
	
	add	$s2, $s2, 1
	move $a0, $v0
	move $a1, $s0	
	lb	$a2, ($s2)	
	jal	space
	
	lw 	$s2, ($sp)	
	add $sp, $sp, 4
	lw 	$s1, ($sp)	
	add $sp, $sp, 4
	lw 	$s0, ($sp)	
	add $sp, $sp, 4
	lw 	$ra, ($sp)	
	add $sp, $sp, 4
	jr 	$ra