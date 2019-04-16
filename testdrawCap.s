	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"testdrawCap.c"
	.text
	.align	2
	.global	testdrawCap
	.type	testdrawCap, %function
testdrawCap:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	mov	r0, #100
	bl	outputChar
	ldmfd	sp!, {fp, pc}
	.size	testdrawCap, .-testdrawCap
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Running tests for testOutputChar...\012\000"
	.align	2
.LC1:
	.ascii	"Done running tests!\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	ldr	r3, .L4
	ldr	r3, [r3]
	ldr	r0, .L4+4
	mov	r1, #1
	mov	r2, #36
	bl	fwrite
	bl	testdrawCap
	ldr	r3, .L4
	ldr	r3, [r3]
	ldr	r0, .L4+8
	mov	r1, #1
	mov	r2, #20
	bl	fwrite
	mov	r3, #0
	mov	r0, r3
	ldmfd	sp!, {fp, pc}
.L5:
	.align	2
.L4:
	.word	stderr
	.word	.LC0
	.word	.LC1
	.size	main, .-main
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
