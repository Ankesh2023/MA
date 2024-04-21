section .data

arr64 dq -21H,5FH,-33H,11H,62H
n equ 5
pmsg db 10,10,"The number of Positiveve elements from 64 bit array."
pmsg_len equ $-pmsg
nmsg db 10,10,"The number of negative elements from 64 bit array."
nmsg_len equ $-nmsg

section .bss

p_count resq 1
n_count resq 1
char_ans resb 16

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text

global _start
_start:

mov rsi,arr64
mov rcx,n
mov rbx,0
mov rdx,0

next_num:

mov rax,[rsi]
rol rax,1
jc negative

positive:
inc rbx
jmp next

negative:
inc rdx

next:
add rsi,8
dec rcx
jnz next_num
mov[p_count],rbx
mov[n_count],rdx
print pmsg,pmsg_len
mov rax,[p_count]
call display
print nmsg,nmsg_len
mov rax,[n_count]
call display
Exit

display:

mov rbx,10
mov rcx,2
mov rsi,char_ans+1

cnt:
mov rdx,0
div rbx
cmp dl,09H
jbe add30
add dl,07H

add30:
add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz cnt
print char_ans,2
ret
