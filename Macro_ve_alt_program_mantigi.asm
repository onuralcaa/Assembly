m3_yaz macro m_add
    ;toplam yazdirma
    lea dx,m3
    mov ah,9
    int 21h
endm

org 100h

devam:

;iki basamakli iki decimal
;sayinin toplamini decimal olarak
;ekrana yazdirma
                        
call m1_yaz ;alt program cagirma

mov ah,1
int 21h

cmp al,13  ;condition
jne dev1
int 20h ; program sonu
dev1:                        
                        
sub al,48 ; asci karsiligini alma
mov bl,al ; yedekleme

mov ah,1
int 21h
           
cmp al,13
je dev2  
    sub al,48
    mov cl,4
    shl bl,cl ; bl deki sayiyi cl deki sayi kadar otele    
    add bl,al   
dev2:
         

call m2_yaz ;alt program cagirma

mov ah,1
int 21h  

sub al,48 ; asci karsiligini alma
mov ch,al ; yedekleme  

mov ah,1
int 21h
     
je dev3  
    sub al,48
    mov cl,4
    shl ch,cl ; bl deki sayiyi cl deki sayi kadar otele    
    add ch,al   
dev3:
;toplama islemi
mov bh,0                        
mov al,ch
add al,bl ; toplama
daa ; decimale cevirme
adc bh,0 ; bh = [bh] + 0 + [C]
mov bl,al

m3_yaz m3 ; macroya parametre gönderme, parametresiz de kullanýlabilir.

        
mov cl,4
mov ch,3

rol bx,cl
devamBX:
    rol bx,cl
    mov dl,bl
    and dl, 0Fh
    add dl,48
    
    mov ah,2 ; bl deki degeri ekrana yazdir
    int 21h    
    
    dec ch
    jnz devamBX
    
    jmp devam
ret   

m1 db 10,13, 'Birinci sayi : $'
m2 db 10,13, 'Ikinci sayi : $'
m3 db 10,13, 'Toplam :$ '

m1_yaz proc
    ;1. basamak bl de
    lea dx,m1
    mov ah,9
    int 21h 
    ret
endp  

m2_yaz proc
    ;2. basamak ch da
    lea dx,m2
    mov ah,9
    int 21h
    ret
endp

