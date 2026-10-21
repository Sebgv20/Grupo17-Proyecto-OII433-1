// Si el jugador está tocando la puerta
if (place_meeting(x, y, oPlayer)) {
    
    // Si presiona "W" o la flecha hacia arriba
    if (keyboard_check_pressed(ord("W"))) {
        scrFinalizarNivel(1);
		scrExportarLogs();
		scrEnviarLogsGoogle();
		room_goto(rLevel2Selector);
    }
}