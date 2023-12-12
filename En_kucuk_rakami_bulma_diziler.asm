
org 100h
    
;0-9 arasindaki en kucuk rakami bulup ekrana yazdirma    
    
    ;m1 ekrana yazdir
    lea dx, m1
    mov ah,9
    int 21h

    lea si , dizi[0] ; baslangic adresi alindi.
    mov bl, '9'
    
    mov cx, 6
    
    d_yaz:    
        mov dl,[si]
        add dl, 30h
        mov ah,2
        int 21h
        
        cmp bl,dl ;sayilari karsilastirma
        jl degis
            mov bl,dl
        degis:
        
        
        
        mov dl, ','
        mov ah,2
        int 21h
        
        inc si
    loop d_yaz 

        lea dx,m2
        mov ah,9 
        int 21h
        
        mov dl,bl
        mov ah,2
        int 21h
        
ret

dizi db 5,2,8,6,0,1
  
m1 db 10,13, 'Dizi elemanlari : $'

m2 db 10,13, 'En kucuk eleman : $'