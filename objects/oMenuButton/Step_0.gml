if (position_meeting(mouse_x, mouse_y, id)) {
    if (!is_hovering) {
        audioReproduce(soundSelect);
        is_hovering = true; // Apagamos el interruptor para que no suene en el siguiente frame
    }

    hover_val = lerp(hover_val, 1, 0.15);
    
} else {
    is_hovering = false;
    hover_val = lerp(hover_val, 0, 0.15);
}