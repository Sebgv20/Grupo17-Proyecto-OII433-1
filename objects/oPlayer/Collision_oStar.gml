
global.puntaje++; // increase the players score

// Registrar estrella recogida para los logs
if (variable_global_exists("estrellas_obtenidas_nivel")
    && variable_global_exists("nivel_actual_log")) {

    if (global.nivel_actual_log >= 1
        && global.nivel_actual_log <= 3) {

        global.estrellas_obtenidas_nivel += 1;

        show_debug_message(
            "ESTRELLA RECOGIDA | Total nivel: "
            + string(global.estrellas_obtenidas_nivel)
        );
    }
}

audioReproduce(soundGrabStar);

with(other){ // destroy the pickup
    instance_destroy();
}

/*
if(!instance_exists(oStar)){ // if there are no more stars to collect
    if(room == rGrass){ // if we are in the grass room
        room_goto_next(); // move to the sand room
    } else { // if we are in the sand room
        room_goto_previous(); // move to the grass room
    }
}
*/
