draw_self();

// Dibujar el indicador "W / Arriba" si el jugador se acerca
if (place_meeting(x, y, oPlayer)) {
    var prompt_y = bbox_top - 135; 
    
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(x - 45, prompt_y - 15, x + 45, prompt_y + 15, false);
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, prompt_y, "W");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}