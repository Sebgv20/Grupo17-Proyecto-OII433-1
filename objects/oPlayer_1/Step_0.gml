// player movement is done in the script
scrProcessPlayer();


if (global.life < 1) {
	RandomLevel_1();
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
        // Game Over: Reiniciar el nivel si se queda sin vidas
        // (Al reiniciarse la sala, el evento Create del player volverá a poner global.life en 3)
        room_restart();
    }
}