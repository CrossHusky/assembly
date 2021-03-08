include 'emu8086.inc'

.MODEL SMALL

.STACK 100h

.DATA 

;vectorDesordenado   DW  0,630,50,1,5,3,812,24,17,890,9,2,44,256,128,32,10,9999,4,69
vectorDesordenado   DW  90,70,80,50,60,30,40,10,20,5,4,8,9,7,6,3,99,1,2,0
varTamaño           DW  38  ;(20*2)-(2) | 20 <- Tamaño del vector | 2 <- Tamaño del elemento |
varIntercambio      DW  0   ;Insertion Sort va hasta [Tamaño del vector] - [1]
nSI                 DW  0   ;Entonces, [40 - 2] = [38] 
nAX                 DW  0   ; vectorDesordenado es el "vector" no ordenado
nDX                 DW  0   ; SI almacena el valor de i 
                            ; DI almacena el valor de j
                            ; AX almacena el tamaño del vector
                            ; BX almazena el tamaño-1 del vector
                            ; varTamaño almacena el aamaño del vector

.CODE 

MOV AX, @data
MOV DS, AX

main PROC 

CALL insertionSort
;CALL print_arr  

.EXIT
ENDP main

insertionSort PROC 
MOV SI, 2
MOV AX, varTamaño 

for_loop:
CMP SI, AX
JG end_for_loop


while_loop:
MOV DI, SI
SUB DI, 2
MOV BX, vectorDesordenado[SI]
MOV CX, vectorDesordenado[DI]
CMP SI, 0
JLE end_while



CMP CX, BX
JLE end_while

MOV varIntercambio, BX 
MOV BX, CX
MOV CX, varIntercambio
MOV vectorDesordenado[SI], BX
MOV vectorDesordenado[DI], CX
SUB SI, 2
JMP while_loop
end_while:
ADD SI, 2
JMP for_loop  
end_for_loop:
RET 
endp insertionSort

print_arr PROC
; Set the variables, So I wont lost the value of these registers 
MOV nSI, SI
MOV nAX, AX
MOV nDX, DX
MOV SI, 0 
MOV AH,2 

MOV DL, 0Ah 
INT 21h
MOV DL, 0Dh 
INT 21h 
print "El vector ordenado es: "
start_print:
MOV AX, varTamaño
CMP SI, AX 
JG end_print 
; Print the array content

MOV AX, vectorDesordenado[SI]
CALL print_num


;New line and carriage return


print " "  
ADD SI,2
JMP start_print 


end_print:
MOV ah,2 

MOV DL, 0Ah 
INT 21h
MOV DL, 0Dh 
INT 21h  
MOV SI, nSI			   
MOV AX, nAX
MOV DX, nDX 
RET 

ENDP print_arr



;Necesario para usar las funciones de emu8086.inc
define_scan_num 
define_print_num
define_print_num_uns