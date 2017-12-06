// Coen lab #7

            .syntax     unified
            .cpu        cortex-m4
            .text
            .thumb_func
            .align      2

            .global     UDIVby13
            .global     SDIVby13
            .global 	CallReturnOverhead
            .global		MyUDIVby13
            .global		MySDIVby13

CallReturnOverhead:
			BX 			LR

SDIVby13:
			MOV 		R1,13
			SDIV 		R0,R0,R1
			BX 			LR

UDIVby13:
			MOV 		R1,13
			UDIV 		R0,R0,R1
			BX 			LR

MySDIVby13:                                 // generated code
            LDR         R1,=0x4EC4EC4F      // 2 clock cycle(s)
            SMMUL       R1,R1,R0            // 2 clock cycle(s)
            ASR         R1,R1,2             // 1 clock cycle(s)
            SUB         R0,R1,R0,ASR 31     // 1 clock cycle(s)
            BX          LR

MyUDIVby13:                                 // generated code
            LDR         R1,=0x4EC4EC4F      // 2 clock cycle(s)
            UMULL       R2,R1,R1,R0         // 2 clock cycle(s)
            LSR         R0,R1,2             // 1 clock cycle(s)
            BX          LR

			.end
