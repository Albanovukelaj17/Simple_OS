# Makefile - Bootloader und Kernel bauen

CC = x86_64-elf-gcc
AS = nasm
CFLAGS = -ffreestanding -O2 -nostdlib
LDFLAGS = -T src/linker.ld
OBJCOPY = objcopy

all: os-image.bin

boot.o: src/boot.asm
	$(AS) -f bin src/boot.asm -o boot.o

kernel.o: src/kernel.c
	$(CC) $(CFLAGS) -c src/kernel.c -o kernel.o

kernel.bin: kernel.o
	$(CC) $(CFLAGS) -T src/linker.ld -o kernel.bin boot.o kernel.o  # Verwende den Compiler als Linker

os-image.bin: boot.o kernel.bin
	cat boot.o kernel.bin > os-image.bin

clean:
	rm -f *.o *.bin

