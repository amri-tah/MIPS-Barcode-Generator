# "chooseColor.asm" allows the user to choose a color of their choice from the menu

.data
color_options: .asciiz "\n Choose a color: \n 1. Black \n 2. Brown \n 3. Green \n 4. Blue \n 5. Purple\n    Choose a number corresponding to the color (1 to 5): "
color_error: .asciiz "\n	Color value entered invalid! Try again."

.text

choosecolor:
    li $v0, 4		
    la $a0, color_options
    syscall

    li $v0, 5
   	syscall
	move $s4, $v0

    blt $s4, 1, incorrect_color
    bgt $s4, 5, incorrect_color
	jr 	$ra

incorrect_color:
	li $v0, 4
    la $a0, color_error
    syscall
	j choosecolor

