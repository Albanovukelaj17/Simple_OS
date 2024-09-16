; boot.asm - Einfache Bootloader-Logik
[org 0x7c00]          ; BIOS lädt den Bootloader an Adresse 0x7C00
bits 16               ; 16-Bit Code (Real Mode)

start:
    ; Text auf den Bildschirm ausgeben
    mov ah, 0x0E
    mov al, 'B'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 't'
    int 0x10

    ; Debug-Ausgabe vor dem BIOS-Interrupt
    mov ah, 0x0E
    mov al, 'R'         ; Zeige "R" für "Read"
    int 0x10

    ; Kernel von der Festplatte lesen (vom 2. Sektor)
    mov ax, 0x0000       ; Segment:Offset, wo der Kernel geladen wird
    mov es, ax           ; ES = 0x0000
    mov bx, 0x0800       ; Lade den Kernel ab Adresse 0x0800

    mov ah, 0x02         ; BIOS-Funktion zum Lesen von Sektoren
    mov al, 1            ; 1 Sektor lesen
    mov ch, 0            ; Zylinder 0
    mov cl, 2            ; Sektor 2 (Sektor 1 ist der Bootsektor)
    mov dh, 0            ; Kopf 0
    mov dl, 0x80         ; Erstes Laufwerk (HDD)

    int 0x13             ; BIOS-Interrupt zum Lesen der Festplatte
    jc disk_error        ; Fehlerbehandlung bei Problemen

    ; Debug-Ausgabe nach erfolgreichem Lesen
    mov ah, 0x0E
    mov al, 'S'         ; Zeige "S" für "Success"
    int 0x10

    ; Zum geladenen Kernel springen
    jmp 0x0000:0x0800    ; Springe zu Adresse 0x0000:0x0800, wo der Kernel liegt

disk_error:
    ; Fehlerbehandlung, falls der Diskettenzugriff fehlschlägt
    mov ah, 0x0E
    mov al, 'E'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'o'
    int 0x10
    mov al, 'r'
    int 0x10
    cli                  ; Interrupts deaktivieren
    hlt                  ; CPU stoppen

times 510 - ($ - $$) db 0 ; Fülle auf 512 Bytes auf
dw 0xAA55                 ; Bootsektor-Signatur (wichtig für das BIOS)

