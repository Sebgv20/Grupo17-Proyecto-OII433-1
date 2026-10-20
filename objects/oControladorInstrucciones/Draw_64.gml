// 1. Opcional: Fondo oscuro semitransparente para resaltar las instrucciones
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// 2. Obtener dimensiones del PNG elegido
var ancho = sprite_get_width(sprite_instrucciones);
var alto = sprite_get_height(sprite_instrucciones);

// 3. Calcular coordenadas para centrarlo exactamente en la pantalla
var xx = (display_get_gui_width() - ancho) / 2;
var yy = (display_get_gui_height() - alto) / 2;

// 4. Dibujar la imagen de instrucciones
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_sprite(sprite_instrucciones, 0, xx, yy);

// 5. Dibujar el botón "X" en la esquina superior derecha
var boton_x = xx + ancho - 40; // 40 píxeles hacia la izquierda desde el borde derecho
var boton_y = yy;

draw_set_color(c_red);
draw_rectangle(boton_x, boton_y, boton_x + 40, boton_y + 40, false);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fTahoma24); // Utilizamos la fuente principal de tus textos[cite: 3]
draw_text(boton_x + 20, boton_y + 20, "X");

// Restaurar alineación
draw_set_halign(fa_left);
draw_set_valign(fa_top);