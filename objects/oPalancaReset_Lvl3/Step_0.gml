
// Si el jugador está tocando la palanca
if (place_meeting(x, y, oPlayer)) {

    // Si presiona "W" o "Arriba"
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {

        var cajas_movidas = false;

        // Escaneamos todas las cajas empujables en el nivel
        with (oBoxPushable) {

            // Verificamos si la caja pertenece al mismo grupo que esta palanca
            if (grupoCajas == other.grupoCajas) {

                // Calculamos el margen respecto a su posicion original
                var margen_x = abs(xstart * 0.1);
                var margen_y = abs(ystart * 0.1);

                // Comprobar si la caja fue desplazada
                if (abs(x - xstart) > margen_x || abs(y - ystart) > margen_y) {
                    cajas_movidas = true;
                }

                // Restaurar posicion original
                x = xstart;
                y = ystart;

                // Reiniciar velocidad vertical
                vspd = 0;
            }
        }

        // EVALUACIÓN DE VIDAS Y GAME OVER
        if (cajas_movidas) {

            global.life -= 1;

            // Registrar reinicio y vida perdida del nivel 3
            if (variable_global_exists("nivel_actual_log")) {

                if (global.nivel_actual_log == 3) {

                    // Inicializar contador si no existe
                    if (!variable_global_exists("reinicios_nivel3")) {
                        global.reinicios_nivel3 = 0;
                    }

                    global.reinicios_nivel3 += 1;

                    // Contabilizar vida perdida
                    if (variable_global_exists("vidas_perdidas_nivel")) {
                        global.vidas_perdidas_nivel += 1;
                    }

                    show_debug_message(
                        "REINICIO NIVEL 3 | Total: "
                        + string(global.reinicios_nivel3)
                        + " | Vidas perdidas: "
                        + string(global.vidas_perdidas_nivel)
                    );
                }
            }

            audioReproduce(soundLever);

            if (global.life <= 0) {
                // Volver al selector correspondiente
                scrGameOver();
            }
        }
    }
}
