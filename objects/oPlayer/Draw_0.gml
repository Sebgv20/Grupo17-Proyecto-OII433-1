// draw the player
draw_self();


/*
// debug squares - show the corners of the sprite and its origin
draw_set_colour(c_black);
draw_rectangle(x-(sprite_get_width(sprite_index)/2)-5,y-sprite_get_height(sprite_index)-1-5,x-(sprite_get_width(sprite_index)/2)+5,y-sprite_get_height(sprite_index)-1+5,false);
draw_rectangle(x+(sprite_get_width(sprite_index)/2)-5,y-sprite_get_height(sprite_index)-1-5,x+(sprite_get_width(sprite_index)/2)+5,y-sprite_get_height(sprite_index)-1+5,false);
draw_rectangle(x-(sprite_get_width(sprite_index)/2)-5,y-1-5,x-(sprite_get_width(sprite_index)/2)+5,y-1+5,false);
draw_rectangle(x+(sprite_get_width(sprite_index)/2)-5,y-1-5,x+(sprite_get_width(sprite_index)/2)+5,y-1+5,false);


draw_set_colour(c_blue);
draw_rectangle(x-5,y-5,x+5,y+5,false);

// */


// 2. Si lleva un fantasma capturado, dibujar el número (string) encima del player
if (fantasma_capturado != "") {
    draw_set_font(fTahoma24);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var pos_texto_x = x;
    var pos_texto_y = y - sprite_height - 20; // 20 píxeles arriba de la cabeza del player
    
    // Pequeño fondo negro semitransparente para que la fracción se lea bien
    var ancho_txt = string_width(fantasma_capturado) + 16;
    var alto_txt = string_height(fantasma_capturado) + 8;
    draw_set_alpha(0.6);
    draw_set_color(c_black);
    draw_rectangle(pos_texto_x - (ancho_txt/2), pos_texto_y - (alto_txt/2), pos_texto_x + (ancho_txt/2), pos_texto_y + (alto_txt/2), false);
    
    // Dibujar el string del fantasma capturado
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_text(pos_texto_x, pos_texto_y, string(fantasma_capturado));
    
    // Restaurar configuración de dibujo
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// 3. Efecto visual del rayo de la pistola (Cono de linterna unificado)
if (disparando && fantasma_capturado == "" && longitud_rayo > 0) {
    var x_arma = x + (dir * 20);
    var y_arma = y - (sprite_height / 2);
    var x_fin = x + (dir * longitud_rayo); 
    
    var radio_apertura = longitud_rayo * 0.25; 
    
    draw_set_alpha(0.4); 
    draw_set_color(c_aqua);
    
    // Dibujamos todo el cono y el borde curvo como un solo polígono
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(x_arma, y_arma); // Punto de origen en la pistola
    
    // Calculamos hacia dónde mira el jugador (0 grados a la derecha, 180 a la izquierda)
    var angulo_base = (dir == 1) ? 0 : 180;
    
    // Trazamos los vértices del arco redondeado en el extremo
    for (var a = -90; a <= 90; a += 15) { // "15" es la suavidad del círculo
        var angulo_actual = angulo_base + a;
        var vx = x_fin + lengthdir_x(radio_apertura, angulo_actual);
        var vy = y_arma + lengthdir_y(radio_apertura, angulo_actual);
        draw_vertex(vx, vy);
    }
    draw_primitive_end();
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}