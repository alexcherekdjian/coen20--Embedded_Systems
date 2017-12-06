// Coen lab #5

            .syntax     unified
            .cpu        cortex-m4
            .text
            .thumb_func
            .align      2

            .global     DeleteItem
            .global     InsertItem

DeleteItem:
            SUB         R1,R1,1     // getting items-1
            LSL         R2,R2,2     // scaling index
            ADD         R0,R0,R2    // obtaining address of data[index]
            ASR         R2,R2,2     // re-scaling index to use for compare

shift1:     CMP         R2,R1       // compare index with items
            BEQ         done1
            LDR         R3,[R0,4]   // load value in a[index+1] into R3
            STR         R3,[R0]     // store R3 into a[index]
            ADD         R2,R2,1     // increment index
            ADD         R0,R0,4     // increment address of a[index]
            B           shift1

done1:      BX			LR

InsertItem:
			PUSH		{R4,R5,LR}
			SUB			R1,R1,1     // items-1 = i, also index of last element unscaled

shift2:     CMP 		R1,R2       // compare items-1 and index
			BEQ 		done2
            LSL			R4,R1,2     // scaling index of last element
			ADD         R4,R4,R0    // getting address of last value
			SUB			R5,R4,4     // get address of i-1
			LDR			R5,[R5]     // get whats in i-1 and store in R5
			STR 		R5,[R4]     // store R5 into i
			SUB			R1,R1,1     // decrement i
			B 			shift2

done2:	    STR 		R3,[R0,R2,LSL 2] // storing value into array + index*4
			POP			{R4,R5,PC}

            .end
