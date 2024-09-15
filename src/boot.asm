; boot.asm - Einfacher Bootloader
[org 0x7c00]          ; BIOS lädt den Bootloader an Adresse 0x7C00
mov ah, 0x0E          ; TTY-Ausgabefunktion
mov al, 'B'           ; Zeige 'B' auf dem Bildschirm
int 0x10              ; BIOS-Interrupt zur Ausgabe des Zeichens

mov al, 'o'           ; Zeige 'o'
int 0x10

mov al, 'o'           ; Zeige 'o'
int 0x10

mov al, 't'           ; Zeige 't'
int 0x10

cli                   ; Deaktiviere Interrupts
hlt                   ; Beende die CPU

times 510 - ($ - $$) db 0 ; Fülle auf 512 Bytes auf
dw 0xAA55             ; Bootsektor-Signatur (erforderlich für BIOS-Boot)

