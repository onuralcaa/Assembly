      
org 100h
    
;0-9 arasindaki en kucuk rakami bulup ekrana yazdirma    
;Kucukten buyuge siralama
    
    ;m1 ekrana yazdir
    lea dx, m1
    mov ah,9
    int 21h
    
    lea si , dizi[0] ; baslangic adresi alindi.
    
    mov cx, 6 
    
    
    
    d1_yaz:    
        mov dl,[si]
        add dl, 30h
        mov ah,2
        int 21h
     
        mov dl, ','
        mov ah,2
        int 21h
        
        inc si
    loop d1_yaz 
              
    lea si , dizi[0] ; baslangic adresi alindi. 
    mov cx,5
    mov dx,6
    sirala: 
        mov al, [si]
        mov bx,6
        sub bx,cx
    devam:
        cmp dizi[bx], al ;al=dizi[0]       
        jg gec  ;yer degistirme
            mov ah, dizi[bx]
            mov dizi[bx],al
            mov al,ah
            mov [si],al
        gec:    
        
        inc bx
        cmp bx,dx
        
    jl devam 
    
    inc si
         
    loop sirala         
              
              
              
        lea dx,m2
        mov ah,9 
        int 21h
        
        
        lea si , dizi[0] ; baslangic adresi alindi.
        mov cx, 6 
        
        d2_yaz:    
        mov dl,[si]
        add dl, 30h
        mov ah,2
        int 21h
     
        mov dl, ','
        mov ah,2
        int 21h
        
        inc si
    loop d2_yaz 
        
ret

dizi db 5,2,8,6,0,1
  
m1 db 10,13, 'Dizi elemanlari : $'

m2 db 10,13, 'Kucukten buyuge : $'