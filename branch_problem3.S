	.data
str1:
	.asciz "%d"
	.align 2
str2:
	.asciz "a = %d, b = %d, c = %d\n"
	.align 2
str3:
	.asciz "Without branching:\n"
	.align 2
str4:
	.asciz "With branching:\n"
	.align 2
str5:
	.asciz "0 for no branching, 1 for with branching: \n"
	.align 2
a:	.word 0
b:	.word 0
c:	.word 0

	.text
	.globl main
main:
	push {lr}
	
	ldr r0, =str5
	bl printf
	
	ldr r0, =str1
	ldr r1, =c
	bl scanf
	
	ldr r0, =c
	ldr r0, [r0]
	
	cmp r0, #1
	beq branching
	
	ldr r0, =str3
	bl printf
	
	ldr r0, =str1	// r0 = "%d"
	ldr r1, =a		// r1 = &a
	bl scanf		// Get user input via scanf(r0, r1), store in a
	
	ldr r0, =str1	// r0 = "%d"
	ldr r1, =b		// r1 = &bl
	bl scanf		// Get uset input via scanf(r0, r1), store in b
	
	ldr r1, =a
	ldr r2, [r1]	// Move user value for a into r2
	
	ldr r1, =b
	ldr r3, [r1]	// Move user value for b into r3
		
	cmp r2, #2		// Compare a and 2
	movge r4, #5	// if a >= 2 { r4 = 5 }
	movlt r4, #10	// else { r4 = 10 }
	cmp r3, #5		// Compare b and 5
	movle r4, #5	// if b <= 5 { r4 = 5 }
	movgt r4, #10	// else { r4 = 10 }
	
	add r5, r2, r3	// Add a and b, store in r5
	cmp r5, #8		// Compare r5 and 8
	movgt r4, #5	// if r5 > 8 { r4 = 5 }
	movle r4, #10	// else { r4 = 10 }

					// \/ Stores the value inside r4 into c
	ldr r0, =c		// r0 = &c
	str r4, [r0]	// *c = *r4
	
	ldr r0, =str2	// r0 = "a = %d, b = %d, c = %d\n"
	mov r1, r2		// r1 = a
	mov r2, r3		// r2 = b
	mov r3, r4		// r3 = c
	bl printf		// printf(r0, r1, r2, r3)
	b end
	
branching:
	
	ldr r0, =str4
	bl printf
	
	ldr r0, =str1	// r0 = "%d"
	ldr r1, =a		// r1 = &a
	bl scanf		// Get user input via scanf(r0, r1), store in a
	
	ldr r0, =str1	// r0 = "%d"
	ldr r1, =b		// r1 = &bl
	bl scanf		// Get uset input via scanf(r0, r1), store in b
	
	ldr r1, =a
	ldr r2, [r1]	// Move user value for a into r2
	
	ldr r1, =b
	ldr r3, [r1]	// Move user value for b into r3
	
	mov r4, #5		// r4 = 5 (will stay 5 if conditions are not met)
	
	mov r0, #0
	cmp r2, #2		// Compare a and 2
	addge r0, #1	
	cmp r3, #5		// Compare b and 5
	addle r0, #1
	cmp r0, #2
	beq after		// Jump to after branch if BOTH conditions were met
	
	add r5, r2, r3	// Add a and b, store in r5
	cmp r5, #8		// Compare r5 and 8
	bgt after		
	
	mov r4, #10
	b after			// after()
	
after:
					// \/ Stores the value inside r4 into c
	ldr r0, =c		// r0 = &c
	str r4, [r0]	// *c = *r4
	
	ldr r0, =str2	// r0 = "a = %d, b = %d, c = %d\n"
	mov r1, r2		// r1 = a
	mov r2, r3		// r2 = b
	mov r3, r4		// r3 = c
	bl printf		// printf(r0, r1, r2, r3)
	b end
	
end:
	pop {pc}