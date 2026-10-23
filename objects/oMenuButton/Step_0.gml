// Verificamos si el ratón está sobre el botón[cite: 5]
if (position_meeting(mouse_x, mouse_y, id)) {
    
    // Si es el primer frame en el que el ratón entra, reproducimos el sonido
    if (!is_hovering) {
        audioReproduce(soundSelect);
        is_hovering = true; // Apagamos el interruptor para que no suene en el siguiente frame
    }
    
    // Aumenta progresivamente hasta 1[cite: 5]
    hover_val = lerp(hover_val, 1, 0.15);
    
} else {
    // Si el ratón sale del botón, encendemos el interruptor para el próximo intento
    is_hovering = false;
    
    // Disminuye progresivamente hasta 0[cite: 5]
    hover_val = lerp(hover_val, 0, 0.15);
}