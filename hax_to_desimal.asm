
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

;hax to desimal 
mov ax,900h
mov ds,ax
mov si,10  
mov di,15
mov [2],'1'
mov [4],'2'
mov [6],'3'
mov [8],'4' 
mov [10],'5' 
mov [12],'6' 
mov [14],'7' 
mov [16],'8' 
mov [18],'9' 
mov [20],'10'
mov [22],'11'
mov [24],'12'
mov [26],'13'   
mov [28],'14'
mov [30],'15'
mov ah,2
   


mov bl,0Ah ;hex vlue here

anotherDigit:
mov si,0
mov cx,0
rep_inner:  
shl si,1   ;left shift
test bl,10000000b ; checking if the first bit is zerro or not 
;if first bit bf bl is 1 then zflag is 0
jz cu  
add si,1b
cu:

shl bl,1   ; left shif 
inc cx    ;increment counter to check if we iter 4bit 
cmp cx,4
jl rep_inner  
shl si,1 ; left shift to [ si=si*2]
cmp si,20
jge a
jmp lastBitChecker
a:
mov dl,[si][1]
int 21h; 
lastBitChecker:   
mov dl,[si]
int 21h 


test bl,bl
jnz anotherDigit
hlt











ret




