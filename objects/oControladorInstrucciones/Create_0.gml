depth = -9999;
// 1. Si la memoria global de tutoriales no existe, la creamos vacía
if (!variable_global_exists("tutoriales_vistos")) {
    global.tutoriales_vistos = {};
}

// 2. Verificamos si este tutorial específico ya fue registrado como "visto"
if (variable_struct_exists(global.tutoriales_vistos, nombre_tutorial)) {
    
    // Si ya se vio (el jugador murió y el nivel eligió una sala aleatoria), 
    // nos destruimos inmediatamente en el primer frame para no mostrar nada.
    instance_destroy();
    
} else {
    
    // Si no se ha visto, lo registramos en la memoria global para que 
    // quede guardado para los próximos intentos.
    global.tutoriales_vistos[$ nombre_tutorial] = true;
}