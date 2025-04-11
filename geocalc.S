	.data
	
datastr:
	.asciz "%d"
	.align 2
	
selectstr:
	.asciz "Welcome to GeoCalc: Arm32 Assembly Edition!\nPlease choose an option:\n0.) Exit\n1.) Rectangle\n2.) Triangle\n"
	.align 2
	
selection:
	.word 0
	
rectselect:
	.asciz "Rectangle chosen!\nPlease enter height and width seperated by the enter key.\n"
	.align 2
rectstr:
	.asciz "Init Rectangle:\nHeight: %d\n Width: %d\n"
rectfstr:
	.asciz "Rectangle:\nArea: %d\nPerimeter: %d\nDiagonal: %d\nRatio: %d\n"
	.align 2
recth:
	.word 0
rectw:
	.word 0
recta:
	.word 0
rectp:
	.word 0
rectd:
	.word 0
rectr:
	.word 0

triselect:
	.asciz "Triangle chosen!\nPlease enter three values (a, b, c) seperated by the enter key.\n"
	.align 2
tristr:
	.asciz "Init Triangle:\nA: %d\nB: %d\nC: %d\n"
	.align 2
trifstr:
	.asciz "Triangle:\nArea: %d\nPerimeter: %d\nType: %d\nHeight: %d\nAlt Area via Heron's Formula: %d\n"
tria:
	.word 0
trib:
	.word 0
tric:
	.word 0
triar:
	.word 0
trip:
	.word 0
isosceles:
	.asciz "Isosceles"
	.align 2
scalene:
	.asciz "Scalene"
	.align 2
equilateral:
	.asciz "Equilateral"
	.align 2
trih:
	.word 0
trihe:
	.word 0
	
	.text
	.globl main
main:

	push {lr}
	
	ldr r0, =selectstr
	bl printf			// Print Welcome + Select
	
	ldr r0, =datastr
	ldr r1, =selection
	bl scanf			// Get user selection
	
	ldr r1, =selection
	ldr r1, [r1]		// Put selection value into r1
	
	cmp r1, #1			// Compare selection and the number 1
	beq rectangle		// If the selection == 1, branch to rectangle
	bgt triangle		// If the selection > 1, branch to triangle
	b end				// If the selection is <= 0, branch to end
	
rectangle:
	ldr r0, =rectselect
	bl printf			// Print that the user selected rectangle, and ask for height and width

	ldr r0, =datastr
	ldr r1, =recth
	bl scanf			// Get height for rectangle from user
	
	ldr r0, =datastr
	ldr r1, =rectw
	bl scanf			// Get width for rectangle from user
		
	ldr r1, =recth
	ldr r1, [r1]		// Set r1 to the height
	
	ldr r2, =rectw
	ldr r2, [r2]		// Set r2 to the width
	
	ldr r0, =rectw
	ldr r0, [r0]		// Move width into the numerator
	ldr r1, =recth
	ldr r1, [r1]		// Move height into the denominator
	
	bl divide_unsigned	// Branch to division sub-routine
		
	ldr r1, =rectr		
	str r0, [r1]		// Store quotient into rectr
		
	ldr r1, =recth
	ldr r1, [r1]
	ldr r2, =rectw
	ldr r2, [r2]		// Put height and width back into r1 and r2
	
	mul r3, r1, r2		// Get the area of the rectangle and store in r3
	
	ldr r4, =recta
	str r3, [r4]		// Store the area in recta
	
	add r4, r1, r2
	lsl r4, r4, #1		// Get the perimeter of the rectangle and store in r4
	
	ldr r5, =rectp
	str r4, [r5]		// Store the perimeter in rectp
	
	mul r5, r1, r1		// h^2
	mul r6, r2, r2		// w^2
	add r7, r5, r6		// Add h^2 + w^2, store in r7
	
	vmov s0, r7			// Move integer to float safe register
	vcvt.f32.u32 s0, s0	// Convert integer to float
	
	bl sqrtf			// Get the square root of h^2 + w^2
	
	vcvt.u32.f32 s0, s0 // Convert float back into integer
	vmov r7, s0			// Move integer back to r7
	
	ldr r6, =rectd
	str r7, [r6]		// Store diagonal in rectd
	
	ldr r0, =rectstr
	bl printf			// Print that a rectangle was initialized with r1 and r2 (height and width)
	
	ldr r0, =rectfstr
	ldr r1, =recta
	ldr r1, [r1]
	ldr r2, =rectp
	ldr r2, [r2]
	ldr r3, =rectd
	ldr r3, [r3]
	ldr r4, =rectr
	ldr r4, [r4]
	push {r4}			// Push r4 to stack because PRINTF ONLY TAKES 3 REGISTERS!!! This nearly drove me INSANE
	bl printf			// Print rectangle data
	add sp, sp, #4		// Clean stack
	b end
triangle:
	ldr r0, =tristr
	bl printf
	
	ldr r0, =trifstr
	bl printf
	b end
// r0 = num, r1 = denom
divide_unsigned:
    cmp r1, #0              // Prevent division by 0
    beq div_zero_error      // Branch to div_zero_error

    mov r2, #0              // Set quotient to 0
    mov r3, #0              // Loop counter

div_align:
    mov r4, r1, lsl r3      // Shift r1 however many times we've looped, store in r4
    cmp r4, r0              // If r4 > r0
    bhi div_aligned			// Branch to div_aligned
    add r3, r3, #1
    cmp r3, #32
    blo div_align           // Loop while r3 < 32 (bits in an arm32 integer)

div_aligned:
    subs r3, r3, #1         // Go back one shift (too far on last)
    mov r1, r1, lsl r3      // Align denom to num
    mov r4, #0              // Clear temp denom

div_loop:
    cmp r0, r1              // if dividend >= shifted divisor
    subhs r0, r0, r1        // subtract
    orrhs r2, r2, #1        // set current bit of quotient if subtracted

    cmp r3, #0
    beq div_done

    mov r2, r2, lsl #1      // shift quotient left (next bit)
    mov r1, r1, lsr #1      // shift divisor right (one bit down)
    subs r3, r3, #1         // decrement shift counter
    b div_loop

div_done:
    mov r0, r2              // move final quotient into r0
    bx lr

div_zero_error:
    mov r0, #0              // return 0
    bx lr
end:
	pop {pc}