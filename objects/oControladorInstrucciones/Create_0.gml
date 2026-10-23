depth = -9999;
// Para ver los tutoriales una sola vez
if (!variable_global_exists("tutoriales_vistos")) {
    global.tutoriales_vistos = {};
}

if (variable_struct_exists(global.tutoriales_vistos, nombre_tutorial)) {
    instance_destroy();
    
} else {
    global.tutoriales_vistos[$ nombre_tutorial] = true;
}