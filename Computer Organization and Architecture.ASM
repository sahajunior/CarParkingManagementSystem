.model small
.stack 100h
.data

menu db 'CAR PARKING SYSTEM MENU$'

menu1 db '1-> Park Class-A cars (Sedan/Coupe).$'
menu2 db '2-> Park Class-B cars (SUV/Minivan).$'
menu3 db '3-> Park Class-C cars (Pickup/Minitruck).$'
menu4 db '4-> Record Database.$'
menu5 db '5-> Delete Record Database.$'
menu6 db '6-> Exit.$'

msg1 db 'Parking is full.$'
msg2 db 'Wrong Input!$'
msg3 db 'Class-B$'
msg4 db 'Class-C$'
msg5 db 'Record$'
msg6 db 'Free space not available.$'
msg7 db 'Total amount is = $'
msg8 db 'Total vehicles parked = $'
msg9 db 'Total Class-A car parked = $'
msg10 db 'Total Class-B car parked = $'
msg11 db 'Total Class-C car parked = $'
msg12 db 'Record Deleted Successfully.$'

amount dw 0
count dw '0'

A dw '0'
B db '0'
C db '0'

.code
main proc
    mov ax,@data
    mov ds,ax

; Menu Process
while_:
    mov dx,10
    mov ah,2
    int 21h

    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset menu
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset menu1
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset menu2
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset menu3
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset menu4
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    mov dx,offset menu5
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h


    mov dx,offset menu6
    mov ah,9
    int 21h
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    ;Take input from user in decimal.
    mov ah,1
    int 21h
    mov bl,al
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    ;Compare in Queue.
    mov al,bl
    cmp al,'1'
        je classA
    cmp al,'2'
        je classB
    cmp al,'3'
        je classC
    cmp al,'4'
        je record
    cmp al,'5'
        je delete
    cmp al,'6'
        je exit

    ; If user enters any other option than (1 to 6)
    mov dx,offset msg2
    mov ah,9
    int 21h
    
    ; Go back to while_ (Menu Process)
    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h
    jmp while_
    
    ; When users input is right and refers to specific method
    classA:
        call class_a
    classB:
        call class_b
    classC:
        call class_c
    record:
        call _record
    delete:
        call _delete


exit:
    mov ah,4ch
    int 21h

main endp

; Procedure for ClassA cars
class_a proc
    cmp count,'8'
    jle _class_a
    mov dx,offset msg1
    mov ah,9
    int 21h
    jmp while_
    jmp exit

_class_a:
    mov ax,50         
    add amount, ax
    mov dx,0
    mov bx,10 
    mov cx,0

level1A:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne level1A        
   
level2A:
        pop dx
        add dx,48
        mov ah,2
        int 21h
        loop level2A
        inc count
        inc A
        jmp while_
        jmp exit

; Procedure for ClassB cars
class_b proc
    cmp count,'8'
    jle _class_b
    mov dx,offset msg1
    mov ah,9
    int 21h
    jmp while_
    jmp exit

_class_b:
    mov ax,75
    add amount, ax
    mov dx,0
    mov bx,10
    mov cx,0

level1B:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne level1B
   
level2B:
        pop dx
        add dx,48
        mov ah,2
        int 21h
        loop level2B
        inc count
        inc B
        jmp while_
        jmp exit

; Procedure for ClassC cars
class_c proc
        cmp count,'8'
        jle _class_c
        mov dx,offset msg1
        mov ah,9
        int 21h
        jmp while_
        jmp exit

_class_c:
        mov ax,100
        add amount,ax
        mov dx,0
        mov bx,10
        mov cx,0

level1C:
        div bx
        push dx
        mov dx,0
        mov ah,0
        inc cx
        cmp ax,0
        jne level1C
   
level2C:
        pop dx
        add dx,48
        mov ah,2
        int 21h
        loop level2C
        inc count
        inc C
        jmp while_
        jmp exit

; Procedure for Record
_record proc
    mov dx,offset msg7
    mov ah,9
    int 21h

    mov ax, amount
    mov dx,0
    mov bx,10
    mov cx,0

totalpush:
        div bx
        push dx
        mov dx,0
        inc cx
        cmp ax,0
        jne totalpush
   
totalprint:
        pop dx
        add dx,48
        mov ah,2
        int 21h
        loop totalprint

        mov dx,10
        mov ah,2
        int 21h
        mov dx,13
        mov ah,2
        int 21h

        mov dx,offset msg8
        mov ah,9
        int 21h

        mov dx,count
        mov ah,2
        int 21h

        mov dx,10
        mov ah,2
        int 21h
        mov dx,13
        mov ah,2
        int 21h


        mov dx,offset msg9
        mov ah,9
        int 21h

        mov dx,A
        mov ah,2
        int 21h

        mov dx,10
        mov ah,2
        int 21h
        mov dx,13
        mov ah,2
        int 21h

        mov dx,offset msg10
        mov ah,9
        int 21h


        mov dl,B
        mov ah,2
        int 21h

        mov dx,10
        mov ah,2
        int 21h
        mov dx,13
        mov ah,2
        int 21h

        mov dx,offset msg11
        mov ah,9
        int 21h

        mov dl,C
        mov ah,2
        int 21h

        jmp while_
        jmp exit

; Procedure Delete Record
_delete proc
    mov A,'0'
    mov B,'0'
    mov C,'0'
    mov amount,0
    mov count,'0'
    mov dx,offset msg12
    mov ah,9
    int 21h

    mov dx,10
    mov ah,2
    int 21h
    mov dx,13
    mov ah,2
    int 21h

    jmp while_
    jmp exit

end main