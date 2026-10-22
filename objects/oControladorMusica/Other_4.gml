// Verificamos si la música NO está sonando actualmente
if (!audio_is_playing(musicBG)) {
    audio_play_sound(musicBG, 100, true); 
}