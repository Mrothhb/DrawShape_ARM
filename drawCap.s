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
	.equ	PARAM_SPACE, 16			@ allocate space for 3 params
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
	.equ	SPACE_CHAR, ' '			@ the space character
	.equ	NEWLINE_CHAR, '\n'		@ the newline character
	.equ	FORWARD_SLASH_CHAR, '/'		@ the forward slash character
	.equ	BACK_SLASH_CHAR, '\\'		@ the backslash char
	.equ	CARAT_CHAR, '^'			@ the carat character
	.equ	V_CHAR, 'v'			@ the v character

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
	       direction - which orientation the cap will be
 * Side Effects: The Cap of Cool S is printed to stdout.
 * Error Conditions: None.
 * Registers used:
 *	r0 - arg 1 -- the parameter size of the Cool S Cap.
 *	r1 - arg 2 -- the parameter fillChar character inside of the Cap.
 *	r2 - arg 3 -- the parameter direction to draw the Cap in.
 *	r3 - temporary storage register for algorithms and computational tasks.
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
@ Initialize the cap size 
	ldr	r3, [fp, SIZE_OFFSET]		@ load the size into register r3
	mov	r2, HALF_DIVISOR		@ move 2 into r3 for division
	sdiv	r3, r3, r2			@ divide size / 2
	str	r3, [fp, CAP_SIZE_OFFSET]	@ store the capsize on stack

@ Start drawing the top Cap
	ldr	r3, [fp, DIRECTION_OFFSET]	@ get current value of direction
	cmp	r3, DIR_UP	 		@ if( direction == DIR_UP )
						@ (backward logic) 
	bne	direction_else			@ branch if not equal 
@ Start if block 	
	mov	r3, CARAT_CHAR 			@ move the '^' into r3
	str	r3, [fp, TIP_CHAR_OFFSET]	@ store '^' into memory at 
						@ the tipChar variable 
	mov	r3, FORWARD_SLASH_CHAR		@ move the '/' into r3
	str	r3, [fp, L_SLASH_CHAR_OFFSET] 	@ store the '/' in memory at 
						@ the leftSlashChar variable
	mov	r3, BACK_SLASH_CHAR		@ move the '\' into r3
	str	r3, [fp, R_SLASH_CHAR_OFFSET] 	@ store the '\' into memory at
						@ the rightSlashChar variable
	mov	r3, 0				@ move to initialize the itertr.
	str	r3, [fp, START_ITER_OFFSET]	@ iterator = 0;
	
	mov	r3, 0				@ move 0 into r3 register
	ldr	r3, [fp, CAP_SIZE_OFFSET]	@ capSize = 0;
	add	r3, r3, 1			@ capSize + 1;
	str	r3, [fp, END_ITER_OFFSET]	@ iter = capSize + 1; 

	mov	r3, 1				@ move 1 into the r3 register
	str	r3, [fp, INCR_OFFSET]		@ incr = 1;
	b	direction_end_if		@ branch to skip the else block

@ Start else block Drawing bottom of cap	
direction_else:
	mov	r3, V_CHAR			@ move the 'v' char into r3
	str	r3, [fp, TIP_CHAR_OFFSET]	@ tipChar = 'v';
	mov	r3, BACK_SLASH_CHAR		@ move '\' char into r3
	str	r3, [fp, L_SLASH_CHAR_OFFSET]	@ lefSlashChar = '\';
	mov	r3, FORWARD_SLASH_CHAR		@ move the '/' into r3
	str	r3, [fp, R_SLASH_CHAR_OFFSET]	@ rightSlashChar = '/';
	ldr	r3, [fp, CAP_SIZE_OFFSET]	@ load the capsize into r3
	str	r3, [fp, START_ITER_OFFSET]	@ startIter = capSize 
	mov	r3, -1				@ move -1 into the r3 register
	str	r3, [fp, END_ITER_OFFSET]	@ endIter = -1;
	mov	r3, -1				@ move -1 into r3		
	str	r3, [fp, INCR_OFFSET]		@ incr = -1;

@ End of direction if-else block		
direction_end_if:

@ Start drawing the Cap 
	ldr	r3, [fp, START_ITER_OFFSET]	@ load the startIter variable
						@ from memory into r3 
	str	r3, [fp, I_OFFSET]		@ store the r3 value containing
	 					@ i = startItr;
						@ Start the while loop with 
						@ condition ( i != endIter )
	ldr	r3, [fp, I_OFFSET]		@ load the iterator i into r3
	ldr	r2, [fp, END_ITER_OFFSET]	@ load the value of endIter into
						@ r2 register to use in the loop
	cmp	r3, r2				@ while( i != endIter) 
	beq	end_loop			@ branch out of the loop

loop:
@ loop body - draw leading whitespace
	mov	r0, SPACE_CHAR			@ the first parameter to
						@ outputCharNTimes
	ldr	r1, [fp, CAP_SIZE_OFFSET]	@ load in capSize variable
	ldr	r3, [fp, I_OFFSET]		@ load i into r3
	sub	r1, r1, r3			@ capSize - i

	bl	outputCharNTimes		@ branch to outputCharNTimes
						@ outputCharNTimes(SPACE_CHAR,
						@		capSize - i);

@ Draw the actual content, conditionally the tip
	ldr	r3, [fp, I_OFFSET]		@ load i into r3
	cmp	r3, 0				@ if (i == 0)
	bne	final_output_else		@ skip to else

	ldr	r0, [fp, TIP_CHAR_OFFSET]	@ load tipChar variable into r0
	bl	outputChar			@ outputChar( tipChar );
	b	final_output_end_if		@ skip else block	

final_output_else:
	ldr	r0, [fp, L_SLASH_CHAR_OFFSET]	@ load the 1st call to 
						@ outputChar with leftSlashChar
	bl	outputChar			@ outputChar(leftSlashChar); 
	ldr	r0, [fp, FILL_CHAR_OFFSET]	@ load in the second call 
						@ to outputChar 
	ldr	r1, [fp, I_OFFSET]		@ DOUBLE * i -1 load in i
	mov	r2, DOUBLE			@ move 2 into r2 for multiply
	mul	r1, r1, r2
	sub	r1, r1, 1			@ subtract 1 from DOUBLE * i
	bl	outputCharNTimes		@ outputCharNTimes(fillChar, 
						@		  DOUBLE*i - 1);
	ldr	r0, [fp, R_SLASH_CHAR_OFFSET]	@ load the '\' into r0
	bl	outputChar			@ outputChar(rightSlashChar);

@ End of final_output if-else block
final_output_end_if:

@ Draw the trailing whitespace
	mov	r0, SPACE_CHAR
	ldr	r1, [fp, CAP_SIZE_OFFSET]	@ load in r1 capSize 
	ldr	r2, [fp, I_OFFSET]		@ load in i to r2
	sub	r1, r1, r2			@ capSize - i
	bl	outputCharNTimes		@ outputCharNTimes(SPACE_CHAR,
						@		capSize -i );
	mov	r0, NEWLINE_CHAR		@ move the '\n' int r0
	bl	outputChar			@ outputChar(NEWLINE_CHAR); 

@ Loop increment conditions i = i + incr
	ldr	r1, [fp, INCR_OFFSET]		@ load in the increment value to
						@ r1 
	ldr	r3, [fp, I_OFFSET]		@ load i into r3
	add	r3, r3, r1			@ increment i with incr
	str	r3, [fp, I_OFFSET]		@ i += incr;	
	ldr	r3, [fp, I_OFFSET]		@ load i for the loop compare
	ldr	r2, [fp, END_ITER_OFFSET]	@ load endIter to r2
	cmp	r3, r2				@ while( i != endIter )
	bne	loop				@ branch back to the loop start

end_loop:

@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved 
						@ registers
	pop	{fp, pc}			@ Restore fp; restore lr into
						@ pc for return 
