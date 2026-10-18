// player movement is done in the script
scrProcessPlayer();

// Verificamos si el jugador se quedó sin vidas por cualquier motivo general
if (global.life < 1) {
    scrGameOver();
}

// Comprobar si el jugador cayó por debajo del límite de la sala (con un margen de 64 píxeles)
if (y > room_height + 64) { 
    
    // Pierde una vida
    global.life -= 1; 

    if (global.life > 0) {
        // Respawn: Volver exactamente a la posición donde empezó el nivel
        x = xstart;
        y = ystart;
        
        // Resetear la gravedad y el estado para que no reaparezca cayendo a toda velocidad
        grav = 0; 
        fall = true; 
        jump = false;
        climbing = false;
        
    } else {
        // Game Over: Ejecutamos el script centralizado para volver al hub correspondiente
        scrGameOver();
    }
}