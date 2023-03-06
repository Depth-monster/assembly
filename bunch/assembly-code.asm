section .data
    A dd 2, 3, 4, 1, 5, 7   ; matrix A
    B dd 4, 5, 2, 6, 3, 1   ; matrix B
    C dd 0, 0, 0, 0, 0, 0   ; result matrix C
    N equ 2                 ; size of matrices

section .text
global _start

_start:
    ; compute matrix multiplication C = A*B
    mov ecx, N
    mov esi, A
    mov edi, B
    mov edx, C
outer_loop:
    push ecx
    mov ecx, N
inner_loop:
    push ecx
    mov eax, [esi]      ; load A[i][k]
    mov ebx, [edi]      ; load B[k][j]
    imul eax, ebx       ; compute A[i][k] * B[k][j]
    add [edx], eax      ; accumulate result in C[i][j]
    add esi, 4          ; increment A pointer
    add edi, 4          ; increment B pointer
    add edx, 4          ; increment C pointer
    pop ecx
    loop inner_loop     ; repeat for all k
    add esi, 4*N        ; jump to next row of A
    sub esi, ecx        ; adjust A pointer
    add edi, ecx*4-N*4  ; jump to next column of B
    pop ecx
    loop outer_loop     ; repeat for all i
    
    ; print the result matrix C
    mov ecx, N*N
    mov esi, C
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80           ; use the Linux system call to print to the console
    
    ; exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
