org 0100h
;pide una cadena
mov dx, offset buffer
mov ah, 0ah
int 21h

;declaracion de la cadena
jmp print
buffer db 10,?,10 dup('  ')

print:
xor bx,bx ;mov bx,0d
mov bl,buffer[1];almacena en bl la longitud de la cadena
mov buffer[bx+2],'$';signo de pesos al final de la cadena
mov dx, offset buffer + 2
mov ah, 9
int 21h
ret;El comilador soporta esta directiva para terminar el programa