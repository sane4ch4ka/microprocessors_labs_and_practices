.686
.model flat,stdcall
.stack 100h
.data
point1_x REAL8 0.0
point1_y REAL8 0.0
point2_x REAL8 3.0
point2_y REAL8 0.0
point3_x REAL8 0.0
point3_y REAL8 4.0
result DWORD 0
a2 REAL8 0.0
b2 REAL8 0.0
c2 REAL8 0.0
tempx REAL8 0.0
tempy REAL8 0.0

.code
ExitProcess PROTO STDCALL :DWORD

Start:
    finit
    fld point2_x
    fsub point1_x
    fstp tempx
    fld point2_y
    fsub point1_y
    fstp tempy
    fld tempx
    fmul tempx
    fld tempy
    fmul tempy
    fadd
    fstp a2
    fld point3_x
    fsub point1_x
    fstp tempx
    fld point3_y
    fsub point1_y
    fstp tempy
    fld tempx
    fmul tempx
    fld tempy
    fmul tempy
    fadd
    fstp b2
    fld point3_x
    fsub point2_x
    fstp tempx
    fld point3_y
    fsub point2_y
    fstp tempy
    fld tempx
    fmul tempx
    fld tempy
    fmul tempy
    fadd
    fstp c2
    fld a2
    fld b2
    fadd
    fld c2
    fsub
    fabs
    fldz
    fcompp
    fstsw ax
    sahf
    jne check2
    mov result, 1
    jmp done
check2:
    fld a2
    fld c2
    fadd
    fld b2
    fsub
    fabs
    fldz
    fcompp
    fstsw ax
    sahf
    jne check3
    mov result, 1
    jmp done
check3:
    fld b2
    fld c2
    fadd
    fld a2
    fsub
    fabs
    fldz
    fcompp
    fstsw ax
    sahf
    jne fail
    mov result, 1
    jmp done
fail:
    mov result, 0
done:
    invoke ExitProcess, 0
end Start

