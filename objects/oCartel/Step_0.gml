// Solo funciona si ya se falló la respuesta vinculada
if (puede_interactuar) {
    
    // Si el jugador está tocando el cartel
    if (place_meeting(x, y, oPlayer)) {
        
        // Si presiona "W" o "Arriba"
        if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
            mostrar_mensaje = !mostrar_mensaje; // Alterna entre mostrar y ocultar
        }
        
    } else {
        // Si el jugador se aleja, el mensaje se oculta automáticamente
        mostrar_mensaje = false;
    }
}