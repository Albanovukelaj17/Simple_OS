/* linker.ld - Linker Skript */
ENTRY(kernel_main)

SECTIONS {
    . = 0x0100;              /* Lade Kernel bei Adresse 1MB */
    .text : { *(.text) } /* Kernel-Code (Textbereich) */
    .data : { *(.data) } /* Kernel-Daten */
    .bss  : { *(.bss)  } /* Uninitialisierte Daten */
}

