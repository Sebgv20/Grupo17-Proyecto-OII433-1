// Nuevas dimensiones y posición
var p_ancho = 50;
var p_alto = 50;
var p_x = display_get_gui_width() - p_ancho - 20;
var p_y = 20;

// 1. DIBUJAR FONDO DEL BOTÓN DE PAUSA (Esquina derecha)
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(p_x, p_y, p_x + p_ancho, p_y + p_alto, false);

// 2. DIBUJAR SÍMBOLO DE PAUSA "||"
draw_set_alpha(1.0);
draw_set_color(c_white);

// Calculamos el centro del recuadro
var centro_x = p_x + (p_ancho / 2);
var centro_y = p_y + (p_alto / 2);

// Medidas de las barras
var ancho_barra = 6;
var alto_barra = 12; // Altura desde el centro (24 px de alto total)
var separacion = 5;  // Distancia del centro hacia cada barra

// Barra izquierda
draw_rectangle(centro_x - separacion - ancho_barra, centro_y - alto_barra, centro_x - separacion, centro_y + alto_barra, false);

// Barra derecha
draw_rectangle(centro_x + separacion, centro_y - alto_barra, centro_x + separacion + ancho_barra, centro_y + alto_barra, false);


// 2. DIBUJAR MENÚ SI ESTÁ PAUSADO
if (pausado) {
    var ancho_pantalla = display_get_gui_width();
    var alto_pantalla = display_get_gui_height();
    
    // Fondo oscuro sobre toda la pantalla
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_rectangle(0, 0, ancho_pantalla, alto_pantalla, false);
    
    var centro_xx = ancho_pantalla / 2;
    var centro_yy = alto_pantalla / 2;
    
    // --- CORRECCIÓN: Configurar alineación centrada para los textos ---
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Título principal
    draw_set_alpha(1.0);
    draw_set_color(c_yellow);
    draw_text(centro_xx, centro_yy - 140, "PAUSA");
    
    // Coordenadas calculadas idénticas a las del Step
    var btn_x = centro_xx - (boton_ancho / 2);
    var btn1_y = centro_yy - 80;
    var btn2_y = centro_yy - 15;
    var btn3_y = centro_yy + 50;
    
    // Botón "Reanudar"
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn1_y, btn_x + boton_ancho, btn1_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn1_y + (boton_alto / 2), "Reanudar");
    
    // Botón "Reiniciar Sala"
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn2_y, btn_x + boton_ancho, btn2_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn2_y + (boton_alto / 2), "Reiniciar Sala");
    
    // Botón "Volver al Menú"
    draw_set_color(c_dkgray);
    draw_rectangle(btn_x, btn3_y, btn_x + boton_ancho, btn3_y + boton_alto, false);
    draw_set_color(c_white);
    draw_text(centro_xx, btn3_y + (boton_alto / 2), "Volver al menu");
}

// Restaurar alineaciones a la normalidad para no afectar otros objetos[cite: 4]
draw_set_halign(fa_left);
draw_set_valign(fa_top);