draw_self();

var centro_x = x + (sprite_width / 2);

if (bloqueada) {
    var centro_y = y + (sprite_height / 2);
    // Dibuja el candado justo en el centro de la puerta
    draw_sprite(Candado, 0, centro_x, centro_y);
} else {
    // Solo mostramos el indicador de interacción si ya no hay candado
    if (place_meeting(x, y, oPlayer)) {
        var prompt_y = bbox_top - 25; 
        
        draw_set_alpha(0.7);
        draw_set_color(c_black);
        draw_rectangle(centro_x - 45, prompt_y - 15, centro_x + 45, prompt_y + 15, false);
        
        draw_set_alpha(1.0);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(centro_x, prompt_y, "W");
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}