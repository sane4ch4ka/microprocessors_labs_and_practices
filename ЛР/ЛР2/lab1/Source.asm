.686
.model flat, stdcall
.stack 100h

.data
    X   dw  0AB7Ch
    Y   dw  0C58Eh
    Z   dw  0ABCDh

    X_prime dw  ?
    Y_prime dw  ?
    Z_prime dw  ?
    M       dw  ?
    R       dw  ?
    
    clear_mask dw 0FB97h

.code
ExitProcess PROTO STDCALL :DWORD

clear_bits PROC NEAR
    pushf
    mov ax, bx
    and ax, [clear_mask]
    mov si, ax
    popf
    ret
clear_bits ENDP

far_proc PROC FAR
    pushf
    push ebp
    mov ebp, esp
    movzx eax, bx
    popcnt ecx, eax
    test ecx, 1
    jz even_bits_far
    jmp odd_bits_far

even_bits_far:
    ror bx, 6
    mov si, bx
    jmp restore_far

odd_bits_far:
    and bx, 0F1F1h
    mov si, bx

restore_far:
    pop ebp
    popf
    ret
far_proc ENDP

handle_carry PROC NEAR
    pushf
    push ebp
    mov ebp, esp
    jc carry_true
    or bx, 1021h
    jmp carry_done
carry_true:
    inc bx
carry_done:
    pop ebp
    popf
    ret
handle_carry ENDP

demo_ret_n PROC NEAR
    push ebp
    mov ebp, esp
    movzx eax, word ptr [ebp+8]
    movzx ecx, word ptr [ebp+12]
    add ax, cx
    mov R, ax
    pop ebp
    ret 4
demo_ret_n ENDP

Start:
    mov bx, X
    call clear_bits
    mov X_prime, si

    mov bx, Y
    call clear_bits
    mov Y_prime, si

    mov bx, Z
    call clear_bits
    mov Z_prime, si

    mov ax, X_prime
    and ax, Y_prime
    mov bx, ax
    mov ax, Z_prime
    not ax
    sub bx, ax
    mov M, bx

    mov bx, M
    call far_proc
    mov R, si

    pushf
    mov bx, R
    call handle_carry
    mov R, bx
    popf

    cmp R, 0
    jg positive
    jmp negative

positive:
    nop
    jmp short finish

negative:
    nop

    push 1234h
    push 5678h
    call demo_ret_n

finish:
    jmp finish

END Start

