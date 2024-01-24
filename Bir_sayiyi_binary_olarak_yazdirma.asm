; Ana program

org 100h

mov bx, 15 ; BX'e �evrilecek de�eri y�kle
call binDonusum ; Alt program� �a��r

jmp son ; Alt programdan sonra program�n sona ermesini sa�lar

yaz0Fonksiyonu:
    mov ah, 0eh ; Teletype yazd�r fonksiyonu
    mov al, '0'
    int 10h
    ret

yaz1Fonksiyonu:
    mov ah, 0eh ; Teletype yazd�r fonksiyonu
    mov al, '1'
    int 10h
    ret

binDonusum proc
    push bx ; BX register�n� y���na kaydet
    push cx ; CX register�n� y���na kaydet

    mov cx, 16         ; CX'i 16 ile doldur (16 bit)
donusumDongusu:
    rol bx, 1          ; BX'in en d���k bitini al ve CF'e aktar
    jc yaz1            ; CF=1 ise yaz1 etiketini oku
    jnc yaz0           ; CF=0 ise yaz0 etiketine git
yaz1:
    call yaz1Fonksiyonu ; CF=1 ise '1' yazd�r
    jmp devam          ; devam etiketine git
yaz0:
    call yaz0Fonksiyonu ; CF=0 ise '0' yazd�r
devam:
    loop donusumDongusu ; CX sayac�n� 1 azalt ve NZF'ye bak
    pop cx ; CX register�n� y���ndan geri y�kle
    pop bx ; BX register�n� y���ndan geri y�kle

    ret
binDonusum endp

son:
ret

; Program�n geri kalan k�sm� kald�r�ld� ��nk� tekrar eden ve hatal� kullan�mlar i�eriyordu.
