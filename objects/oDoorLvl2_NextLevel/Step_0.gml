
if (!bloqueada) {
    if (place_meeting(x, y, oPlayer)) {
        if (keyboard_check_pressed(ord("W"))) {

            // Registrar finalizacion exitosa del nivel 2
            scrFinalizarNivel(2);

            // Guardar registros en archivo local
            scrExportarLogs();

            // Enviar registros a Google Sheets
            scrEnviarLogsGoogle();

            // Continuar al selector del nivel 3
            room_goto(rLevel3Selector);
        }
    }
}
