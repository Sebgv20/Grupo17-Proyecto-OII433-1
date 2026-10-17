draw_self();

if (string(fraccion_texto) != "") {	
	draw_set_font(fTahoma24); 
    draw_set_color(c_white);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Calculamos el centro basándonos en la posición visual (x, y) del sprite
    // Esto asume que el punto de origen (Origin) de tu sprite está en "Top Left" (0,0)
    var centro_x = x + (sprite_width / 2);
    var centro_y = y + (sprite_height / 2) + 7;
    draw_text(centro_x, centro_y, string(fraccion_texto));
    
    // Restaurar valores de dibujo
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}