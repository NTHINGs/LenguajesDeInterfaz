org 0100h
jmp eti0
cad0 db 'Olguinguinguinguinguinguinguinguinguin',0ah,0dh,'$'
eti0:
mov cx,10d

eti1:
mov ah,09h
lea dx, cad0
int 21h

dec cx ;Decrementa registro
cmp cx,0 ;Compara el registro
jne eti1 ;Salta si no es igual la comparación de la linea anterior

mov ah,07h
int 21h
int 20h