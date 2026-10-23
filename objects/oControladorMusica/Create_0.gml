// Para que no haya más de una instancia
if (instance_number(oControladorMusica) > 1) {
    instance_destroy();
    exit;
}