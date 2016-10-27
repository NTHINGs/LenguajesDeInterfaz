;Programa contraseña
org 0100h           
jmp eti0
cad0 db 'Password: $'
cad1 db 'Su pass es: $'
cad2 db 0ah,0dh,'$'
cad3 db '          ' ;Buffer de 10 espacios

eti0:
mov ah,09h
lea dx,cad0
int 21h              ;Despliega cad0

lea bx,cad3          ;Almacenar en BX direccion inicial del buffer

eti1:
mov ah,01h
int 21h              ;Pregunta caracter SIN que se visualice
cmp al,0dh           ;0DH=ASCII DEL ENTER
je eti2
inc al
mov [bx],al          
inc bx               ;Incrementa posicion del buffer  

jmp eti1

eti2:
mov [bx],'$'
mov ah,09h
lea dx,cad2
int 21h  

mov ah,09h
lea dx,cad1
int 21h  

mov ah,09h
lea dx,cad3
int 21h

mov ah,07h
int 21h
   
int 20h