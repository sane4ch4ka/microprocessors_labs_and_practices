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

    MOV R4, #0
    MOV R5, #1

    MOV R6, #10      ; ???????? ???????

    SETB IT0
    SETB EX0
    SETB EA

LOOP:

    DJNZ R6, SKIP_MOD

    MOV R6, #10

    MOV A, R5
    JZ DOWN

UP:
    INC R4
    MOV A, R4
    CJNE A, #40, CONT
    MOV R5, #0
    SJMP CONT

DOWN:
    DEC R4
    MOV A, R4
    CJNE A, #5, CONT
    MOV R5, #1

CONT:

SKIP_MOD:

    CLR P3.6
    SETB P3.6
    CLR P3.6

    JB P3.7, $

    MOV A, P1

    JB 20H.0, MODE1

MODE0:
    SJMP OUT

MODE1:

    MOV B, A

    MOV A, R4

    CLR C
    SUBB A, #20

    JNC AMP_UP

AMP_DOWN:

    MOV A, B
    CLR C
    SUBB A, #8
    SJMP OUT

AMP_UP:

    MOV A, B
    ADD A, #8

OUT:

    MOV P2, A

    SJMP LOOP

END

