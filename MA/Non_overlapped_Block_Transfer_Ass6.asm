section .data
nline db 10,10
nline_len equ $-nline
space db " "

bmsg db 10,"Before Transfer::"
bmsg_len equ $-bmsg
amsg db 10,"After Transfer::"
amsg_len equ $-amsg
smsg db 10," Source Block :"
smsg_len equ $-smsg
dmsg db 10," Destination Block :"
dmsg_len equ $-dmsg
sblock db 11h,22h,33h,44h,55h
dblock times 5 db 0

section .bss
char_ans resB 2

%macro Print 2
MOV RAX,1
MOV RDI,1
MOV RSI,%1
MOV RDX,%2
syscall
%endmacro

%macro Read 2
MOV RAX,0
MOV RDI,0
MOV RSI,%1
MOV RDX,%2
syscall
%endmacro

%macro Exit 0
Print nline,nline_len
MOV RAX,60
MOV RDI,0
syscall
%endmacro

section .text
global _start
_start:

Print bmsg,bmsg_len
Print smsg,smsg_len
mov rsi,sblock
call disp_block
Print dmsg,dmsg_len
mov rsi,dblock 
call disp_block
call BT_O
Print amsg,amsg_len
Print smsg,smsg_len
mov rsi,sblock
call disp_block
Print dmsg,dmsg_len
mov rsi,dblock
call disp_block
Exit

BT_O:
mov rsi,sblock
mov rdi,dblock 
mov rcx,5
back: mov al,[rsi] 
mov [rdi],al
inc rsi
inc rdi
dec rcx
jnz back
RET

disp_block:
mov rbp,5
next_num:
mov al,[rsi]
push rsi
call Disp_8
Print space,1
pop rsi
inc rsi
dec rbp
jnz next_num
RET

Disp_8:
MOV RSI,char_ans+1
MOV RCX,2 
MOV RBX,16 
next_digit:
XOR RDX,RDX
DIV RBX
CMP DL,9
JBE add30
ADD DL,07H
add30 :
ADD DL,30H
MOV [RSI],DL
DEC RSI
DEC RCX
JNZ next_digit
Print char_ans,2
ret
