# "displayInfo.asm" displays the inputted width and the formatted text to be encoded to the user .

.data
width_display_prompt: .asciiz "\n   The narrowest width entered is: "
text_display_prompt: .asciiz "\n   The text to be encoded is: "

.text

display:
    li $v0, 4		
    la $a0, width_display_prompt
    syscall

    move $a0, $s0
    li $v0, 1
    syscall

    li $v0, 4		
    la $a0, text_display_prompt
    syscall

    la $a0, inputText
    li $v0, 4
    syscall

    jr $ra
