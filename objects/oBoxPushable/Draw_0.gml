draw_self();

// Dibujar el texto si la variable no está vacía
if (string(fraccion_texto) != "") {
    draw_set_font(fTahoma24); // Utilizamos la fuente base de tus textos[cite: 1]
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    
    // Calcular el centro exacto de la caja[cite: 2]
    var centro_x = x + (sprite_width / 2); 
	var centro_y = y + (sprite_width / 2); 
    
    // Dibujar flotando arriba de la caja
    draw_text(centro_x, centro_y, string(fraccion_texto));
    
    // Restaurar valores
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}