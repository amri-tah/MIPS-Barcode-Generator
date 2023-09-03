# "fileHandling.asm" takes care of reading and saving the bmp files.
# when the "source.bmp" does not exist or when there is some problem with "output.bmp"

.eqv FILESIZE 98358    # 512 x 64 .bmp image
.eqv BYTES_PER_ROW 1536

.data
filesaved:	.asciiz "\n			File saved successfully!"
file_error_out: .asciiz "\n 	Cannot open 'output.bmp' for write!"
file_error_in: .asciiz "\n 		'source.bmp' does not exist!"

.text
read_bmp:
	sub $sp, $sp, 4		
	sw $ra,($sp)
	sub $sp, $sp, 4		
	sw $s1, ($sp)
    
    #open file
	li $v0, 13
    la $a0, sourcefile		# file name 
    li $a1, 0		        # flags: 0-read file
    li $a2, 0		        #mode: ignored
    syscall
	move $s1, $v0      	    # save the file descriptor
	
	move $t3, $v0			# Store file descriptor in $t3
	bltz $t3, cannot_open_input

    #read file
	li $v0, 14
	move $a0, $s1
	la $a1, image
	li $a2, FILESIZE
	syscall

    #close file
	li $v0, 16
	move $a0, $s1
    syscall
	
	lw $s1, ($sp)		
	add $sp, $sp, 4
	lw $ra, ($sp)		
	add $sp, $sp, 4
	jr $ra

save_bmp:
	sub $sp, $sp, 4		
	sw $ra,($sp)
	sub $sp, $sp, 4		
	sw $s1, ($sp)

    #open file
	li $v0, 13
    la $a0, resultfile		# file name 
    li $a1, 1		        # flags: 1-write file
    li $a2, 0		        # mode: ignored
    syscall
	move $s1, $v0           # save the file descriptor

    #save file
	li $v0, 15
	move $a0, $s1
	la $a1, image
	li $a2, FILESIZE
	syscall

	move $t3, $v0			# Store file descriptor in $t3
	bltz $t3, cannot_open_output

    #close file
	li $v0, 16
	move $a0, $s1
    syscall
	
	la $a0, filesaved
	li $v0, 4
	syscall

	lw $s1, ($sp)		
	add $sp, $sp, 4
	lw $ra, ($sp)		
	add $sp, $sp, 4
	jr $ra

# when "source.bmp" does not exist:
cannot_open_input:
	la	$a0, file_error_in 		# Set string address for printing
	li $v0, 4		
    syscall
	j exit						# Go to exit of program

# when there is a problem in writing onto "output.bmp":
cannot_open_output:
	la	$a0, file_error_out	# Set string address for printing
	li $v0, 4		
    syscall
	j exit						# Go to exit of program