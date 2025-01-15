bits 64

global _start
_start:
        mov rdi, 4
        syscall
        jmp $
