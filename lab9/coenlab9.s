// Coen lab #9

        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align      2

        .global     SIMD_USatAdd

// R0 = bytes[], uint32 R1 = count, uint8 R2 = amount
// for 40 bytes need to use 10 registers (4 bytes per) thus R3-R12

SIMD_USatAdd:
		PUSH		{R4-R11}
		BFI			R2,R2,8,8	// two 8 bit copies of amount
        BFI			R2,R2,16,16 // four 8 bit copies of amount

loop:	CMP			R1,40
		BLO			cleanup     // test for count less than 40

		LDMIA		R0,{R3-R12} // get next 40 bytes

		UQADD8		R3,R3,R2	// add amount to R3
		UQADD8		R4,R4,R2	// add amount to R4
		UQADD8		R5,R5,R2	// add amount to R5
		UQADD8		R6,R6,R2	// add amount to R6
		UQADD8		R7,R7,R2	// add amount to R7
		UQADD8		R8,R8,R2	// add amount to R8
		UQADD8		R9,R9,R2	// add amount to R9
		UQADD8		R10,R10,R2	// add amount to R10
		UQADD8		R11,R11,R2	// add amount to R11
		UQADD8		R12,R12,R2	// add amount to R12

		STMIA		R0!,{R3-R12}// store results of all 40, bump address

		SUB			R1,R1,40	// decrement count by 40 bytes
		B 			loop		// repeat til done

cleanup:CBZ			R1,done  	// test for count == 0
		LDR			R3,[R0]		// get next four bytes
		UQADD8		R3,R3,R2	// add amount to all four
		STR			R3,[R0],4   // store results, bump address
		SUB			R1,R1,4		// decrement count by 4
		B 			cleanup		// repeat til done

done:
        POP			{R4-R11}
        BX			LR 			// return
		.end
