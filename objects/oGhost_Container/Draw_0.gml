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
    
    // A. Dibujar el fantasma normal siempre (con el 0.5 de alpha que ya tenías)
    draw_sprite_ext(sprite_fantasma, 0, centro_x-25, centro_y-25, 0.8, 0.8, 0, c_white, 0.5);
    
    // B. Efecto de parpadeo SÓLIDO con GPU Fog (Niebla)
    if (color_Incorrecto > 0) {
        // Encendemos la niebla forzando un color rojo 100% opaco
        gpu_set_fog(true, c_red, 0, 0);
        
        // Dibujamos la silueta roja encima usando "color_Incorrecto" como su Alpha (funde de 1.0 a 0.0)
        draw_sprite_ext(sprite_fantasma, 0, centro_x-25, centro_y-25, 0.8, 0.8, 0, c_white, color_Incorrecto);
        
        // Apagamos la niebla inmediatamente para no manchar otros objetos del juego
        gpu_set_fog(false, c_white, 0, 0);
        
        // Reducimos el valor asumiendo 60 FPS (1 segundo en total)
        color_Incorrecto -= (1 / 60); 
    }
    else if (color_Correcto > 0) {
        // Encendemos la niebla forzando un color verde 100% opaco
        gpu_set_fog(true, c_green, 0, 0);
        
        // Dibujamos la silueta verde encima
        draw_sprite_ext(sprite_fantasma, 0, centro_x-25, centro_y-25, 0.8, 0.8, 0, c_white, color_Correcto);
        
        gpu_set_fog(false, c_white, 0, 0);
        
        color_Correcto -= (1 / 60);
    }
    
    // C. Dibujar la fracción del fantasma
    draw_set_font(fTahoma24); 
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Al texto sí le aplicamos merge_color porque el texto base es blanco opaco y se tiñe perfecto
    var color_texto = c_white;
    if (color_Incorrecto > 0) color_texto = merge_color(c_white, c_red, color_Incorrecto);
    else if (color_Correcto > 0) color_texto = merge_color(c_white, c_green, color_Correcto);
    
    draw_set_color(color_texto); 
    draw_text(centro_x, bbox_top+42, string(fantasma_guardado));
    
    // Restaurar valores
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}