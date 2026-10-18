// Si el jugador está tocando el botón
if (place_meeting(x, y, oPlayer)) {
    
    if (keyboard_check_pressed(ord("W"))) {
        
        var errores_encontrados = 0;
        var cajas_correctas = 0;
        
        // Revisamos el estado de TODOS los contenedores del nivel
        with (oGhost_Container) {
            
            if (!auxiliar) {
                if (ocupado) {
                    if (fantasma_guardado != fraccion_correcta) {
                        // Cambiamos error_fade por tu variable
                        color_Incorrecto = 1.0; 
                        errores_encontrados += 1;
                    } else {
                        // Cambiamos success_fade por tu variable
                        color_Correcto = 1.0; 
                        cajas_correctas += 1;
                    }
                }
            }
        }
        
        // EVALUACIÓN FINAL DEL BOTÓN
        if (errores_encontrados > 0) {
            global.life -= 1; 
            if (global.life <= 0) {
                 scrGameOver();
            }
        } 
        // Si no hay errores y alcanzamos la cantidad de cajas exigidas
        else if (cajas_correctas >= cajas_requeridas) {
            
            // Hacemos desaparecer el candado de la puerta
            if (instance_exists(oDoorLvl2_NextLevel)) {
                oDoorLvl2_NextLevel.bloqueada = false;
            }
        }
    }
}