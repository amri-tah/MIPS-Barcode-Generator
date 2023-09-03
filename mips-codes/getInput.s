# getInput.asm gets the text to be encoded from the user
# maximum number of characters specified is 20

.eqv MAXLEN 20

.data
inputText_prompt: .asciiz "\n Enter text to be encoded (Max 20 characters) : "

.text
getinput:
    li $v0, 4		
    la $a0, inputText_prompt
    syscall

    li $v0, 8	
    la $a0, inputText
    li $a1, MAXLEN
	syscall
    jr $ra