


 ;Bu program 0-9 aras�nda girilen 9 adet say�y� ekrana yazd�r�r ve min, max de�erlerini hesaplar.



org 100h

m_yaz equ 9
sayi_adeti equ 9

; Program ba�lang�c�
    mov cx, sayi_adeti   ; Say� adetini CX register'�na y�kle
    lea di, sayilar      ; 'sayilar' dizisinin adresini DI register'�na y�kle
    xor bx, bx           ; BX register'�n� s�f�rla (say� s�ras�n� tutmak i�in)

Anadongu:
    inc bx               ; Say� s�ras�n� artt�r

    ; Say� s�ras�n� ve "Say�y� giriniz: " mesaj�n� yazd�r
    push cx              ; CX register'�n� y���na kaydet
    mov ah, 02h          ; Ekrana karakter yazd�rma fonksiyonunu ayarla
    mov dl, '0'          ; ASCII '0'
    add dl, bl           ; Say� s�ras�n� ASCII karaktere �evir
    int 21h              ; Say� s�ras�n� ekrana yazd�r
    lea dx, mesaj        ; 'mesaj' adresini DX register'�na y�kle
    mov ah, m_yaz        ; Ekrana yazd�rma fonksiyonunu ayarla
    int 21h              ; Mesaj� ekrana yazd�r
    pop cx               ; CX register'�n� y���ndan geri y�kle

    ; Kullan�c�dan say� giri�i al
    mov ah, 01h          ; Klavyeden bir karakter okumak i�in fonksiyonu ayarla
    int 21h              ; Klavyeden karakter oku ve AL register'�na y�kle
    cmp al, 13           ; Carriage return ile kar��la�t�r
    je  cikis            ; E�er carriage return ise ��k�� yap
    mov [di], al         ; Okunan karakteri 'sayilar' dizisine kaydet
    inc di               ; 'sayilar' dizisinin bir sonraki adresine ge�

    ; Yeni sat�ra ge�mek i�in CR ve LF g�nder
    mov ah, 02h          ; Ekrana karakter yazd�rma fonksiyonunu ayarla
    mov dl, 13           ; Carriage return
    int 21h              ; Ekrana CR yazd�r
    mov dl, 10           ; Line feed
    int 21h              ; Ekrana LF yazd�r

    loop Anadongu   ; CX s�f�r olana kadar d�ng�y� tekrarla
    
    
     CALL yazdir  ;en sonda sayilari ekrana yazdirma
     CALL BulEnKucukEnBuyuk   
 
cikis: 
    ret                  ; Programdan ��k

;tanimlamalar
sayilar db sayi_adeti dup('?')  ; Giri� i�in say�lar� tutacak dizi
mesaj db '. Sayiyi giriniz: $'   ; Kullan�c�ya g�sterilecek mesaj
enkucuk db ' En kucuk sayi : $'
enbuyuk db ' En buyuk sayi : $'

yazdir proc              ;say�lar� ekrana yazd�ran alt program
    mov cx, sayi_adeti   ; Say� adetini CX register'�na y�kle
    mov di, offset sayilar ; 'sayilar' dizisinin offset'ini DI register'�na y�kle

dongu:
    mov dl, [di]           ; Diziden bir sonraki say�y� DL register'�na y�kle

    mov ah, 02h  
    int 21h
    
    inc di               

    mov dl, ','            
    mov ah, 02h
    int 21h

    loop dongu
endp  

; En k���k ve en b�y�k say�y� bulan alt program
BulEnKucukEnBuyuk proc
    mov cx, sayi_adeti      ; Say� adetini CX register'�na y�kle
    lea si, sayilar         ; 'sayilar' dizisinin adresini SI register'�na y�kle
    mov al, [si]            ; �lk say�y� AL register'�na y�kle
    mov bl, al              ; En k���k say�y� BL register'�na y�kle
    mov bh, al              ; En b�y�k say�y� BH register'�na y�kle

bul_dongu:
    inc si                  ; Bir sonraki say�ya ge�
    mov al, [si]            ; Yeni say�y� AL register'�na y�kle
    cmp al, bl              ; Mevcut say�y� en k���k ile kar��la�t�r
    jnb sonraki_karsilastirma ; E�er b�y�k veya e�itse, en b�y�k ile kar��la�t�r
    mov bl, al              ; Yeni en k���k say�

sonraki_karsilastirma:
    cmp al, bh              ; Mevcut say�y� en b�y�k ile kar��la�t�r
    jna check_end           ; E�er k���k veya e�itse, d�ng�n�n sonunu kontrol et
    mov bh, al              ; Yeni en b�y�k say�

check_end:
    loop bul_dongu          ; CX s�f�r olana kadar d�ng�y� tekrarla

    ; En k���k ve en b�y�k say�lar� ekrana yazd�r
    lea dx, enkucuk       ; 'min_mesaj' adresini DX register'�na y�kle
    mov ah, 09h             ; Ekrana string yazd�rma fonksiyonunu ayarla
    int 21h                 ; Mesaj� ekrana yazd�r
    mov dl, bl              ; En k���k say�y� DL register'�na y�kle
    mov ah, 02h             ; Ekrana karakter yazd�rma fonksiyonunu ayarla
    int 21h                 ; En k���k say�y� ekrana yazd�r

    lea dx, enbuyuk       ; 'max_mesaj' adresini DX register'�na y�kle
    mov ah, 09h             ; Ekrana string yazd�rma fonksiyonunu ayarla
    int 21h                 ; Mesaj� ekrana yazd�r
    mov dl, bh              ; En b�y�k say�y� DL register'�na y�kle
    mov ah, 02h             ; Ekrana karakter yazd�rma fonksiyonunu ayarla
    int 21h                 ; En b�y�k say�y� ekrana yazd�r

BulEnKucukEnBuyuk endp

; Program�n geri kalan k�s�mlar�...


