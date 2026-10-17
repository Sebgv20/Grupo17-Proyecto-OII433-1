float_time_anim += (float_speed_anim) * delta_time / 175000; 
y = y_start_anim + sin(float_time_anim) * float_height_anim;

if (!siendo_atraido) {
    // Comportamiento normal de movimiento
    scrProcessGhosts();
} else {
    // Comportamiento de atracción hacia el jugador
    if (instance_exists(jugador_destino)) {
        
        // Creamos una variable de aceleración si es su primer frame siendo atraído
        if (!variable_instance_exists(id, "velocidad_atraccion")) {
            velocidad_atraccion = 0.05; // Velocidad de enganche inicial
        }
        
        // La velocidad de succión aumenta progresivamente (0.02 = alcance total en ~50 frames)
        velocidad_atraccion += 0.02; 
        if (velocidad_atraccion > 1) velocidad_atraccion = 1; // 1 significa alcance instantáneo
        
        // Posición a la que debe llegar (centro del jugador)
        var target_x = jugador_destino.x;
        var target_y = jugador_destino.y - (jugador_destino.sprite_height / 2);
        
        // Movemos al fantasma con la velocidad acelerada
        x = lerp(x, target_x, velocidad_atraccion);
        y = lerp(y, target_y, velocidad_atraccion);
        
        // Disminuimos escala y opacidad
        if (image_xscale > 0.1) {
            image_xscale -= 0.04;
            image_yscale -= 0.04;
        }
        if (image_alpha > 0) {
            image_alpha -= 0.05;
        }
        
        // Si la distancia es mínima O si la fuerza de succión llegó al máximo ineludible
        var distancia = point_distance(x, y, target_x, target_y);
        if (distancia < 15 || velocidad_atraccion == 1) {
            // Se efectúa la captura
            jugador_destino.fantasma_capturado = fraccion_texto;
            jugador_destino.sprite_fantasma_cap = sprite_index;
            instance_destroy();
        }
        
    } else {
        siendo_atraido = false;
    }
}