// Si el jugador está tocando la puerta
if (place_meeting(x, y, oPlayer)) {
    
    // Si presiona "W" o la flecha hacia arriba
    if (keyboard_check_pressed(ord("W"))) {
        scrExportarLogs(1);
		room_goto(rLevel2Selector);
    }
}