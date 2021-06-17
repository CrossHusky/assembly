.MODEL SMALL
.STACK
;Segmento de pila

.DATA
;Segmento de datos

 archivo DB 'C:\emu8086\vdrive\B\test.txt',00h
manejador DW 0
escribir DB 'Hola alumnos de Sistemas'
leer DB 40 DUP(?)
.CODE
;Segmento de codigo

inicio:
MOV AX,@DATA
MOV DS,AX
;Mi codigo
;Creamos un archivo en una ruta especificada
MOV AH,3Ch
MOV CX,00h
MOV DX,OFFSET archivo
INT 21h
;Abrimos un archivo en una especificada
MOV AH,3Dh
MOV AL,02h
MOV DX,OFFSET archivo
INT 21h
;Modificamos un archivo abierto anteriormente
MOV manejador,AX
MOV AH,40h
MOV BX,manejador
MOV CX,18h
MOV DX,OFFSET escribir
INT 21h
;cerrar archivo
MOV manejador,AX
MOV AH,3Eh
MOV BX,manejador
INT 21h
;Abrimos un archivo en una especificada
MOV AH,3Dh
MOV AL,02h
MOV DX,OFFSET archivo
INT 21h
;lectura de un archivo abierto anteriormente
MOV manejador,AX
MOV AH,3Fh
MOV BX,manejador
MOV CX,04h
MOV DX,OFFSET leer
INT 21h
;Cerrar el archivo que se abrio
MOV manejador,AX
MOV AH,3Eh
MOV BX,manejador
INT 21h
MOV AH,4Ch
INT 21h
END inicio
END
