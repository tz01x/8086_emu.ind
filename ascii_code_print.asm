
    mov cx,0    ; set cx value to 0

    loop_i:
    mov bx,cx   ; move the cx value to bx
    mov cx,10   ; move 10 to cx for to run loop sequence to run 10 times


    loop_j:

    ; in order to write to console, or print a ascii value to console  oration to work
    ; set ah to 2
    ; then DL register contain the actual value which is printed in the console , then why BL value gets move to DL

    ; then interrupt handler get call for  printing

    mov ah,2
    mov dl,bl
    int 21h


    inc bl ; increment BL register value

    ;BL register value get compare with 255
    cmp bl,255
    ; if BL value equal to 255 then its jump to exit label
    je exit

    ; loop instruction check if cx is zero or not then  exit form this loop sequence other wise jump to label loop_j
    loop loop_j

    ; again as before calling interrupt to print to console
    ; this time specific ascii value get print, which is newline(10) and Carriage Return(13)
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h

    ; again incrementing bl because current bl value is already printed to console
    inc bl
    ;move bx value to cx
    mov cx,bx
    loop loop_i
    exit:
    ret

