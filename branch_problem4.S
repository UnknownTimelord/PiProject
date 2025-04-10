	.data
str1:
	.asciz "%d"
	.align 2
str2:
	.asciz "a = %d, b = %d, c = %d\n"
	.align 2
a:	.word 0
b:	.word 0
c:	.word 0

	.text
	.globl main
main:
	push {lr}
	
	
	
	pop {pc}