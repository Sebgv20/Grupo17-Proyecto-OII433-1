// --- 1. DIBUJAR LAS VIDAS (CORAZONES) ---
for(i = 0; i < global.life; i++) {
    // Dibuja los corazones alineados arriba a la izquierda.
    // X = 50, Y = 50. Separación = ancho del sprite * i
    draw_sprite(sHeart, 0, 50 + (sprite_get_width(sHeart) * i), 50);
}

// --- 2. DIBUJAR EL PUNTAJE DE ESTRELLAS DEBAJO DE LAS VIDAS ---
// Definimos las coordenadas de la estrella.
// La X es 50 (alineada con el primer corazón). La Y es 100 (50 píxeles más abajo que las vidas).
var estrella_x = 50;
var estrella_y = 100;

// Dibujamos el icono de la estrella
draw_sprite(sPickupStar, 0, estrella_x, estrella_y);

// Configuración para el texto del puntaje
draw_set_font(fTahoma24);
draw_set_colour(c_black);

// Alineamos a la izquierda para que el texto crezca hacia la derecha, alejándose del icono.
// Alineamos en "middle" para centrar el texto verticalmente respecto al icono.
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

// Calculamos el centro vertical exacto del icono de la estrella
var centro_y_estrella = estrella_y + (sprite_get_height(sPickupStar) / 2);

// Dibujamos el número (global.puntaje).
// Le sumamos a estrella_x el ancho del sprite + un margen (ej: 10px) para que el número aparezca justo a su derecha.
draw_text(estrella_x+35, centro_y_estrella-30, string(global.puntaje));

// Restaurar alineaciones a la normalidad (muy importante para no desfasar los controles táctiles de abajo u otros textos)
draw_set_halign(fa_left);
draw_set_valign(fa_top);


// --- 3. CONTROLES EN PANTALLA (SIN CAMBIOS) ---
draw_set_colour(c_white);
draw_set_alpha(button_a);
draw_circle(button_x_left, button_y, button_r, false);
draw_circle(button_x_right, button_y, button_r, false);
draw_roundrect(button_x1, button_y1_up, button_x2, button_y2_up, false);
draw_roundrect(button_x1, button_y1_down, button_x2, button_y2_down, false);
draw_circle(button_x_jump, button_y, button_r, false);
draw_set_alpha(1);											// reset alpha