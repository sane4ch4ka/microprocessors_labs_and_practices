.686
.MODEL flat, C
.STACK 4096

.DATA
temp dd ?

.CODE

EXTERN ComputeFunction : NEAR

PUBLIC CalculateY

CalculateY PROC

    push ebp
    mov ebp, esp

    sub esp, 8

    mov eax, [ebp + 8]
    mov temp, eax

    fild dword ptr temp

    fstp qword ptr [esp]

    call ComputeFunction

    add esp, 8

    mov esp, ebp
    pop ebp

    ret

CalculateY ENDP

END