// if the player collides with a ghost
global.life--;

// Contar la vida perdida
if (variable_global_exists("vidas_perdidas_nivel")) {
    if (global.nivel_actual_log == 1) {
        global.vidas_perdidas_nivel += 1;
    }
}

with(other){			// destroy the spike
	instance_destroy();
}