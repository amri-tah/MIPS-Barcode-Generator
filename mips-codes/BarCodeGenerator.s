# "BarCodeGenerator.asm" is the entry point of the program.
# It calls other functions to get user input, format the text, read the source BMP file, generate the barcode, and save it as a new BMP file.

.eqv MAXLEN 20
.eqv FILESIZE 98358    # 512 x 64 .bmp image

.data 
sourcefile:	.asciiz "io files/source.bmp"
resultfile:	.asciiz "io files/output.bmp"

width: 	.space 	4
inputText: .space MAXLEN

.include "getInput.s"
.include "getWidth.s"
.include "formatInput.s"
.include "displayInfo.s"
.include "chooseColor.s"
.include "fileHandling.s"
.include "barcode.s"

.text
.globl main
.globl width
.globl inputText
.globl sourcefile
.globl resultfile
.globl image
.globl exit

main:
    jal getwidth
    jal getinput
    jal format
    jal choosecolor
    jal display
    jal read_bmp
    jal barcode
    jal save_bmp
    
exit:
    li $v0, 10
    syscall
    



		

    
