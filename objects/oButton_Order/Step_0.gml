
// Si el jugador está tocando el botón
if (place_meeting(x, y, oPlayer)) {

    // Si presiona "W" o "Arriba"
    if (keyboard_check_pressed(ord("W"))) {

        var errores_encontrados = 0;
        var cajas_correctas = 0;

        // 1. Primero contamos exclusivamente las cajas que están en su posición correcta
        with (oDetectorCaja) {
            if (caja_colocada != "") {
                if (posicion_correcta) {
                    cajas_correctas += 1;
                }
            }
        }

        // 2. Luego contamos los errores, filtrando los falsos positivos por solapamiento
        with (oDetectorCaja) {
            if (caja_colocada != "") {
                if (!posicion_correcta) {
                    var es_solapamiento = false;

                    // Verificamos si la caja que marca error ya fue contada como correcta por otro detector cercano
                    with (oDetectorCaja) {
                        // "other" se refiere al detector de la lectura incorrecta
                        if (posicion_correcta && caja_colocada == other.caja_colocada) {
                            es_solapamiento = true;
                        }
                    }

                    // Si NO es un solapamiento accidental, el jugador realmente puso una caja equivocada
                    if (!es_solapamiento) {
                        errores_encontrados += 1;
                    }
                }
            }
        }

        // EVALUACIÓN FINAL DEL BOTÓN
        if (errores_encontrados > 0) {

            // Registrar comprobacion incorrecta
            scrGuardarLog(
                3,
                "Ordenamiento de fracciones de menor a mayor",
                "Comprobacion del orden de las cajas",
                "Incorrecta | Cajas correctas: "
                    + string(cajas_correctas)
                    + " | Cajas incorrectas: "
                    + string(errores_encontrados),
                false,
                0
            );

            audioReproduce(soundFail);
        }

        else if (errores_encontrados <= 0 && cajas_correctas < cajas_requeridas) {

            // Registrar comprobacion incompleta
            scrGuardarLog(
                3,
                "Ordenamiento de fracciones de menor a mayor",
                "Comprobacion del orden de las cajas",
                "Incompleta | Cajas correctas: "
                    + string(cajas_correctas)
                    + " | Cajas requeridas: "
                    + string(cajas_requeridas),
                false,
                0
            );

            timer_incompleto = 120;
        }

        // Si no hay errores y se ordenaron todas las cajas exigidas
        else if (cajas_correctas >= cajas_requeridas) {

            // Registrar comprobacion correcta
            scrGuardarLog(
                3,
                "Ordenamiento de fracciones de menor a mayor",
                "Comprobacion del orden de las cajas",
                "Correcta | Cajas correctas: "
                    + string(cajas_correctas),
                true,
                0
            );

            audioReproduce(soundSuccess);

            // Hacemos desaparecer el candado de la puerta
            if (instance_exists(oDoorLvl3_NextLevel)) {
                oDoorLvl3_NextLevel.bloqueada = false;
            }
        }
    }
}

// Reducimos el temporizador constantemente para que el mensaje desaparezca
if (timer_incompleto > 0) {
    timer_incompleto -= 1;
}
