function scrGameOver() {
    global.life = 3; 
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