org 100h 

m_yaz equ 9

;program kodu

    lea dx, m1
    mov ah, m_yaz
    int 21h
    
    mov ah,1
    int 21h
    
    push ax
    
    lea dx, m2
    mov ah, m_yaz
    int 21h
    
    pop dx
    
    mov ah,2
    int 21h
       
ret  

m1 db 10,13,'Bir tusa basiniz : $'
m2 db 10,13,'Basilan tus : $'
