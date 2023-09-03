# "barcode.asm" is the starting point to creating the barcode.
# barcode function first creates barcode sequence for the quiet zone and the start symbol
# barcode_loop function then iterates through the inputText and calls the generate function to
# generate the barcode sequence for each.
# it then calculates the checksum and generates the same for them as well and also the stop symbol
# and the final quiet zone.

.data
.eqv FILESIZE 98358     # 512 x 64 .bmp image
.eqv BYTES_PER_ROW 1536

.align 4
image:	.space 	FILESIZE

.text
#	generates quite zone and start symbol
barcode:
	move $a1, $s0	#bar width

#	$a0 - x position
#	$a1 - bar width
#	$a2 - count

	sub $sp, $sp, 4	
	sw 	$ra,($sp)
	sub $sp, $sp, 4	
	sw 	$s0, ($sp)
	sub $sp, $sp, 4	
	sw 	$s1, ($sp)
	sub $sp, $sp, 4	
	sw 	$s2, ($sp)
	sub $sp, $sp, 4	
	sw 	$s3, ($sp)

	la  $s1, inputText			# input text
	li	$s2, 103				# code A start
	li	$s3, 0					# i for loop
	
	# generate quiet zone
	li	$a0, 0		
	li	$a2, 30	
	jal	space
	
	# generate start character
	move $a0, $v0
	move $a1, $s0	
	li 	$a2, 103				# code A start
	jal	generate

#	loop for barcode generation 
barcode_loop:   	

#	$a0 - x position
#	$a1 - bar width
#	$a2 - symbol value

#	iterating through  every character in the text and generating the barcode sequence for them
	lbu	$t1, ($s1)				# input text
	sub	$t1, $t1, 32	
	add	$s3, $s3, 1				# i++
	mul	$t2, $s3, $t1			# i * value
	add	$s2, $s2, $t2			# 103 += i * value
	
	move $a0, $v0	
	move $a1, $s0	
	move $a2, $t1	
	jal	generate

	add 	$s1, $s1, 1			#input text++	
	lbu	$t1, ($s1)				#input text
	sub	$t1, $t1, 32		
	bgez  $t1, barcode_loop 	#run loop until input text finished
	
#	calculating and generating  check sum 
	divu $s2, $s2, 103		# check symbol value / 103
	mfhi $t1					# move remainder from HI register to t1
	move $a0, $v0	
	move $a1, $s0	
	move $a2, $t1			#check digit value
	jal	generate
	
#	generate stop character
	move $a0, $v0
	move $a1, $s0	
	li 	$a2, 106	
	jal	generate
	
#	putting last bar since stop code = 4 bar 3 space
	move $a0, $v0		
	move $a1, $s0	
	li	$a2, 2		#count
	jal	bar
	
#	generate quiet zone
	li	$a0, 0		
	move $a1, $s0	
	li	$a2, 30					#no of space
	jal	space
	
	lw 	$s3, ($sp)	
	add $sp, $sp, 4
	lw 	$s2, ($sp)	
	add $sp, $sp, 4
	lw 	$s1, ($sp)	
	add $sp, $sp, 4
	lw 	$s0, ($sp)	
	add $sp, $sp, 4
	lw 	$ra, ($sp)	
	add $sp, $sp, 4
	jr 	$ra


