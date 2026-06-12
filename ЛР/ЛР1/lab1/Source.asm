.386
.model flat, stdcall
.stack 100h

.data
    X db 9
    Y db 44
    Z db 12
    M dw 0

.code
    ExitProcess PROTO :DWORD

Start:
    ; X' в AL, сохраняем в BL
    mov al, X           ; 1. AL = 9
    xor al, 0F0h        ; 2. AL = 249 (X')
    mov bl, al          ; 3. BL = 249 (сохраняем X')
    
    ; X' and Y в CL
    and al, Y           ; 4. AL = 249 and 44 = 40
    mov cl, al          ; 5. CL = 40 (X' and Y)
    
    ; Z' or (...) в BH
    mov al, Z           ; 6. AL = 12
    xor al, 0F0h        ; 7. AL = 252 (Z')
    or al, cl           ; 8. AL = 252 or 40 = 252
    mov bh, al          ; 9. BH = 252 (результат OR)
    
    ; X' / Z в AL
    mov al, bl          ; 10. AL = 249 (X')
    mov ah, 0           ; 11. AH = 0 (подготовка к делению)
    div [Z]             ; 12. AL = 249/12 = 20, AH = 9
    movzx cx, al        ; 13. CX = 20 (расширяем до 16 бит)
    
    ; Суммируем (16-битное сложение)
    movzx bx, bh        ; 14. BX = 252 (расширяем до 16 бит)
    add bx, cx          ; 15. BX = 252 + 20 = 272
    mov M, bx           ; 16. Сохраняем
    
    call ExitProcess
end Start