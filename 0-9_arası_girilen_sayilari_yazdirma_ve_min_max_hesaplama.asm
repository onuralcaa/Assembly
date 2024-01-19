


 ;Bu program 0-9 arasýnda girilen 9 adet sayýyý ekrana yazdýrýr ve min, max deðerlerini hesaplar.



org 100h

m_yaz equ 9
sayi_adeti equ 9

; Program baþlangýcý
    mov cx, sayi_adeti   ; Sayý adetini CX register'ýna yükle
    lea di, sayilar      ; 'sayilar' dizisinin adresini DI register'ýna yükle
    xor bx, bx           ; BX register'ýný sýfýrla (sayý sýrasýný tutmak için)

Anadongu:
    inc bx               ; Sayý sýrasýný arttýr

    ; Sayý sýrasýný ve "Sayýyý giriniz: " mesajýný yazdýr
    push cx              ; CX register'ýný yýðýna kaydet
    mov ah, 02h          ; Ekrana karakter yazdýrma fonksiyonunu ayarla
    mov dl, '0'          ; ASCII '0'
    add dl, bl           ; Sayý sýrasýný ASCII karaktere çevir
    int 21h              ; Sayý sýrasýný ekrana yazdýr
    lea dx, mesaj        ; 'mesaj' adresini DX register'ýna yükle
    mov ah, m_yaz        ; Ekrana yazdýrma fonksiyonunu ayarla
    int 21h              ; Mesajý ekrana yazdýr
    pop cx               ; CX register'ýný yýðýndan geri yükle

    ; Kullanýcýdan sayý giriþi al
    mov ah, 01h          ; Klavyeden bir karakter okumak için fonksiyonu ayarla
    int 21h              ; Klavyeden karakter oku ve AL register'ýna yükle
    cmp al, 13           ; Carriage return ile karþýlaþtýr
    je  cikis            ; Eðer carriage return ise çýkýþ yap
    mov [di], al         ; Okunan karakteri 'sayilar' dizisine kaydet
    inc di               ; 'sayilar' dizisinin bir sonraki adresine geç

    ; Yeni satýra geçmek için CR ve LF gönder
    mov ah, 02h          ; Ekrana karakter yazdýrma fonksiyonunu ayarla
    mov dl, 13           ; Carriage return
    int 21h              ; Ekrana CR yazdýr
    mov dl, 10           ; Line feed
    int 21h              ; Ekrana LF yazdýr

    loop Anadongu   ; CX sýfýr olana kadar döngüyü tekrarla
    
    
     CALL yazdir  ;en sonda sayilari ekrana yazdirma
     CALL BulEnKucukEnBuyuk   
 
cikis: 
    ret                  ; Programdan çýk

;tanimlamalar
sayilar db sayi_adeti dup('?')  ; Giriþ için sayýlarý tutacak dizi
mesaj db '. Sayiyi giriniz: $'   ; Kullanýcýya gösterilecek mesaj
enkucuk db ' En kucuk sayi : $'
enbuyuk db ' En buyuk sayi : $'

yazdir proc              ;sayýlarý ekrana yazdýran alt program
    mov cx, sayi_adeti   ; Sayý adetini CX register'ýna yükle
    mov di, offset sayilar ; 'sayilar' dizisinin offset'ini DI register'ýna yükle

dongu:
    mov dl, [di]           ; Diziden bir sonraki sayýyý DL register'ýna yükle

    mov ah, 02h  
    int 21h
    
    inc di               

    mov dl, ','            
    mov ah, 02h
    int 21h

    loop dongu
endp  

; En küçük ve en büyük sayýyý bulan alt program
BulEnKucukEnBuyuk proc
    mov cx, sayi_adeti      ; Sayý adetini CX register'ýna yükle
    lea si, sayilar         ; 'sayilar' dizisinin adresini SI register'ýna yükle
    mov al, [si]            ; Ýlk sayýyý AL register'ýna yükle
    mov bl, al              ; En küçük sayýyý BL register'ýna yükle
    mov bh, al              ; En büyük sayýyý BH register'ýna yükle

bul_dongu:
    inc si                  ; Bir sonraki sayýya geç
    mov al, [si]            ; Yeni sayýyý AL register'ýna yükle
    cmp al, bl              ; Mevcut sayýyý en küçük ile karþýlaþtýr
    jnb sonraki_karsilastirma ; Eðer büyük veya eþitse, en büyük ile karþýlaþtýr
    mov bl, al              ; Yeni en küçük sayý

sonraki_karsilastirma:
    cmp al, bh              ; Mevcut sayýyý en büyük ile karþýlaþtýr
    jna check_end           ; Eðer küçük veya eþitse, döngünün sonunu kontrol et
    mov bh, al              ; Yeni en büyük sayý

check_end:
    loop bul_dongu          ; CX sýfýr olana kadar döngüyü tekrarla

    ; En küçük ve en büyük sayýlarý ekrana yazdýr
    lea dx, enkucuk       ; 'min_mesaj' adresini DX register'ýna yükle
    mov ah, 09h             ; Ekrana string yazdýrma fonksiyonunu ayarla
    int 21h                 ; Mesajý ekrana yazdýr
    mov dl, bl              ; En küçük sayýyý DL register'ýna yükle
    mov ah, 02h             ; Ekrana karakter yazdýrma fonksiyonunu ayarla
    int 21h                 ; En küçük sayýyý ekrana yazdýr

    lea dx, enbuyuk       ; 'max_mesaj' adresini DX register'ýna yükle
    mov ah, 09h             ; Ekrana string yazdýrma fonksiyonunu ayarla
    int 21h                 ; Mesajý ekrana yazdýr
    mov dl, bh              ; En büyük sayýyý DL register'ýna yükle
    mov ah, 02h             ; Ekrana karakter yazdýrma fonksiyonunu ayarla
    int 21h                 ; En büyük sayýyý ekrana yazdýr

BulEnKucukEnBuyuk endp

; Programýn geri kalan kýsýmlarý...


