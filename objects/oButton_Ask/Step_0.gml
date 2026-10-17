if (place_meeting(x, y, oPlayer)) {
    
    // Si presiona "W" o "Arriba"
    if (keyboard_check_pressed(ord("W"))) {
        
        var errores_encontrados = 0;
        var cajas_vacias = false;
        
        // Revisamos el estado de TODOS los contenedores del nivel
        with (oGhost_Container) {
            
            // SOLO EVALUAMOS LAS CAJAS QUE NO SEAN AUXILIARES
            if (!auxiliar) {
                if (ocupado) {
                    if (fantasma_guardado != fraccion_correcta) {
                        // Es incorrecta, encendemos el rojo
                        color_Incorrecto = 1.0; 
                        errores_encontrados += 1;
                    } else {
                        // Es correcta, encendemos el verde
                        color_Correcto = 1.0; 
                    }
                } else {
                    // Hay una caja principal vacía
                    cajas_vacias = true;
                }
            }
        }
        
        // EVALUACIÓN FINAL DEL BOTÓN
        if (errores_encontrados > 0) {
            global.life -= 1; 
            if (global.life <= 0) {
                room_restart(); 
            }
        } 
        else if (!cajas_vacias && errores_encontrados == 0) {
            // Si no hay errores y todas las cajas principales están llenas ¡Nivel superado!
            //room_goto_next(); 
        }
    }
}