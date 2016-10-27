;Programa 5.- Compara 2 cadenas y dice con la letra \u2018S\u2019 si son iguales, o \u2018N\u2019 si no lo son
org 0100h
cld
;CLD es para limpiar la Bandera de Direccion DF
jmp eti0
cad0 db 'Tecno'
cad1 db 'Tecno'
eti0:
lea si,cad0
;SI = La direcci�n inicial de la PRIMERA cadena
lea di,cad1
;DI = La direcci�n inicial de la SEGUNDA cadena
mov cx,5
;CX = Cantidad de caracteres a comparar (longitud de cadena)
repe cmpsb
jnz eti1
;Repite la comparaci�n hasta que CX sea igual a 0, o se encuentre una diferencia (SI, DI)
;Salta a ETI1 si la bandera de Zero (ZF) es diferente de cero (o sea ZF=1)
;Si son Iguales
mov ah,02h
mov dl,'S'
int 21h
;INT 21H funcion 02H, desplegar caracter en pantalla (la letra \u2018S\u2019)
jmp fin
;Brinca al fin del programa
eti1:
;No son Iguales
mov ah,02h
mov dl,'N'
int 21h
;INT 21H funcion 02H, desplegar caracter en pantalla (la letra \u2018N\u2019)
fin:
mov ah,07h
int 21h
;INT 21H funcion 07H, espera que se oprima tecla
int 20h