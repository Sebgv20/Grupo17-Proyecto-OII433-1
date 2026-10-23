var p_ancho = 50;
var p_alto = 50;
var p_x = display_get_gui_width() - p_ancho - 20;
var p_y = 20;

// Borde botón
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(p_x, p_y, p_x + p_ancho, p_y + p_alto, false);

// Símbolo pausa
draw_set_alpha(1.0);
draw_set_color(c_white);


var centro_x = p_x + (p_ancho / 2);
var centro_y = p_y + (p_alto / 2);


var ancho_barra = 6;
var alto_barra = 12; // Altura desde el centro (24 px de alto total)
var separacion = 5;  // Distancia del centro hacia cada barra


draw_rectangle(centro_x - separacion - ancho_barra, centro_y - alto_barra, centro_x - separacion, centro_y + alto_barra, false);
draw_rectangle(centro_x + separacion, centro_y - alto_barra, centro_x + separacion + ancho_barra, centro_y + alto_barra, false);


// Menu activo
if (pausado) {
    var ancho_pantalla = display_get_gui_width();
    var alto_pantalla = display_get_gui_height();
    
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(0, 0, ancho_pantalla, alto_pantalla, false);
    
    var centro_xx = ancho_pantalla / 2;
    var centro_yy = alto_pantalla / 2;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Título
    draw_set_alpha(1.0);
    draw_set_color(c_yellow);
    draw_text(centro_xx, centro_yy - 155, "PAUSA");
    
    var btn_x  = centro_xx - (boton_ancho / 2);
    var btn1_y = centro_yy - 105; // 1. Reanudar
    var btn2_y = centro_yy - 40;  // 2. Reiniciar Sala
    var btn3_y = centro_yy + 25;  // 3. Volver al Menú
    var btn4_y = centro_yy + 90;  // 4. Salir del Juego
    
	// Reanudar
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn1_y, btn_x + boton_ancho, btn1_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn1_y + (boton_alto / 2), "Reanudar");
    
    // Reiniciar sala
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn2_y, btn_x + boton_ancho, btn2_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn2_y + (boton_alto / 2), "Reiniciar Sala");
    
    // Volver al menu
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn3_y, btn_x + boton_ancho, btn3_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn3_y + (boton_alto / 2), "Volver al Menu");

    // Salir del juego
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn4_y, btn_x + boton_ancho, btn4_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn4_y + (boton_alto / 2), "Salir del Juego");
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);