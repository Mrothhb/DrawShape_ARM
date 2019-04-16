/*
 * Filename: drawCap.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53			@ Version of our Pis
	.syntax	unified				@ Modern ARM syntax

	.equ	FP_OFFSET, 4			@ Offset from sp to set fp
@ Constants for local variables
	.equ	LOCAL_VAR_SPACE, 32		@ allocate space for local vars
	.equ	TIP_CHAR_OFFSET, -8		@ tip of the Cool S
	.equ	L_SLASH_CHAR_OFFSET, -12	@ left slash character 
	.equ	R_SLASH_CHAR_OFFSET, -16	@ right slash charcater
	.equ	START_ITER_OFFSET, -20		@ start of the iterator
	.equ	END_ITER_OFFSET, -24		@ end of the iterator
	.equ	INCR_OFFSET, -28		@ incremenet offset
	.equ	CAP_SIZE_OFFSET, -32		@ size of the cap for Cool S
	.equ	I_OFFSET, -36			@ iterator 
@ Constants for parameters
	.equ	PARAM_SPACE, 16			@ allocate space for the params
	.equ	SIZE_OFFSET, -40		@ size of Cool S
	.equ	FILL_CHAR_OFFSET, -44		@ the char to fill in CoolS
	.equ	DIRECTION_OFFSET, -48		@ the direction parameter
@ Constants for characters and magic numbers
	.equ	HALF_DIVISOR, 2			@ used for dividing variables
						@ size in half
	.equ	DOUBLE, 2			@ used for doubling values
@ Cool S cap directions	
	.equ	DIR_UP, 0			@ upward direction
	.equ	DIR_DOWN, 1			@ downward direction
@ Cool S whitespace, tip, and border charaters
	.equ	SPACE_CHAR, 0x20		@ the space character
	.equ	NEWLINE_CHAR, 0x0A		@ the newline character
	.equ	FORWARD_SLASH_CHAR, 0x2f	@ the forward slash character
	.equ	BACK_SLASH_CHAR, 0x5C		@ the backslash char
	.equ	CARAT_CHAR, 0x5E		@ the carat character
	.equ	V_CHAR, 0x76			@ the v character

	.global	drawCap				@ Specify drawCap as a global 
						@ symbol

	.text					@ Switch to Text segment 
						@ Align on evenly divisible by 
						@ 4 byte address
	.align	2				@   .align n where 2^n 
						@ determines alignment
/*
 * Function Name: drawCap()
 * Function Prototype: void drawCap( int size, char fillChar, int direction );
 * Description: This assembly module will print out individual characters 
 * (via calls to outputChar()and outputCharNTimes()) such that the Cool S caps 
 * will be displayed based on the user-supplied values.
 * Parameters: size - the size of the Cool S
 	       fillChar -  the fill in character 
	       direction - TODO
 * Side Effects: None.
 * Error Conditions: None.
 * Registers used;
 	TODO
 *	r0 - arg 1 -- the parameter size, and return value.
 *	r1 - arg 2 -- the parameter fillChar.
 *	r2 - arg 3 -- the parameter direction.
 */

drawCap:
@ Standard prologue
 	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from 
						@ (#_of_regs_saved - 1)*4.
@ Allocate space on the stack for local vars. Keep sp evenly divisible by 8.
	sub	sp, sp, LOCAL_VAR_SPACE		@ allocate space for 8 local 
						@ variables

@ Allocate space on stack for incoming parameters.
	sub	sp, sp, PARAM_SPACE		@ allocate space for 3 params

@ Store the parameters on the stack
	str	r0, [fp, SIZE_OFFSET]		@ store size param
	str	r1, [fp, FILL_CHAR_OFFSET]	@ store the fillChar param
	str	r2, [fp, DIRECTION_OFFSET]	@ store the direction param
@ initialize the cap size 
	ldr	r0, [fp, SIZE_OFFSET]		@ load the size into register r3
	mov	r3, HALF_DIVISOR		@ move 2 into r3 for division
	sdiv	r3, r0, r3			@ divide the size in half
	str	r3, [fp, CAP_SIZE_OFFSET]	@ store the capsize on stack

@ Start drawing the top Cap
	cmp	r0, DIR_UP	 		@ direction comparison for equal
	bne	else1				@ branch to else block
@ Start if block 	
	mov	r3, CARAT_CHAR			@ move the '^' into r3
	str	r3, [fp, TIP_CHAR_OFFSET]	@ store '^' into memory at 
						@ the tipChar variable 
	mov	r3, FORWARD_SLASH_CHAR		@ move the '/' into r3
	str	r3, [fp, L_SLASH_CHAR_OFFSET] 	@ store the '/' in memory at 
						@ the leftSlashChar variable
	mov 	r3, BACK_SLASH_CHAR		@ move the '\' into r3
	str	r3, [fp, R_SLASH_CHAR_OFFSET] 	@ store the '\' into memory at
						@ the rightSlashChar variable
	mov 	r3, 0				@ move to initialize the itertr.
	str	r3, [fp, START_ITER_OFFSET]	@ store iterator in memory with
						@ initial value of zero
	mov	r3, 0				@ initialize r3 with 0
	ldr	r3, [fp, CAP_SIZE_OFFSET]	@ load the cap size into r3
	add	r3, r3, 1			@ add 1 to the cap size and 
						@ store into the endIter var
	str	r3, [fp, END_ITER_OFFSET]	@ store the initialized end of
						@ iterator into memory 
	mov	r3, 1				@ move 1 into the r3 register
	str	r3, [fp, INCR_OFFSET]		@ store the increment value in
						@ memory
	b	end_if1				@ branch to skip the else block
@ End of If block

@ Start else block Drawing bottom of cap	
else1:
	mov	r3, V_CHAR			@ move the 'v' char into r3
	str	r3, [fp, TIP_CHAR_OFFSET]	@ store the char 'v' into the
						@ tpChar variable in memory
	mov	r3, BACK_SLASH_CHAR		@ move '\' char into r3
	str	r3, [fp, L_SLASH_CHAR_OFFSET]	@ store the '\' value in the 
						@ leftSlashChar variabl in 
						@ memory 
	mov	r3, FORWARD_SLASH_CHAR		@ move the '/' into r3
	str	r3, [fp, R_SLASH_CHAR_OFFSET]	@ store the '/' into memory
						@ at the rightSlashChar variable
	ldr	r3, [fp, CAP_SIZE_OFFSET]	@ load the capsize into r3
	str	r3, [fp, START_ITER_OFFSET]	@ store the capsize offset into
						@ the startIter variable in 
						@ memory
	mov	r3, -1				@ move -1 into the r3 register
	str	r3, [fp, END_ITER_OFFSET]	@ store -1 into the endIter
						@ variable into memory
	str	r3, [fp, INCR_OFFSET]		@ store -1 into the increment
@ End of else block		
end_if1:

@ Start drawing the Cap 
	ldr	r3, [fp, START_ITER_OFFSET]	@ load the startIter variable 
						@ from memory into r3 
	str	r3, [fp, I_OFFSET]		@ store the r3 value containing
	 					@ into the increment value in 
						@ memory
@ Start the while loop with condition ( i != endIter )
	ldr	r3, [fp, I_OFFSET]		@ load the iterator i into r3
	ldr	r2, [fp, END_ITER_OFFSET]	@ load the value of endIter into
						@ r2 register to use in the loop
	cmp	r3, r2				@ compare i to endIter
	beq	end_loop			@ branch out of the loop

loop:
@ loop body - draw leading whitespace
	mov	r0, SPACE_CHAR			@ the first parameter to 
						@ outputCharNTimes
	ldr	r1, [fp, CAP_SIZE_OFFSET]	@ load in capSize variable
	sub	r1, r1, r3			@ capSize - i, and load into r1

	b	outputCharNTimes		@ branch to outputCharNTimes 
						@ with args SPACE_CHAR and 
						@ capSize - i
@ Draw the actual content, conditionally the tip
@ if its the first/last iteration
	cmp	r3, 0				@ if (i == 0)
	bne	else2				@ skip to else 
	ldr	r0, [fp, TIP_CHAR_OFFSET]	@ load tipChar variable into r0
						@ if i == 0
	b	outputChar			@ branch to outputChar with 
						@ arguement in r0 (tipChar)
	b	end_if2				@ skip else block	

else2:
	ldr	r0, [fp, L_SLASH_CHAR_OFFSET]	@ load the 1st call to 
						@ outputChar with leftSlashChar
	b	outputChar			@ branch to outputChar 

	ldr	r0, [fp, FILL_CHAR_OFFSET]	@ load in the second call 
						@ to outputChar 
	ldr	r1, [fp, I_OFFSET]		@ DOUBLE * i -1 load in i
	mov	r2, DOUBLE			@ move 2 into r2 for multiply
	mul	r1, r1, r2
	sub	r1, r1, 1			@ subtract 1 from DOUBLE * i
	b	outputCharNTimes		@ call outputCharNTimes with
						@ ( fillChar, DOUBLE * i -1)
	ldr	r0, [fp, R_SLASH_CHAR_OFFSET]	@ load the '/' into r0
	b	outputChar			@ call outputChar ( '/' )
end_if2:

@Draw the trailing whitespace
	mov	r0, SPACE_CHAR
	ldr	r1, [fp, CAP_SIZE_OFFSET]	@ load in r1 capSize 
	ldr	r3, [fp, I_OFFSET]		@ load in i to r3
	sub	r1, r1, r3			@ capSize - i
	b	outputCharNTimes		@ call outputChar with args TODO
	mov	r0, NEWLINE_CHAR		@ argument for outputChar
	b	outputChar			@ TODO

@ Loop increment conditions
	ldr	r1, [fp, INCR_OFFSET]		@ load in the increment value to
						@ r1 
	ldr	r2, [fp, END_ITER_OFFSET]	@ load the endIter into r2
	ldr	r3, [fp, I_OFFSET]		@ load in i to increment value
	add	r3, r3, r1			@ increment i with incr
	
	cmp	r3, r2				@ compare i to endIter
	bne	loop				@ branch if i != endIter

end_loop:

@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc for
					@  return 
