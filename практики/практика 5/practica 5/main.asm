$MOD51

        ORG     00H
        LJMP    START

        ORG     100H
START:
        MOV     P0, #0FFH
        MOV     P1, #0FFH
        MOV     P2, #00H
        MOV     P3, #0FFH

        MOV     TMOD, #01H
        
        MOV     P0, #038H
        MOV     P2, #1
        MOV     P2, #0
        MOV     R5, #2
        LCALL   DELAY_MS
        
        MOV     P0, #00CH
        MOV     P2, #1
        MOV     P2, #0
        MOV     R5, #1
        LCALL   DELAY_MS
        
        MOV     P0, #001H
        MOV     P2, #1
        MOV     P2, #0
        MOV     R5, #2
        LCALL   DELAY_MS
        
        MOV     P0, #080H
        MOV     P2, #1
        MOV     P2, #0
        MOV     R5, #1
        LCALL   DELAY_MS

MAIN:
        LCALL   GET_KEY_DEBOUNCE
        CJNE    A, #0FFH, SHOW
        SJMP    MAIN

SHOW:
        MOV     P0, #001H
        MOV     P2, #1
        MOV     P2, #0
        MOV     R5, #1
        LCALL   DELAY_MS
        
        MOV     P0, #080H
        MOV     P2, #1
        MOV     P2, #0
        
        MOV     B, #10
        DIV     AB
        
        CJNE    A, #0, SHOW_TENS
        MOV     A, #20H
        SJMP    SHOW_UNITS
SHOW_TENS:
        ADD     A, #30H
SHOW_UNITS:
        MOV     P0, A
        MOV     P2, #3
        MOV     P2, #2
        
        MOV     A, B
        ADD     A, #30H
        MOV     P0, A
        MOV     P2, #3
        MOV     P2, #2
        
WAIT_RELEASE:
        LCALL   GET_KEY_DEBOUNCE
        CJNE    A, #0FFH, WAIT_RELEASE
        
        MOV     R5, #2
        LCALL   DELAY_MS
        
        SJMP    MAIN

DELAY_MS:
DELAY_LOOP:
        MOV     TH0, #0ECH 
        MOV     TL0, #078H
        CLR     TF0
        SETB    TR0
        
WAIT_TICK:
        JNB     TF0, WAIT_TICK
        CLR     TR0
        CLR     TF0
        
        DJNZ    R5, DELAY_LOOP
        RET

GET_KEY_DEBOUNCE:
        LCALL   GET_KEY_ACTUAL
        MOV     R1, A
        CJNE    A, #0FFH, DEBOUNCE_CHECK
        RET
        
DEBOUNCE_CHECK:
        MOV     R5, #1
        LCALL   DELAY_MS
        LCALL   GET_KEY_ACTUAL
        MOV     R2, A
        MOV     A, R1
        CLR     C
        SUBB    A, R2
        JNZ     GET_KEY_DEBOUNCE
        MOV     A, R1
        RET

GET_KEY_ACTUAL:
        MOV     P1, #0FFH
        MOV     P3, #0FFH
        MOV     R5, #1
        LCALL   DELAY_MS

        MOV     P3, #0FEH
        MOV     R5, #1
        LCALL   DELAY_MS
        MOV     A, P1
        ANL     A, #1FH
        CJNE    A, #1FH, GO_FOUND0
        LJMP    SCAN_COL1
GO_FOUND0:
        LJMP    FOUND0
        
SCAN_COL1:
        MOV     P3, #0FDH
        MOV     R5, #1
        LCALL   DELAY_MS
        MOV     A, P1
        ANL     A, #1FH
        CJNE    A, #1FH, GO_FOUND1
        LJMP    SCAN_COL2
GO_FOUND1:
        LJMP    FOUND1
        
SCAN_COL2:
        MOV     P3, #0FBH
        MOV     R5, #1
        LCALL   DELAY_MS
        MOV     A, P1
        ANL     A, #1FH
        CJNE    A, #1FH, GO_FOUND2
        LJMP    SCAN_COL3
GO_FOUND2:
        LJMP    FOUND2
        
SCAN_COL3:
        MOV     P3, #0F7H
        MOV     R5, #1
        LCALL   DELAY_MS
        MOV     A, P1
        ANL     A, #1FH
        CJNE    A, #1FH, GO_FOUND3
        LJMP    SCAN_COL4
GO_FOUND3:
        LJMP    FOUND3
        
SCAN_COL4:
        MOV     P3, #0EFH
        MOV     R5, #1
        LCALL   DELAY_MS
        MOV     A, P1
        ANL     A, #1FH
        CJNE    A, #1FH, GO_FOUND4
        MOV     A, #0FFH
        RET
GO_FOUND4:
        LJMP    FOUND4

FOUND0:
        CJNE    A, #1EH, NOT_KEY1
        MOV     A, #01H
        RET
NOT_KEY1:
        CJNE    A, #1DH, NOT_KEY2
        MOV     A, #02H
        RET
NOT_KEY2:
        CJNE    A, #1BH, NOT_KEY3
        MOV     A, #03H
        RET
NOT_KEY3:
        CJNE    A, #17H, NOT_KEY4
        MOV     A, #04H
        RET
NOT_KEY4:
        CJNE    A, #0FH, NOT_FOUND0
        MOV     A, #05H
        RET
NOT_FOUND0:
        MOV     A, #0FFH
        RET

FOUND1:
        CJNE    A, #1EH, NOT_KEY6
        MOV     A, #06H
        RET
NOT_KEY6:
        CJNE    A, #1DH, NOT_KEY7
        MOV     A, #07H
        RET
NOT_KEY7:
        CJNE    A, #1BH, NOT_KEY8
        MOV     A, #08H
        RET
NOT_KEY8:
        CJNE    A, #17H, NOT_KEY9
        MOV     A, #09H
        RET
NOT_KEY9:
        CJNE    A, #0FH, NOT_FOUND1
        MOV     A, #0AH
        RET
NOT_FOUND1:
        MOV     A, #0FFH
        RET

FOUND2:
        CJNE    A, #1EH, NOT_KEY11
        MOV     A, #0BH
        RET
NOT_KEY11:
        CJNE    A, #1DH, NOT_KEY12
        MOV     A, #0CH
        RET
NOT_KEY12:
        CJNE    A, #1BH, NOT_KEY13
        MOV     A, #0DH
        RET
NOT_KEY13:
        CJNE    A, #17H, NOT_KEY14
        MOV     A, #0EH
        RET
NOT_KEY14:
        CJNE    A, #0FH, NOT_FOUND2
        MOV     A, #0FH
        RET
NOT_FOUND2:
        MOV     A, #0FFH
        RET

FOUND3:
        CJNE    A, #1EH, NOT_KEY16
        MOV     A, #10H
        RET
NOT_KEY16:
        CJNE    A, #1DH, NOT_KEY17
        MOV     A, #11H
        RET
NOT_KEY17:
        CJNE    A, #1BH, NOT_KEY18
        MOV     A, #12H
        RET
NOT_KEY18:
        CJNE    A, #17H, NOT_KEY19
        MOV     A, #13H
        RET
NOT_KEY19:
        CJNE    A, #0FH, NOT_FOUND3
        MOV     A, #14H
        RET
NOT_FOUND3:
        MOV     A, #0FFH
        RET

FOUND4:
        CJNE    A, #1EH, NOT_KEY21
        MOV     A, #15H
        RET
NOT_KEY21:
        CJNE    A, #1DH, NOT_KEY22
        MOV     A, #16H
        RET
NOT_KEY22:
        CJNE    A, #1BH, NOT_KEY23
        MOV     A, #17H
        RET
NOT_KEY23:
        CJNE    A, #17H, NOT_KEY24
        MOV     A, #18H
        RET
NOT_KEY24:
        CJNE    A, #0FH, NOT_FOUND4
        MOV     A, #19H
        RET
NOT_FOUND4:
        MOV     A, #0FFH
        RET

        END
