# "setColor.asm" sets the pixel color based off of the user's choice.
# the option chosen is stored in $s5

.text
.globl setcolor
setcolor:
    beq $s4, 1, black
    beq $s4, 2, brown
    beq $s4, 3, green
    beq $s4, 4, blue
    beq $s4, 5, purple
    
black:
    li 	$a2, 0x000000
    jr $ra

brown:
    li 	$a2, 0x8b4513
    jr $ra

green:
    li 	$a2, 0x008000
    jr $ra

blue:
    li 	$a2, 0x0000ff
    jr $ra

purple:
    li 	$a2, 0x800080
    jr $ra