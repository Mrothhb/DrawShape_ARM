/*
 * Filename: drawCap.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: April TODO, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53			@ Version of our Pis
	.syntax	unified				@ Modern ARM syntax

	.equ	FP_OFFSET, 4			@ Offset from sp to set fp
@ Constants for local variables
	.equ	LOCAL_VAR_SPACE, 8		@ allocate space for local vars
						@ ( int i, int thickness )
	.equ	THICKNESS_OFFSET, -8		@ allocate space for thickness
	.equ	I_OFFSET, -12			@ allocate space for i 
@ Constants for parameters
	.equ	PARAM_SPACE, 12			@ allocate space for 3 params
	.equ	SIZE_OFFSET, -16			@ size of Cool S criss cross
	.equ	FILL_CHAR_OFFSET, -20		@ the char to fill in CoolS
@ Constants for characters and magic numbers
	.equ	HALF_DIVISOR, 2			@ used for dividing variables
						@ size in half
	.equ	DOUBLE, 2			@ used for doubling values
@ Cool S cap directions	
	.equ	DIR_UP, 0			@ upward direction
	.equ	DIR_DOWN, 1			@ downward direction
@ Cool S whitespace, tip, and border charaters
	.equ	SPACE_CHAR, ' '			@ the space character
	.equ	NEWLINE_CHAR, '\n'		@ the newline character
	.equ	FORWARD_SLASH_CHAR, '/'		@ the forward slash character
	.equ	BACK_SLASH_CHAR, '\\'		@ the backslash char

	.global	drawCrissCross			@ Specify drawCrissCross as a 
						@ global symbol

	.text					@ Switch to Text segment 
						@ Align on evenly divisible by 
						@ 4 byte address
	.align	2				@   .align n where 2^n 
						@ determines alignment
/*
 * Function Name: drawCrissCross()
 * Function Prototype: void drawCap( int size, char fillChar );
 * Description: This assembly module will print out individual characters 
 * (via calls to outputChar()and outputCharNTimes()) such that the Cool S criss
 * Cross patter will be displayed based on the user-supplied values.
 * Parameters: size - the size of the criss cross pattern.
 	       fillChar -  the fill in character of the criss cross. 
 * Side Effects: Prints out the criss-cross design to stdout.
 * Error Conditions: None.
 * Registers used: TODO
 *	r0 - arg 1 -- the parameter size, and return value.
 *	r1 - arg 2 -- the parameter fillChar to fill in the criss cross.
 *	r3 - temporary storage register for algorithms and computational tasks.
 */

drawCrissCross:
@ Standard prologue
 	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from 
						@ (#_of_regs_saved - 1)*4.
@ Allocate space on the stack for local variables.
	sub	sp, sp, LOCAL_VAR_SPACE		@ allocate space for two vars.
@ Allocate space on the stack for incoming parameters.
	sub	sp, sp, PARAM_SPACE		@ allocate space for 2 params.

@ Store the parameters on the stack
	str	r0, [fp, SIZE_OFFSET]		@ store the size on the stack.
	str	r1, [fp, FILL_CHAR_OFFSET]	@ store the fillChar on stack.
@ Calculate the thickness of the Cool S
	ldr	r3, [fp, SIZE_OFFSET]		@ load size into r3
	mov	r2, HALF_DIVISOR		@ load HALF_DIVISOR in r2
	sdiv	r3, r3, r2			@ size / HALF_DIVISOR
	sub	r3, r3, 1			@ size / HALF_DIVISOR - 1
	str	r3, [fp, THICKNESS_OFFSET]	@ store the thickness in memory

@ Print the top portion of the criss-cross pattern
@ Start for loop
	mov	r3, 0				@ intialize i variable
	str	r3, [fp, I_OFFSET]		@ i = 0

	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	ldr	r2, [fp, THICKNESS_OFFSET]	@ get value of thickness
	mov	r1, HALF_DIVISOR		@ load HALF_DIVISOR in r1
	sdiv	r2, r2, r1			@ thickness / HALF_DIVISOR
	add	r2, r2, 1			@ thickness / HALF_DIVISOR + 1
	cmp	r3, r2				@ i >= thickness / HALF_DIVISOR
						@ + 1
	bge	end_top_loop			@ branch over loop body

top_loop:
	mov	r0, SPACE_CHAR			@ arg1 is SPACE_CHAR
	ldr	r1, [fp, I_OFFSET]		@ get current value of i
@ Draw the initial whitespace to indent the patter	
	bl	outputCharNTimes		@ outputCharNTimes(SPACE_CHAR,i)

@ Draw the the middle portion of the Cool S Shape
	mov	r0, BACK_SLASH_CHAR		@ arg1 back slash char
	bl	outputChar			@ outputChar(BACK_SLASH_CHAR);
	ldr	r0, [fp, FILL_CHAR_OFFSET]	@ arg1 = fillChar 
	ldr	r1, [fp, THICKNESS_OFFSET]	@ arg2 = thickness
	bl	outputCharNTimes		@ outputChar(fillChar, 
						@ thickness)
	mov	r0, BACK_SLASH_CHAR		@ arg1 = '\'
	bl	outputChar			@ outputChar(BACK_SLASH_CHAR);

@ Draw the top portion of the Cool S shape the intersects with the middle
	ldr	r0, [fp, FILL_CHAR_OFFSET]	@ arg1 = fillChar
	ldr	r1, [fp, THICKNESS_OFFSET]	@ arg2 = thickness - 
	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	mov	r2, DOUBLE			@ load DOUBLE in r2
	mul	r3, r3, r2			@ (DOUBLE * i )
	sub	r1, r1, r3			@ thickness - (DOUBLE*i);
	bl	outputCharNTimes		@ outputCharNTimes(fillChar, 
						@ (DOUBLE * i));
	mov	r0, FORWARD_SLASH_CHAR		@ arg1 = '/'
	bl	outputChar			@ outputChar(FORWARD_SLASH_CHAR)
@ Output trailing whitespace
	ldr	r1, [fp, I_OFFSET] 		@ get current value of i
	mov	r0, SPACE_CHAR			@ arg1 = ' '
	bl	outputCharNTimes		@ outputCharNTimes(SPACE_CHAR,
						@  			i);
	mov	r0, NEWLINE_CHAR		@ arg1 = '\n'
	bl	outputChar			@ outputChar(NEWLINE_CHAR);

@ Loop termination conditions
	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	add	r3, r3, 1			@ i++
	str	r3, [fp, I_OFFSET]		@ store the value of i on stack

	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	ldr	r2, [fp, THICKNESS_OFFSET]	@ get value of thickness
	mov	r1, HALF_DIVISOR		@ load HALF_DIVISOR in r1
	sdiv	r2, r2, r1			@ thickness / HALF_DIVISOR
	add	r2, r2, 1			@ + 1	
	cmp	r3, r2				@ positive logic test i
	blt	top_loop			@ i < thickness / HALF_DIVISOR
						@ i + 1	
@ End for Loop						
end_top_loop:

@ Print bottom portion of criss-cross pattern
@ Start for loop
	ldr	r3, [fp, I_OFFSET]		@ get curent value of i
	ldr	r2, [fp, THICKNESS_OFFSET]	@ get current value thickness
	mov	r1, HALF_DIVISOR		@ load HALF_DIVISOR in r1
	sdiv	r3, r2, r1			@ thickness / HALF_DIVISOR
	str	r3, [fp, I_OFFSET]		@ i =  thickness/HALF_DIVISOR
	
	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	cmp	r3, 0				@ i < 0
	blt	end_bottom_loop			@ branch over loop body

bottom_loop:
	mov	r0, SPACE_CHAR			@ arg1 is SPACE_CHAR
	ldr	r1, [fp, I_OFFSET]		@ get current value of i

@ Draw the initial whitespace to indent the patter	
	bl	outputCharNTimes		@ outputCharNTimes(SPACE_CHAR,i)

@ Draw the remaining middle portion of the Cool S shape
	mov	r0, FORWARD_SLASH_CHAR		@ arg1 = '/'
	bl	outputChar			@ outputChar(FORWARD_SLASH_CHAR)

@ call outputCharNTimes 		
	ldr	r0, [fp, FILL_CHAR_OFFSET]	@ arg1 = fillChar
	ldr	r1, [fp, THICKNESS_OFFSET]	@ arg2 = thickness - 
	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	mov	r2, DOUBLE			@ load DOUBLE in r2
	mul	r3, r3, r2			@ (DOUBLE * i )
	sub	r1, r1, r3			@ thickness - (DOUBLE*i);
	bl	outputCharNTimes		@ outputCharNTimes(fillChar, 
	
	mov	r0, BACK_SLASH_CHAR		@ arg1 back slash char
	bl	outputChar			@ outputChar(BACK_SLASH_CHAR);

@ Draw the bottom portion of the Cool S shape the intersects with the middle
	ldr	r0, [fp, FILL_CHAR_OFFSET]	@ arg1 = fillChar 
	ldr	r1, [fp, THICKNESS_OFFSET]	@ arg2 = thickness
	bl	outputCharNTimes		@ outputCharNTimes(fillChar, 
						@ thickness)
	mov	r0, BACK_SLASH_CHAR		@ arg1 = '\'
	bl	outputChar			@ outputChar(BACK_SLASH_CHAR);

@ Draw the trailing whitespace
	ldr	r1, [fp, I_OFFSET] 		@ get current value of i
	mov	r0, SPACE_CHAR			@ arg1 = ' '
	bl	outputCharNTimes		@ outputCharNTimes(SPACE_CHAR,
						@  			i);
	mov	r0, NEWLINE_CHAR		@ arg1 = '\n'
	bl	outputChar			@ outputChar(NEWLINE_CHAR);

@ Loop termination conditions
	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	sub	r3, r3, 1			@ i--
	str	r3, [fp, I_OFFSET]		@ store the value of i on stack

	ldr	r3, [fp, I_OFFSET]		@ get current value of i
	ldr	r2, [fp, THICKNESS_OFFSET]	@ get value of thickness
	mov	r1, HALF_DIVISOR		@ load HALF_DIVISOR in r1	
	sdiv	r2, r2, r1			@ thickness / HALF_DIVISOR

	cmp	r3, 0				@ positive logic test 
	bne	bottom_loop			@ i >= 0		

@ End for loop
end_bottom_loop:

@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc for 
					@ return
