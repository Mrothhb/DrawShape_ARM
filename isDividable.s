/*
 * Filename: isDividable.s
 * Author: Matt Roth 
 * UserId: cs30xgs
 * Date: April 12, 2019
 * Sources of Help: Textbook, lecture notes, and discussion section notes.
 *
 */

@ Raspberry Pi directives
	.cpu	cortex-a53	@Version of our Pis
	.syntax	unified		@ Modern ARM syntax

	.equ	FP_OFFSET, 4	@ Offset from sp to set fp
	
	.global	isDividable	@ Specify isDividable as a global symbol

	.text			@ Switch to Text segment 
	.align 2		@ Align on evenly divisible by 4 byte address;

				@   .align n where 2^n determines alignment
/*
 * Function Name: isDividable()
 * Function Prototype: int isDividable( int dividend, int divisor );
 * Description: This assembly module Tests if the dividend is evenly dividable 
 * 		by the divisor.
 * Parameters: dividend - the dividend operand
 *	       divisor - the divisor operand
 * Side Effects: None
 * Error Conditions: If the divisor is zero, return -1 (negative numbers OK). 
 * Return Value: -1 if error, 1 if dividable, 0 if not dividable.
 *
 * Registers used:
 *	r0 - arg 1 -- the dividend and the return value 1, or 0 or -1.
 *	r1 - arg 2 -- the divisor 
 */

isDividable:
@ Standard prologue
 	push	{fp, lr}		@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET	@ Set fp to base of saved registers
					@ Uses 4, from (#_of_regs_saved - 1)*4.

	cmp	r1, 0			@ check if divisor is zero 
	moveq	r0,-1			@ return the -1 if divisor it zero
	bleq	done			@ branch to done if equality

	bl	myRem			@ call myRem function to get remainder
	cmp	r0,0			@ check if the remainder is zero
	moveq	r0,1			@ return 1 since its dividable
	movne	r0,0			@ if the remainder is not zero r0=0
done:
					@ do nothing and return  
@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp, pc}		@ Restore fp; restore lr into pc for
					@  return 
