include 'emu8086.inc'

MACRO BREAK
    MOV AH,2 
    MOV DL, 0Ah 
    INT 21h
    MOV DL, 0Dh 
    INT 21h  
ENDM

MACRO SWAP
    MOV vectorDesordenado[SI], CX
    MOV vectorDesordenado[DI], BX    
ENDM

.MODEL SMALL

.STACK 100h

.DATA
    ;vectorDesordenado   DW  0,630,50,1,5,3,812,24,17,890,9,2,44,256,128,32,10,9999,4,69
    vectorDesordenado   DW  90,70,80,50,60,30,40,10,20,5,4,8,9,7,6,3,99,1,2,0
    tamañoVector        DW  40 ; 38  
    
    ;(20*2)-(2) | 20 <- Tamaño del vector | 2 <- Tamaño del elemento |   
    ; Insertion Sort va hasta [Tamaño del vector] o [Tamaño del vector - 1]
    ; Entonces, [40 - 2] = [38] 
    ; vectorDesordenado es el "vector" no ordenado
    ; tamañoVector almacena el tamaño del vector
    ; SI almacena la posición [n] 
    ; DI almacena la posición [n - 1]
    ; AX almacena el [tamaño] del vector
    ; BX almacena el valor en la posicion [n]
    ; CX almacena el valor en la posicion [n-1]
    

.CODE 
    MOV AX, @DATA
    MOV DS, AX

main PROC 

    CALL insertionSort                          ; Llama al procedimiento para ordenar
    CALL printArray                             ; Llama al procedimiento para imprimir

.EXIT
ENDP main

insertionSort PROC 
    
    MOV SI, 2                                   ; Cargo la posición 1
    MOV AX, tamañoVector                        ; Cargo el tamaño del vector

        for:
            CMP SI, AX                          ; Si SI > AX ir a end_for
            JE end_for

            while:
                MOV DI, SI                      ; Cargo SI a DI
                SUB DI, 2                       ; Le resto 2 (Regreso una posición)
                MOV BX, vectorDesordenado[SI]   ; Posición actual a BX
                MOV CX, vectorDesordenado[DI]   ; Posición anterior a CX
                CMP SI, 0 
                JLE end_while

                CMP CX, BX                      ; Si es menor o igual no hace falta ordenar
                JLE end_while

                SWAP                            ; Intercambio los valores
                SUB SI, 2                       ; Decrementa SI
                JMP while
            
            end_while:
                ADD SI, 2                       ; Incrementa SI
                JMP for 
                 
        end_for:
            RET
             
ENDP insertionSort

printArray PROC
    MOV SI, 0 
    print "I N S E R T I O N  S O R T"
    BREAK 
    print "El vector ordenado es: "
    BREAK

start_print:
    MOV AX, tamañoVector
    CMP SI, AX 
    JE end_print 
    MOV AX, vectorDesordenado[SI]
    print "["
    CALL print_num
    print "]"  
    ADD SI,2
    JMP start_print 

end_print:
    RET 

ENDP printArray

;Necesario para usar las funciones de impresión incluidas en emu8086.inc
define_print_num
define_print_num_uns