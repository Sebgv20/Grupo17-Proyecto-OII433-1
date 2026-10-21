
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

                        color_Incorrecto = 1.0;
                        errores_encontrados += 1;

                    } else {

                        color_Correcto = 1.0;
                        cajas_correctas += 1;
                    }
                }
            }
        }

        // EVALUACIÓN FINAL DEL BOTÓN
        if (errores_encontrados > 0) {

            global.life -= 1;

            // Registrar vida perdida por respuesta incorrecta
            if (variable_global_exists("vidas_perdidas_nivel")
                && variable_global_exists("nivel_actual_log")) {

                if (global.nivel_actual_log == 2) {

                    global.vidas_perdidas_nivel += 1;

                    show_debug_message(
                        "VIDA PERDIDA POR RESPUESTA INCORRECTA | Total: "
                        + string(global.vidas_perdidas_nivel)
                    );
                }
            }

            // Registrar comprobación incorrecta
            scrGuardarLog(
                2,
                "Ubicacion de fracciones en la recta numerica",
                "Comprobacion de contenedores",
                "Incorrecta | Cajas correctas: "
                    + string(cajas_correctas)
                    + " | Cajas incorrectas: "
                    + string(errores_encontrados),
                false,
                0
            );

            audioReproduce(soundFail);

            if (global.life <= 0) {
                scrGameOver();
            }
        }

        // Si no hay errores y alcanzamos la cantidad de cajas exigidas
        else if (cajas_correctas >= cajas_requeridas) {

            // Registrar comprobación correcta
            scrGuardarLog(
                2,
                "Ubicacion de fracciones en la recta numerica",
                "Comprobacion de contenedores",
                "Correcta | Cajas correctas: "
                    + string(cajas_correctas),
                true,
                0
            );

            audioReproduce(soundSuccess);

            // Hacemos desaparecer el candado de la puerta
            if (instance_exists(oDoorLvl2_NextLevel)) {
                oDoorLvl2_NextLevel.bloqueada = false;
            }
        }
    }
}
