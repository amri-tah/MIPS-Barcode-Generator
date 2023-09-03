# getWidth.asm gets the narrowest bar width from the user and stores it in $s0
# If the value entered is greater than 3 or less than 1, the program throws an error message and asks for the input again.
# Once a valid width is entered it goes back to the main 

.data
width_prompt: .asciiz "\n\n Enter narrowest bar width (Choose a number between 1 and 3): "
width_error: .asciiz "\n	Width value entered invalid! Try again."

.text
getwidth:
	li $v0, 4
    la $a0, width_prompt
    syscall
	
   	li $v0, 5
   	syscall
	move $s0, $v0
	
    blt $v0, 1, incorrect_width
    bgt $v0, 3, incorrect_width
	jr 	$ra

incorrect_width:
	li $v0, 4
    la $a0, width_error
    syscall
	j getwidth
