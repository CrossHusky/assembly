include 'emu8086.inc'

MACRO SALTO
    MOV AH,2 
    MOV DL, 0Ah 
    INT 21h
    MOV DL, 0Dh 
    INT 21h  
ENDM

.MODEL SMALL

.STACK 100h

.DATA
    ;vectorDesordenado   DW  0,630,50,1,5,3,812,24,17,890,9,2,44,256,128,32,10,9999,4,69
    vectorDesordenado   DW  90,70,80,50,60,30,40,10,20,5,4,8,9,7,6,3,99,1,2,0
    varTama�o           DW  38   
    
    ;(20*2)-(2) | 20 <- Tama�o del vector | 2 <- Tama�o del elemento |   
    ; Insertion Sort va hasta [Tama�o del vector - 1]
    ; Entonces, [40 - 2] = [38] 
    ; vectorDesordenado es el "vector" no ordenado
    ; varTama�o almacena el tama�o del vector
    ; SI almacena la posici�n [n] 
    ; DI almacena la posici�n [n - 1]
    ; AX almacena el [tama�o] del vector
    ; BX almacena el valor en la posicion [n]
    ; CX almacena el valor en la posicion [n-1]
    

.CODE 
    MOV AX, @DATA
    MOV DS, AX

main PROC 

    CALL insertionSort ; Llama al procedimiento para ordenar
    CALL print_arr     ; Llama al procedimiento para imprimir

.EXIT
ENDP main

insertionSort PROC 
    
    MOV SI, 2           ; Cargo la posici�n 1
    MOV AX, varTama�o   ; Cargo el tama�o del vector

        for_loop:
            CMP SI, AX  ; Si SI > AX ir a end_for_loop
            JG end_for_loop

            while_loop:
                MOV DI, SI ; Cargo SI a DI
                SUB DI, 2  ; Le resto 2 (Regreso una posici�n)
                MOV BX, vectorDesordenado[SI] ; Posici�n actual a BX
                MOV CX, vectorDesordenado[DI] ; Posici�n anterior a CX
                CMP SI, 0
                JLE end_while

                CMP CX, BX
                JLE end_while

                MOV vectorDesordenado[SI], CX
                MOV vectorDesordenado[DI], BX
                SUB SI, 2
                JMP while_loop
            
            end_while:
                ADD SI, 2
                JMP for_loop  
        end_for_loop:
            RET
             
endp insertionSort

print_arr PROC
    MOV SI, 0 
    print "I N S E R T I O N  S O R T"
    SALTO 
    print "El vector ordenado es: "
    SALTO

start_print:
    MOV AX, varTama�o
    CMP SI, AX 
    JG end_print 
    MOV AX, vectorDesordenado[SI]
    print "["
    CALL print_num
    print "]"  
    ADD SI,2
    JMP start_print 

end_print:
    RET 

ENDP print_arr

;Necesario para usar las funciones de impresi�n incluidas en emu8086.inc
define_print_num
define_print_num_uns