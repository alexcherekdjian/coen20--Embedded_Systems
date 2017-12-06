// Coen lab #4

            .syntax     unified
            .cpu        cortex-m4
            .text
            .thumb_func
            .align      2

            .global    Discriminant
            .global    Root1
            .global    Root2

Discriminant:
			MUL 	   R1,R1,R1 // b*b
			LSL        R0,R0,2 // a*4
			MLS		   R0,R0,R2,R1 // b^2 - 4*a*c
			BX		   LR

Root1:
            LDR        R3,=0
			SUB        R1,R3,R1 // 0-b = -b
			ADD        R1,R1,R2 // -b + sqrt_d
			LSL		   R0,R0,1 // 2*a
			SDIV 	   R0,R1,R0 // -b + sqrt_d / 2*a
			BX		   LR

Root2:
            LDR        R3,=0
			SUB        R1,R3,R1 // 0-b = -b
			SUB        R1,R1,R2 // -b - sqrt_d
			LSL		   R0,R0,1 // 2*a
			SDIV 	   R0,R1,R0 // -b - sqrt_d / 2*a
			BX		   LR

