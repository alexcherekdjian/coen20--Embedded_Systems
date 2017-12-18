// Coen lab #8

            .syntax     unified
            .cpu        cortex-m4
            .text
            .thumb_func
            .align      2

            .global     FloatPoly
            .global     FixedPoly

FloatPoly:
	VMOV		S1,1.0 		// x
	VLDR		S3,zero 	// initialize S3 ans
eval1:  CMP		R1,0
	BEQ		done1
	VLDMIA		R0!,{S2}	// load value of a0
	VMLA.F32	S3,S2,S1 	// ans + a0*(1)
	VMUL.F32	S1,S1,S0	// (1*x)
	SUB		R1,R1,1 	// decrement counter
	B 		eval1
done1:  VMOV		S0,S3 		// move answer into place
	BX		LR
zero: .float 0.0

FixedPoly:
	PUSH		{R4,R5,R6,R7}
	LDR		R3,= (1 << 16)      // x
	LDR		R12,=0              // initialize R12 final ans msb
        LDR             R7,=0               // initialize R11 final ans lsb
eval2:	CBZ		R2,done2
	LDR		R4,[R1],4           // load value of a0
	SMLAL		R7,R12,R4,R3	    // a0*(1) + current answer = into R12.R11
	SMULL		R5,R6,R0,R3         // (1*x) into R6.R5
	LSR		R5,R5,16            // getting msb from R5
	ORR		R3,R5,R6,LSL 16     // getting lsb from R6, R3 = (1*x)
	SUB		R2,R2,1             // decrement counter
	B 		eval2
done2:  LSR		R7,R7,16            // getting msb from R7
	ORR		R0,R7,R12,LSL 16    // getting lsb from R12, R0 = final ans
	POP		{R4,R5,R6,R7}
	BX         	LR
	.end
