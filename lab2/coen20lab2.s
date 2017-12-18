// Alex Cherekdjian
// Coen lab #2
// Tuesday 2:15

        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align      2

        .global     Ten32
        .global     Incr
        .global     Ten64
	.global     Nested1
        .global     Nested2
	.global     PrintTwo
Ten32:
        LDR         R0,=10 	// loading constant value 10 into R0
	BX          LR  	// returning value of 10

Ten64:
        LDR         R0,=10 	// loading constant value 10 into R0
	LDR         R1,=0 	// loading constant value 0 into R1
	BX          LR 		// returning 64bit representation of 10
	
Incr:
	ADD         R0,R0,1 	// adding 1 to value given in R0
	BX          LR		// returning incremented value

Nested1:
        PUSH	    {LR} 	// presering the link register to call function
	BL          rand 	// running rand function
	ADD         R0,R0,1 	// adding 1 to random number generated
	POP         {PC} 	// restoring the program counter

Nested2:
        PUSH	    {R4,LR} 	// reserving R4 and preserving link register
	BL          rand 	// running rand function
	MOV         R4,R0 	// copying value returned in R0 into R4
	BL          rand 	// running rand function again
	ADD         R0,R0,R4 	// adding the two random values together
	POP         {R4,PC}	// restoring R4 and program counter

PrintTwo:
        PUSH	    {R4,R5,LR} 	// reserving R4,R5, and preserving the link register
        MOV         R4,R0 	// copying value from R0 into R4
        MOV         R5,R1 	// copying value from R1 into R5
	BL          printf 	// running printf function
	ADD         R1,R5,1 	// adding 1 to value in R5 and storing in answer in R1
        MOV         R0,R4 	// copying value from R4 into R1
	BL          printf 	// running printf function again
	POP         {R4,R5,PC} 	// restoring R4,R5, and program counter
        .end
