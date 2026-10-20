// Si el jugador está tocando el botón[cite: 1]
if (place_meeting(x, y, oPlayer)) {
    
    // Si presiona "W" o "Arriba"[cite: 1]
    if (keyboard_check_pressed(ord("W"))) {
        
        var errores_encontrados = 0;
        var cajas_correctas = 0;
        
        // Revisamos el estado de TODOS los detectores del nivel 3
        with (oDetectorCaja) {
            // Evaluamos solo si el detector tiene una caja encima
            if (caja_colocada != "") {
                if (posicion_correcta) {
                    cajas_correctas += 1;
                } else {
                    errores_encontrados += 1;
                }
            }
        }
        
        // EVALUACIÓN FINAL DEL BOTÓN
        if (errores_encontrados > 0) {
            audioReproduce(soundFail);
        } 
        // Si no hay errores y se ordenaron todas las cajas exigidas
        else if (cajas_correctas >= cajas_requeridas) {
            audioReproduce(soundSuccess);
            // Hacemos desaparecer el candado de la puerta
            if (instance_exists(oDoorLvl3_NextLevel)) {
                oDoorLvl3_NextLevel.bloqueada = false;
            }
        }
    }
}