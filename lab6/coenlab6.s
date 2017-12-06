// Coen lab #6

            .syntax     unified
            .cpu        cortex-m4
            .text
            .thumb_func
            .align      2

            .global     ReverseBits
            .global     ReverseBytes
            .global 	CallReturnOverhead

CallReturnOverhead:
			BX 			LR

ReverseBits:
            LDR         R1,=0       // initializing R1
            LDR         R2,=32      // initializing counter

shift:      CMP         R2,0        // compare R2 and 0
            BEQ         done
            LSLS        R0,R0,1     // left shift R0 and get most significant bit
            RRX         R1,R1       // shift all contents of R1 down 1 and insert carry
            SUB         R2,R2,1     // decrement counter
            B           shift

done:       MOV         R0,R1       // returning reversed bits
            BX          LR

ReverseBytes:
            LDR         R1,=0       // initializing R1

            BFI         R1,R0,24,8  // inserting least significant bits of R0 in R1 bits 24-31
            LSR         R0,R0,8     // shifting next byte into place in R0
            BFI         R1,R0,16,8  // inserting least significant bits of R0 in R1 bits 16-23
            LSR         R0,R0,8     // shifting next byte into place in R0
            BFI         R1,R0,8,8   // inserting least significant bits of R0 in R1 bits 8-15
            LSR         R0,R0,8     // shifting next byte into place in R0
            BFI         R1,R0,0,8   // inserting least significant bits of R0 in R1 bits 0-7

            MOV         R0,R1       // moving solution into R1
            BX          LR

            .end
