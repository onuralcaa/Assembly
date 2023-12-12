

org 100h 
 
 ;m2 nin baþlangýç adresini bulma   
 lea dx, m2
 mov ah, 9
 int 21h
        
 ;klavyeden bir tuþa basana kadar bekle       
 mov ah,1
 int 21h
 
 ;1=>49 , 49-48
 sub al,48
 
 ;cx ayarlarý
 mov cl,al
 mov ch,0
 
 yaz:
 ;cx deki sayý kadar m1'i ekrana yaz
 lea dx, m1
 mov ah, 9
 int 21h
 
 loop yaz 
            
ret 

m1 db 10, 13, 'Onur$'
m2 db 10, 13, 'Bir sayi giriniz(1-9): $' 

