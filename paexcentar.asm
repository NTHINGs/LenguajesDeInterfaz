org 0100h
jmp eti0
cad0 db 0dh,0ah,'$'
cad1 db 'TECNO$'

eti0:
mov cx,10d 
mov bx,10d

eti1:
mov ah,09h
lea dx,cad1
int 21h
mov cx,10d

eti2:
mov ah,02h
mov dl,'$'
int 21h
loop eti2

mov ah,09h
lea dx,cad0
int 21h
dec bx
cmp bx,0
jne eti1 

mov ah,07h
int 21h
int 20h