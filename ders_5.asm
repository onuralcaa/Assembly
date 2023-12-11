org 100h 


;iki decimal sayinin toplamýný decimal olarak ekrana yazdirma
   
   jmp gec
   m1 db 10,13, 'Birinci sayi : $'         
   m2 db 10,13, 'Ikinci sayi : $'
   m3 db 10,13, 'Toplam : $'
   gec:
   
   ;-----------sayi1--------------
   lea dx, m1
   mov ah,9
   int 21h
   
   mov ah,1 ;klavyeden deger bekleme
   int 21h
   
   sub al,48 ;rakam degeri alma 
   mov bl,al ;yedekleme 
   
   ;---------sayi2----------------
   
   lea dx, m2
   mov ah,9
   int 21h
   
   mov ah,1 ;klavyeden deger bekleme
   int 21h
   
   sub al,48 ;rakam degeri alma 
   
   
   add al,bl
   daa  ;decimal e cevirme
   mov bl,al
   
   lea dx , m3
   mov ah,9
   int 21h             
    
   mov cl,4
   mov ch,2
   
   ;----yazdirma dongusu-------
   devamBl:
   rol bl,cl
   mov dl,bl
   and dl, 0Fh
   add dl, 48
   
   mov ah,2
   int 21h
   
   dec ch
   jnz devamBl
   
   
   
   
   
   
   
ret