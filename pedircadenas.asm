;Pregunta una cadena, le da formato
org 0100h
jmp eti0

cad0 db 10,?,10 dup('  ');cad0 es el nombre de buffer, db,  ,?, duplica 10 veces este simbolo)

eti0:
mov ah,0ah ;FUncion 0ah para pedir cadena
mov dx, offset cad0; DX=Direccion de la cadena
int 21h
mov ah,02h;Funcion para desplegar caracter
mov dl,0dh ;ASCII del caracter a desplegar
int 21h
mov ah,02h;Funcion para desplegar carácter
mov dl,0ah
int 21h
;formatear cadena
lea dx,cad0
mov bx,dx
mov al,[bx+1]
mov ah,00h
add bx,ax
add bx,2
mov [bx],'$'

mov ah,09h
lea dx, cad0
add dx,2
int 21h
mov ah,07h
int 21h
int 20h