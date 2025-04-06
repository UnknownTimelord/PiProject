	.data
str1:	.asciz "%d\n"
	.align 2	
n:	.word 9
	.text
	.globl main
main:
	push {lr}
	
	ldr r0, =str1
	ldr r1, =n
	ldr r1, [r1]
	lsl r1, r1, #3
	bl printf

	pop {pc}
