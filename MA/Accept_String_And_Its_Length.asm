section .data
msg db 10,10,"Enter the string "
msg_len equ $-msg
smsg db 10,"The length of string is "
smsg_len equ $-smsg

section .bss
string resb 50
stringl equ $-string
count resb 1
char_ans resb 2

%macro print 2
MOV rax, 1
MOV rdi, 1
MOV rsi, %1
MOV rdx, %2
syscall
%endmacro

%macro read 2
MOV rax, 0
MOV rdi, 0
MOV rsi, %1
MOV rdx, %2
syscall
%endmacro

%macro exit 0
MOV rax, 60
MOV rdi, 0
syscall
%endmacro

section .text
global _start
_start:
print msg, msg_len
read string, stringl
MOV [count], rax
print smsg, smsg_len
MOV rax, [count]
call display
exit

display:
MOv rbx, 10
MOV rcx, 2
MOV rsi, char_ans+1
cnt: MOV rdx, 0
div rbx
cmp dl, 09h
jbe add30
add dl, 07h
add30:
add dl, 30h
MOV [rsi], dl
dec rsi
dec rcx
jnz cnt
print char_ans, 2
ret
