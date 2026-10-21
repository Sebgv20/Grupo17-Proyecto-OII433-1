
// Comprobar que la puerta este desbloqueada
if (!bloqueada) {

    // Comprobar que el jugador este tocando la puerta
    if (place_meeting(x, y, oPlayer)) {

        if (keyboard_check_pressed(ord("W"))) {

            // Registrar finalizacion exitosa del nivel 3
            if (variable_global_exists("nivel_actual_log")) {

                if (global.nivel_actual_log == 3) {

                    scrFinalizarNivel(3);

                    // Guardar registros localmente
                    scrExportarLogs();

                    // Enviar registros a Google Sheets
                    scrEnviarLogsGoogle();

                    show_debug_message(
                        "NIVEL 3 COMPLETADO | Registros guardados y envio solicitado"
                    );
                }
            }
        }
    }
}
