# Makefile - Bootloader und Kernel bauen

CC = x86_64-elf-gcc
AS = nasm
CFLAGS = -ffreestanding -O2 -nostdlib
LDFLAGS = -T src/linker.ld
OBJCOPY = objcopy

all: os-image.bin

boot.o: src/boot.asm
	$(AS) -f bin src/boot.asm -o boot.o   # Ensure this line starts with a tab

kernel.o: src/kernel.c
	$(CC) $(CFLAGS) -c src/kernel.c -o kernel.o  # Ensure this line starts with a tab

kernel.bin: kernel.o
	x86_64-elf-ld $(LDFLAGS) -o kernel.bin kernel.o  # Ensure this line starts with a tab

os-image.bin: boot.o kernel.bin
	cat boot.o kernel.bin > os-image.bin  # Ensure this line starts with a tab

