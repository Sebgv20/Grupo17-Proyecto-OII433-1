// 1. Calcular los valores dinámicos según el estado del hover
var escala_actual = 1.0 + (0.20 * hover_val); // Aumenta hasta un 35% extra
var angulo_actual = 10 * hover_val;           // Rota hasta 35 grados
var color_actual = merge_color(c_ltgray, c_white, hover_val); // Transición de gris (oscurecido) a blanco (normal)

// 2. Calcular el centro exacto del botón[cite: 1]
var centro_x = x + (sprite_width / 2);
var centro_y = y + (sprite_height / 2);

// 3. Crear y aplicar una matriz para escalar y rotar desde el centro calculado
var matriz = matrix_build(centro_x, centro_y, 0, 0, 0, angulo_actual, escala_actual, escala_actual, 1);
matrix_set(matrix_world, matriz);

// 4. Dibujar el sprite desplazado para centrarlo (asumiendo origen Top-Left)
draw_sprite_ext(sprite_index, image_index, -(sprite_width / 2), -(sprite_height / 2), 1, 1, 0, color_actual, image_alpha);

// 5. Configurar el texto[cite: 1]
draw_set_font(fTahoma24);
draw_set_color(color_actual); // El texto se aclarará junto con el botón
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 6. Dibujar el texto que hayas definido en la Room[cite: 1]
// Las coordenadas son 0,0 porque la matriz ya movió el "mundo" al centro del botón
draw_text(0, 0, string(texto_boton));

// 7. Restaurar el mundo y los valores a la normalidad[cite: 1]
matrix_set(matrix_world, matrix_build_identity());
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);