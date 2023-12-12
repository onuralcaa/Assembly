org 100h

;Klavyeden girilen bir sayiyi hex to dec asm kodu
;MAX 4 Haneli bir sayi girilmeli
;4 ten daha fazla sayi girilmesi halinde
;son 4 hanesini alinir.
   
   lea dx,m1
   mov ah,9
   int 21h
   
   mov cl,4
   mov bx,0
   
   sayi_gir:
   
    mov ah,1 ; klavyeden bir sayi girilene kadar bekle
    int 21h
    
    cmp al,13
        je Saycevir
        sub al,48
        
            cmp al,9
            jle gec
            sub al,7     
                gec:
                
        shl bx,cl
        add bl,al
       jmp sayi_gir
               
    Saycevir:           
          
   mov ax,bx
   lea si, dizi[5]
   mov cl,0 ;onluk basamak sayisi
   mov bx, 0Ah ;veya '10' - ilk basamak hex formatinda ise basa sifir yazilir.
             
   mov dx,0
             
  cevir:
    div bx  ;dx : kalan , ax : bolum
    dec si
    mov [si],dl
    inc cl
    mov dl,0
    and ax,ax
   
   jnz cevir
   
   lea dx,m2
   mov ah,9
   int 21h
   
   yaz:
        mov dl,[si]
        add dl,48
        mov ah,2
        int 21h
        inc si
        dec cl
   jnz yaz 

ret

dizi DB 5 

m1 db 10,13, 'Bir hex sayi giriniz : $'
m2 db 10,13, 'Hex-->Dec : $'

