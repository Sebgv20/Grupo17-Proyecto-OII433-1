if (!bloqueada) {
    if (place_meeting(x, y, oPlayer)) {
        if (keyboard_check_pressed(ord("W"))) {
            room_goto(rLevel2Selector);
        }
    }
}