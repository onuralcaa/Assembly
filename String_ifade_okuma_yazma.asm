org 100h 

;program kodu
    
    lea dx, mesaj
    mov ah, 9
    int 21h  
      
    lea dx, m1
    mov ah, 10
    int 21h            
             
    mov bx,00h ;bu adres kullanýlacak
    mov bl, m1[1] ; offset m1+1 iþlemi
    
    mov m1[bx+2],'$' ; bu adrese $ iþareti koy
    
    lea dx, yaz
    mov ah, 9
    int 21h
             
    lea dx, m1[2]
    mov ah, 9
    int 21h
    
             
             
ret 

mesaj db 'Bir kelime giriniz : $'
yaz db 10,13, 'Girilen kelime : $'
m1 db 10, ?, 10 dup (?) 

