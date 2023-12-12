org 100h

;hex to dec asm kodu

   mov ax,3A8Bh
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