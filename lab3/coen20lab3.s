// Coen lab #3

            .syntax     unified
            .cpu        cortex-m4
            .text
            .thumb_func
            .align      2

            .global    UseLDRB
            .global    UseLDRH
            .global    UseLDR
            .global    UseLDRD
            .global    UseLDMIA

UseLDRB:
			.REPT		512
			LDRB 	   	R3,[R1],1   // load 1 byte from address in R1 to R3, increment loading pointer
			STRB		R3,[R0],1   // store R3 into address in R0, increment storage pointer
            .ENDR
            BX			LR


UseLDRH:
			.REPT		256
			LDRH 		R3,[R1],2   // load 2 bytes from address in R1 to R3, increment loading pointer
			STRH		R3,[R0],2   // store R3 into address in R0, increment storage pointer
			.ENDR
			BX			LR

UseLDR:
			.REPT		128
			LDR 		R3,[R1],4   // load 4 bytes from address in R1 to R3, increment loading pointer
			STR 		R3,[R0],4   // store R3 into address in R0, increment storage pointer
			.ENDR
			BX			LR

UseLDRD:
			.REPT		64
			LDRD 		R2,R3,[R1],8  // load 8 bytes from address in R1 to R2 and R3, increment loading pointer
			STRD		R2,R3,[R0],8  // store R2 and R3 into address in R0, increment storage pointer
			.ENDR
			BX			LR

UseLDMIA:
			PUSH		{R4-R10}
			.REPT		16
			LDMIA 		R1!,{R3-R10} // load R1 into R3 then increment R1 & load in R4 etc.
			STMIA		R0!,{R3-R10} // store R3 into R0 then increment R0 and store R4 etc.
			.ENDR
			POP			{R4-R10}
			BX			LR

			.end
