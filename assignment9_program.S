	.data
newline:	.asciz "\n"
	.align 2
str1:	.asciz "%d"
	.align 2
str2:	.asciz "Your value * 10: %d\n"
	.align 2
str3:	.asciz "Your value * 60: %d\n"
	.align 2
str4:	.asciz "Your value * 575: %d\n"
	.align 2
str5:	.asciz "Your value * 123: %d\n"
	.align 2
n:	.word 9

	.text
	.globl main
main:
	push {lr}		@ Save return address
	
	; My bad for not including everything, I thought these
	; were all examples to practice for #5
	
	; #1
	
	ldr r0, =str1	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load memory from the address in r1 into r1
	bl printf		@ Print n (9)
	
	ldr r0, =newline
	bl printf		@ Print newline
	
	; #2
	
	ldr r0, =str1	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
					@ Added the binary values to answer 2a
	ldr r1, [r1]	@ Load memory from the address in r1 into r1 (0b1001)
	lsl r1, r1, #1  @ Shift the memory over one (n * 2) (0b10010)
	bl printf		@ Print n * 2 (18)
	
	ldr r0, =newline
	bl printf		@ Print newline
	
	; #3
	
	ldr r0, =str1	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load memory from the address in r1 into r1
	mov r2, r1		@ Move the memory in r1 into r2
	
	@ 2^3 + 2^2 = 12, so n * (2^3 + 2^2) = n * 12
	lsl r1, r1, #3	@ Shift the memory three times (<-)
	lsl r2, r2, #2	@ Shift the memory twice (<-)
	add r1, r1, r2  @ add n * 2^3 and n * 2^2
	bl printf		@ Print n * 12 (108)
	
	ldr r0, =newline
	bl printf		@ Print newline
	
	; #4
	
	ldr r0, =str1	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load memory from the address in r1 into r1 (0b1001)
	mov r2, r1		@ Move the memory in r1 into r2
	
	@ 2^4 - 2^0 = 15, so n * (2^4 - 2^0) = n * 15
	lsl r1, r1, #4	@ Shift the memory three times (<-)
	lsl r2, r2, #0	@ Shift the memory twice (<-)
	sub r1, r1, r2  @ subtract n * 2^4 and n * 2^0
	bl printf		@ Print n * 15 (135)
	
	ldr r0, =newline
	bl printf		@ Print newline
	
	; #5
	
	ldr r0, =str1	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	bl scanf		@ Wait for user input, then loads that into the memory at the address of n
	
	ldr r0, =str2	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load the memory at the address in r1 into r1
	mov r2, r1		@ Move the memory in r1 into r2

	@ 2^3 + 2^1 = 10, so n * (2^3 + 2^1) = n * 10
	lsl r1, r1, #3	@ Shift user input three times (<-)
	lsl r2, r2, #1	@ Shift user input once (<-)
	add r1, r1, r2	@ Add the shifted values together and store in r1
	bl printf		@ Print n * 10
	
	ldr r0, =str3	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load the memory at the address in r1 into r1
	mov r2, r1      @ Move the memory in r1 into r2
	
	@ 2^5 + 2^4 + 2^3 + 2^2 = 60, so n * (2^5 + 2^4 + 2^3 + 2^2) = n * 60
	lsl r3, r1, #5  @ Shift user input 5 times, store it in r3
	lsl r4, r2, #4  @ Shift user input 4 times, store it in r4
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #3	@ Shift user input 3 times, store it in r4
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #2  @ Shift user input 2 times, store it in r4
	add r1, r3, r4	@ Add r3 and r4 and store it in r1 (final value)
	bl printf		@ Print n * 60
	
	ldr r0, =str4	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load the memory at the address in r1 into r1
	mov r2, r1      @ Move the memory in r1 into r2
	
	@ 2^9 + 2^5 + 2^4 + 2^3 + 2^2 + 2^1 + 2^0 = 575, so n * (2^9 + 2^5 + 2^4 + 2^3 + 2^2 + 2^1 + 2^0) = n * 575
	lsl r3, r1, #9  @ Shift user input 9 times, store it in r3 (2^9)
	lsl r4, r2, #5  @ Shift user input 5 times, store it in	r4 (2^5)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3		   
	lsl r4, r2, #4	@ Shift user input 4 times, store it in r4 (2^4)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #3  @ Shift user input 3 times, store it in r4 (2^3)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #2  @ Shift user input 2 times, store it in r4 (2^2)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #1  @ Shift user input 1 times, store it in r4 (2^1)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3  
	add r1, r3, r2	@ Add one more n (2^0)
	bl printf		@ Print n * 575
	
	ldr r0, =str5	@ Load address of str1 into r0
	ldr r1, =n		@ Load address of n into r1
	ldr r1, [r1]	@ Load the memory at the address in r1 into r1
	mov r2, r1      @ Move the memory in r1 into r2
	
	@ 2^6 + 2^5 + 2^4 + 2^3 + 2^1 + 2^0 = 123, so n * (2^6 + 2^5 + 2^4 + 2^3 + 2^1 + 2^0) = n * 123
	lsl r3, r1, #6  @ Shift user input 6 times, store it in r3 (2^6)
	lsl r4, r2, #5  @ Shift user input 5 times, store it in	r4 (2^5)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3		   
	lsl r4, r2, #4	@ Shift user input 4 times, store it in r4 (2^4)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #3  @ Shift user input 3 times, store it in r4 (2^3)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	lsl r4, r2, #1  @ Shift user input 1 times, store it in r4 (2^1)
	add r3, r3, r4  @ Add r3 and r4 and store it in r3
	add r1, r3, r2	@ Add one more n (2^0)
	bl printf		@ Print n * 123

	pop {pc}		@ Return
