	.data
str1:
	.asciz "%d"
	.align 2
str2:
	.asciz "a = %d, b = %d\n"
	.align 2
a:	.word 0
b:	.word 0

	.text
	.globl main
main:
	push {lr}
	
	ldr r0, =str1	@ r0 = "%d"
	ldr r1, =a		@ r1 = &a
	bl scanf		@ Get user input via scanf(r0, r1), store in a
	
	ldr r0, =str1	@ r0 = "%d"
	ldr r1, =b		@ r1 = &bl
	bl scanf		@ Get uset input via scanf(r0, r1), store in b
	
	ldr r1, =a
	ldr r2, [r1]	@ Move user value for a into r2
	
	ldr r1, =b
	ldr r3, [r1]	@ Move user value for b into r3
	
	cmp r2, r3			@ Compare r2 (a) and r3 (b)
						@ If a < b {
	addlt r2, r2, #1	@	r2++;
	addlt r3, r3, #1	@	r3++;
						@ {
	
						@ If a > b {
	subgt r2, r2, #1	@	r2--;
	subgt r3, r3, #1	@	r3--;
						@ {
	
						@ else {
	lsleq r2, r2, #1	@	r2 *= 2;
	lsleq r3, r3, #1	@	r3 *= 2;
						@ {
	
	ldr r0, =str2		@ r0 = "a = %d, b = %d\n"
	mov r1, r2			@ r1 = *r2
	mov r2, r3			@ r2 = *r3
	bl printf			@ Print via printf(r0, r1, r2)
	
	pop {pc}