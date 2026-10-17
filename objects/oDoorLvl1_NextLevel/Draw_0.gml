// 1. Dibujar el propio sprite de la puerta
draw_self();

// 2. Comprobar si el jugador está frente a la puerta
if (place_meeting(x, y, oPlayer)) {
    
    // Calculamos el centro visual de la puerta (asumiendo que su origen es Top-Left)
    var centro_x = x + (sprite_width / 2);
    var prompt_y = bbox_top - 25; // Altura flotante sobre la puerta
    
    // Cuadro negro semitransparente centrado
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(centro_x - 45, prompt_y - 15, centro_x + 45, prompt_y + 15, false);
    
    // Texto indicando las teclas
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_text(centro_x, prompt_y, "W");
    
    // Restaurar alineación
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}