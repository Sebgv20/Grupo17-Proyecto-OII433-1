// 1. Determinar el color de la caja
var color_caja = c_white; // Color por defecto

if (auxiliar) {
    // Creamos un color café usando RGB (Rojo: 150, Verde: 75, Azul: 0)
    color_caja = make_color_rgb(150, 75, 0); 
}

// 2. Dibujar la caja con su color (Esto reemplaza a draw_self())
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, color_caja, image_alpha);

if (ocupado) {
    var centro_x = bbox_left + (sprite_width / 2);
    var centro_y = bbox_top + (sprite_height / 2);
    
    var color_dibujo = c_white;
    
    // Si hay un error activo, calculamos el color actual y reducimos el timer
    if (color_Incorrecto > 0) {
        // Mezcla el blanco y el rojo basándose en el valor de error_fade (de 1.0 a 0.0)
        color_dibujo = merge_color(c_white, c_red, color_Incorrecto);
        
        // Reducimos el valor asumiendo 60 FPS (1 segundo en total)
        color_Incorrecto -= (1 / 60); 
    }
	
	else if (color_Correcto > 0) {
        color_dibujo = merge_color(c_white, c_green, color_Correcto);
        color_Correcto -= (1 / 60);
    }
	
    
    // Dibujamos el fantasma con el color normal o rojo si parpadea
    draw_sprite_ext(sprite_fantasma, 0, centro_x-25, centro_y-25, 0.8, 0.8, 0, color_dibujo, 0.5);
    
    // Dibujamos la fracción del fantasma
    draw_set_font(fTahoma24); // Asegúrate de usar la fuente que corresponda
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white); 
    //draw_text(centro_x, bbox_top - 15, string(fantasma_guardado));
	draw_text(centro_x, bbox_top+42, string(fantasma_guardado));
    
    // Restaurar valores
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}