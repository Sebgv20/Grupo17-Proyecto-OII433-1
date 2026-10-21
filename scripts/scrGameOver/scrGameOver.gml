
function scrGameOver() {

    // Registrar el intento fallido antes de restaurar las vidas
    if (variable_global_exists("nivel_actual_log")) {

        if (global.nivel_actual_log >= 1 &&
            global.nivel_actual_log <= 3) {

            var _nivel = global.nivel_actual_log;

            // Tiempo transcurrido desde el inicio del nivel
            var _tiempo = (get_timer() - global.tiempo_inicio_nivel) / 1000000;
            _tiempo = round(_tiempo * 100) / 100;

            // Guardar el intento fallido
            scrIniciarLogs();

            var _registro = {
                tipo: "fin_intento",
                timestamp: date_datetime_string(date_current_datetime()),
                idJugador: global.idJugador,
                nivel: _nivel,
                resultado: "fallido",
                tiempoTotal: _tiempo,
                vidasPerdidas: global.vidas_perdidas_nivel,
                vidasRestantes: 0
            };

            // Registrar los reinicios de palancas solamente en el nivel 3
            if (_nivel == 3) {

                if (variable_global_exists("reinicios_nivel3")) {
                    _registro.reinicios = global.reinicios_nivel3;
                } else {
                    _registro.reinicios = 0;
                }

                show_debug_message(
                    "REINICIOS INTENTO FALLIDO NIVEL 3: "
                    + string(_registro.reinicios)
                );
            }

            array_push(global.logs_pendientes, _registro);
            array_push(global.logs_historial, _registro);
            array_push(global.logs_google_pendientes, _registro);

            show_debug_message(
                "INTENTO FALLIDO | Nivel: " + string(_nivel)
                + " | Tiempo: " + string(_tiempo)
                + " s | Vidas perdidas: "
                + string(global.vidas_perdidas_nivel)
                + " | Vidas restantes: 0"
            );

            // Evitar registrar dos veces el mismo intento
            global.nivel_actual_log = -1;

            // Exportar los registros
            scrExportarLogs();
            scrEnviarLogsGoogle();
        }
    }

    // Restaurar vidas para el siguiente intento
    global.life = 3;

    // Regresar al selector correspondiente
    var nombre_sala = room_get_name(room);

    if (string_pos("Level2", nombre_sala) > 0) {
        room_goto(rLevel2Selector);
    }
    else if (string_pos("Level1", nombre_sala) > 0) {
        room_goto(rLevel1Selector);
    }
    else if (string_pos("Level3", nombre_sala) > 0) {
        room_goto(rLevel3Selector);
    }
}
