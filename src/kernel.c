void kernel_main() {
    const char *message = "Kernel Start";
    char *video_memory = (char *) 0xb8000;  // VGA-Textspeicher bei 0xb8000
    int i = 0;

    while (message[i] != '\0') {
        video_memory[i * 2] = message[i];   // Schreibe Zeichen
        video_memory[i * 2 + 1] = 0x07;     // Setze Attribut (hellgrau auf schwarz)
        i++;
    }

    while (1);  // Endlosschleife
}

