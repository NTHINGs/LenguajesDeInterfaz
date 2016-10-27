org 0100h
jmp eti0
cad0 db 'PAR$'
cad1 db 'NON$' 

eti0:
mov ax,999d
and ax,0000000000000001b
cmp ax,1d
je Non
mov ah,09h
lea dx,cad0
int 21h
jmp eti1 

Non:
mov ah, 09h
lea dx,cad1
int 21h

eti1:
mov ah,07h
int 21h

int 20h