// 1. Dibujar al jugador (siempre primero para que el arma quede por encima)
draw_self();

// 2. Calcular coordenadas de la empuñadura de la pistola
var offset_x = 30; // 1. Empuja la pistola hacia adelante (Ajusta este número)
var offset_y = 10; // 2. Baja/Sube la pistola (Positivo baja, Negativo sube)

var mano_x = x + (dir * offset_x);
var mano_y = (y - (sprite_height / 2)) + offset_y; 

// 3. Calcular coordenadas de la punta (Donde nace el láser)
var largo_arma = 18; // 3. Modifica esto según lo largo que sea el cañón de tu arma
var x_punta = mano_x + (dir * largo_arma);
var y_punta = mano_y; // 4. Si el cañón está más arriba que la empuñadura, resta píxeles aquí (Ej: mano_y - 4)

// 4. Dibujar la pistola independiente (se oculta al escalar)
if (!climbing) {
    // Cambia 'sPistola' por el nombre real de tu recurso
    draw_sprite_ext(sPistola, 0, mano_x, mano_y, dir, 1, 0, c_white, 1);
}



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

// 6. Efecto visual del rayo de la pistola (Naciendo en la punta)
if (disparando && fantasma_capturado == "" && longitud_rayo > 0 && !climbing) {
    // El rayo ahora llega hasta la longitud deseada desde la punta
    var x_fin = x_punta + (dir * longitud_rayo); 
    var radio_apertura = longitud_rayo * 0.25;
    
    draw_set_alpha(0.4);
    draw_set_color(c_aqua);
    
    // Trazamos el abanico poligonal desde la punta de la pistola
    draw_primitive_begin(pr_trianglefan);
    draw_vertex(x_punta, y_punta); // <-- EL CONO NACE AQUÍ
    
    var angulo_base = (dir == 1) ? 0 : 180;
    
    for (var a = -90; a <= 90; a += 15) {
        var angulo_actual = angulo_base + a;
        var vx = x_fin + lengthdir_x(radio_apertura, angulo_actual);
        var vy = y_punta + lengthdir_y(radio_apertura, angulo_actual);
        draw_vertex(vx, vy);
    }
    draw_primitive_end();
    
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}