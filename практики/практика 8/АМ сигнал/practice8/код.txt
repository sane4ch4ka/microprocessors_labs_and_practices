$MOD51

ORG 0000H
    LJMP MAIN

ORG 0003H              
    PUSH ACC
    PUSH PSW
    CPL 20H.0          
    POP PSW
    POP ACC
    RETI

ORG 0100H

MAIN:
    CLR 20H.0          
    SETB IT0           
    SETB EX0           
    SETB EA            

LOOP:
    CLR P3.6
    SETB P3.6
    CLR P3.6
    JB P3.7, $         
    MOV A, P1          
    JB 20H.0, MODE1

MODE0:
    SJMP OUT

MODE1:
    CLR C
    SUBB A, #38
    JNC OUT
    CLR A

OUT:
    MOV P2, A          
    SJMP LOOP

END

