	.data
str1:
	.asciz "%d"
	.align 2
str2:
	.asciz "1 + 2 ... + %d = %d\n"
	.align 2
n:	.word 0

	.text
	.globl main
main:
	push {lr}
	
	@ Problem 1
	
	ldr r0, =str1	@ r0 = "%d"
	ldr r1, =n		@ r1 = &n
	bl scanf		@ Get user input via scanf(r0, r1), store in n
	
	ldr r1, =n		@ r1 = &n
	ldr r3, [r1]	@ Load the users input into r3
	add r3, r3, #1	@ Make r3 one higher than the users input
	
	mov r2, #0		@ Set r2 to 0
	mov r1, #1		@ Set r1 to 1
loop:
	cmp r1, r3		@ if r1 == r3 (aka r1 > n) {
	beq end			@ 	break;
					@ {
	add r2, r2, r1	@ r2 += r1
	add r1, r1, #1	@ r1++
	b 	loop		@ Continue the loop
end:
	ldr r0, =str2	@ r0 = "1 + 2 ... + %d = %d\n"
	ldr r1, =n		@ r1 = &n
	ldr r1, [r1]	@ r1 = *r1
	bl printf		@ Print via printf(r0, r1, r2)
	
	pop {pc}
