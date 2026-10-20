// Verificamos si la música NO está sonando actualmente
if (!audio_is_playing(musicBG)) {
    
    // Si no está sonando, la iniciamos. 
    // Argumentos: (Sonido, Prioridad, Bucle)
    audio_play_sound(musicBG, 100, true); 
}