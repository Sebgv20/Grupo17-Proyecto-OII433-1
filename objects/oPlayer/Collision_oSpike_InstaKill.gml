// if the player collides with a ghost
// Registrar las vidas restantes antes del Game Over
var _vidas_perdidas = max(0, global.life);

if (variable_global_exists("vidas_perdidas_nivel")) {
    if (global.nivel_actual_log == 1) {
        global.vidas_perdidas_nivel += _vidas_perdidas;
    }
}


global.life = 0;				// reduce the players health
scrGameOver();