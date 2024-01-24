; Ana program

org 100h

mov bx, 15 ; BX'e çevrilecek deðeri yükle
call binDonusum ; Alt programý çaðýr

jmp son ; Alt programdan sonra programýn sona ermesini saðlar

yaz0Fonksiyonu:
    mov ah, 0eh ; Teletype yazdýr fonksiyonu
    mov al, '0'
    int 10h
    ret

yaz1Fonksiyonu:
    mov ah, 0eh ; Teletype yazdýr fonksiyonu
    mov al, '1'
    int 10h
    ret

binDonusum proc
    push bx ; BX registerýný yýðýna kaydet
    push cx ; CX registerýný yýðýna kaydet

    mov cx, 16         ; CX'i 16 ile doldur (16 bit)
donusumDongusu:
    rol bx, 1          ; BX'in en düþük bitini al ve CF'e aktar
    jc yaz1            ; CF=1 ise yaz1 etiketini oku
    jnc yaz0           ; CF=0 ise yaz0 etiketine git
yaz1:
    call yaz1Fonksiyonu ; CF=1 ise '1' yazdýr
    jmp devam          ; devam etiketine git
yaz0:
    call yaz0Fonksiyonu ; CF=0 ise '0' yazdýr
devam:
    loop donusumDongusu ; CX sayacýný 1 azalt ve NZF'ye bak
    pop cx ; CX registerýný yýðýndan geri yükle
    pop bx ; BX registerýný yýðýndan geri yükle

    ret
binDonusum endp

son:
ret

; Programýn geri kalan kýsmý kaldýrýldý çünkü tekrar eden ve hatalý kullanýmlar içeriyordu.
