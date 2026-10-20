// Comprobamos si ya existe otro oControladorMusica en el juego
if (instance_number(oControladorMusica) > 1) {
    // Si ya existe otro, nos destruimos para no crear clones
    instance_destroy();
    exit; // Detiene el resto del código
}