depth = -9999;

if (!variable_global_exists("tutoriales_vistos")) {
    global.tutoriales_vistos = {};
}

var _abierto_con_boton = (variable_instance_exists(id, "forzar_tutorial") && forzar_tutorial);

if (_abierto_con_boton) {
    // Reutilizar el sprite válido memorizado al entrar al nivel
    if (variable_global_exists("sprite_tutorial_actual") && sprite_exists(global.sprite_tutorial_actual)) {
        sprite_instrucciones = global.sprite_tutorial_actual;
    } else {
        instance_destroy();
        exit;
    }
} else {
    // Memorizar si ya viene asignado desde Variable Definitions
    if (variable_instance_exists(id, "sprite_instrucciones") && sprite_exists(sprite_instrucciones)) {
        global.sprite_tutorial_actual = sprite_instrucciones;
    }

    // Comportamiento normal: mostrar una sola vez al iniciar el nivel
    if (variable_struct_exists(global.tutoriales_vistos, nombre_tutorial)) {
        instance_destroy();
    } else {
        global.tutoriales_vistos[$ nombre_tutorial] = true;
    }
}