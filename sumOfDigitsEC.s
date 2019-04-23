/*
 * Filename: sumOfDigitsEC.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: April 24, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */
@ Raspberry Pi directives
	.cpu	cortex-a53			@ Version of our Pis
	.syntax	unified				@ Modern ARM syntax

	.equ	FP_OFFSET, 4			@ Offset from sp to set fp
	.equ	BASE_MIN, 2			@ the minimum base size 
@ Local variable space on the stack
	.equ	LOCAL_SPACE, 16			@ Allocate space in memory for
						@ the local variables 
@ Parameter Space on the stack
	.equ	PARAM_SPACE, 8			@ Allocate space for the param-
						@ eters on the stack
@ Incoming Parameters 
	.equ	SIZE_OFFSET,-24			@ int size; 
	.equ	BASE_OFFSET, -28		@ int base;
@ Local variables
	.equ	REM_OFFSET, -8			@ int = remainder;
	.equ	N_OFFSET, -12			@ N iterator 
	.equ	SUM_OFFSET, -16

	.global	sumOfDigits			@ Specify drawCap as a global 
						@ symbol
	.text					@ Switch to Text segment 
						@ Align on evenly divisible by 
						@ 4 byte address
	.align	2				@   .align n where 2^n 
						@ determines alignment
/*
 * Function Name: sumOfDigits()
 * Function Prototype: void sumOfDigits( int size, int base );
 * Description: Calculates the sum of all the digits in size with the given base
 * Parameters: size - the size of the extra criss-cross.
 	       base - the base to use to extract the digits.
 * Side Effects: The sum of the digits will be calculated.
 * Error Conditions: None.
 * Registers used:
 *	r0 - arg 1 -- the parameter size of the criss-cross and straight.
 *	r1 - arg 2 -- the parameter base.
 *	r2 - arg 3 -- the register to carry computational tasks.
 *	r3 - temporary storage register for algorithms and computational tasks.
 */

sumOfDigits:
@ Standard prologue
	push	{fp, lr}			@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET		@ Set fp to base of saved 
						@ registers
						@ Uses 4, from
	sub	sp, sp, LOCAL_SPACE		@ allocate space for two vars
	sub	sp, sp, PARAM_SPACE		@ allocate space for two params
	str	r0, [fp, SIZE_OFFSET]		@ store the size in memory

@ Initialize the local variables and store them in memory 	
	mov	r3, 1
	str	r3, [fp, N_OFFSET]		@ n = 1;
	mov	r3, 1				@ remainder = 1;
	str	r1, [fp, BASE_OFFSET]		@ base stored in memory

@ If the base is invalid return 0
	cmp	r1, BASE_MIN			@ if( base >= 2 ) 
	blt	end_if
@ Start the loop to determine the sum of the digits 
loop:	
	cmp	r3, 0				@ while( remainder == 0 )
	beq	end_loop			@ exit loop
	ldr	r3, [fp, SIZE_OFFSET]		@ get the value of size 
	ldr	r2, [fp, N_OFFSET]		@ get the value of n
	sdiv	r3, r3, r2			@ size / n
	mov	r0, r3				@ size into r0

	bl	myRem				@ myRem ( size ) 

	str	r0, [fp, REM_OFFSET]		@ remainder = size / n % base
	ldr	r3, [fp, SUM_OFFSET]		@ get value of sum 
	add	r3, r3, r0			@ sum = sum + remainder;
	str	r3, [fp, SUM_OFFSET]		@ store the sum
	ldr	r3, [fp, N_OFFSET]		@ get value of n
	ldr	r2, [fp, BASE_OFFSET]		@ get value of BASE
	mul	r3, r3, r2			@ n = n * BASE;
	str	r3, [fp, N_OFFSET]		@ store new value of n
	
	cmp	r0, 0				@ while ( remainder != 0 )
	bne	loop	

@ Exit the loop 
end_loop:
	b	valid_return			@ return the sum 

@ End_if to return 0 if base is invalid
end_if:
	mov	r0, 0				@ return 0

@ If the base was valid return the sum 
valid_return:
	ldr	r0, [fp, SUM_OFFSET]		@ get the value of sum to return

@ Standard epilogue
	sub	sp, fp, FP_OFFSET		@ Set sp to top of saved 
						@ registers
	pop	{fp, pc}			@ Restore fp; restore lr into
						@ pc for return 
