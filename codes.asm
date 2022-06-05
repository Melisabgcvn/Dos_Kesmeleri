.model small
.data
basarili1 db "dosya olusturuldu..",13,10,"$"
basarili2 db "dosya acildi...",13,10,"$"
basarili3 db "dosyaya yazildi...",13,10,"$"
basarili4 db "dosya kapatildi..",13,10,"$"
mesaj db "Girmek istediginizi yazin.",13,10,"$"
msj1 db "dosya olusturulamadi.",13,10,"$"
msj2 db "dosya acilamadi..",13,10,"$"
msj3 db "dosyaya yazilamadi..",13,10,"$"
dno dw ?
yol db "C:\melisabagcivan.txt",00h
yaz db 15dup(00)

.code
;Data segmente ulasmak icin klasik kodumuz
mov ax,@data
mov ds,ax

;Dosya olusturma
mov ah,3ch
mov cx,00 ; normal bir dosya olusturulur
lea dx,yol ; olusturulacak dosyanin adresi
int 21h
jc err1 ; dosya acilamazsa JC=1 olur ve err1'e gider.
;basarili mesaji verelim
mov ah,09h
lea dx,basarili1
int 21h

;Dosya acma
mov ah,3dh
lea dx,yol ; acilacak dosyanin adresi dx'e atanir
mov al,01; dosyayi yazmak icin aciyoruz
int 21h
jc err2
mov dno,ax
;basarili mesaji verelim
mov ah,09h
lea dx,basarili2
int 21h

;Kullanicidan girdi alma

;kullanicidan veri isteme mesaji
mov ah,09h
lea dx,mesaj
int 21h

;veriyi alalim
mov cx,0015; alinacak girdi kadar dongu sayaci olusturulur.
lea si,yaz ; data kisminda olusturdugumuz bos dizinin adresi si'de
veriGirisi:
mov ah,01h
int 21h
mov [si],al
inc si ; bir sonraki bosluga gecmek icin si'yi 1 arttir
loop veriGirisi ; cx<=15 olana kadar loop devam eder

;Dosyaya yazmak
mov ah,40h
mov bx,dno
lea dx,yol ; yazilacak dosyanin adresi dx'de
mov cx,0015; yazilacak veri boyutu
int 21h
jc err3
;basarili mesaji verelim
mov ah,09h
lea dx,basarili3
int 21h

;dosya kapama
mov ah,3eh
mov bx,dno
int 21h
;basarili mesaji verelim
mov ah,09h
lea dx,basarili4
int 21h
jmp cik
;error mesajlari

err1:
mov ah,09h
lea dx,msj1
int 21h

err2:
mov ah,09h
lea dx,msj2
int 21h

err3:
mov ah,09h
lea dx,msj3
int 21h

cik:
mov ah,4ch
int 21h
end
 
