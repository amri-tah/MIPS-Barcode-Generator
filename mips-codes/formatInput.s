# "formatInput.asm" formats the input text by converting lowercase letters to uppercase letters 

.text
format:
    sub $sp, $sp, 4	
	sw 	$ra,($sp)
	li $t0, 0
	
intoLowerCase:
    # this loop individually accesses characters from the string and converts it into lowercase
   	lb $t1, inputText($t0)
    beq $t1, 0, end         # string termination
    blt $t1, 'a', capital
    bgt $t1, 'z', capital
    sub $t1, $t1, 32
    sb $t1, inputText($t0)  # stores the uppercase-ed character back into the inputText

capital:
   	addi $t0, $t0, 1
    jal intoLowerCase

end:
    lw 	$ra, ($sp)	
	add $sp, $sp, 4
	jr $ra
