
var escala_actual = 1.0 + (0.20 * hover_val); // Aumenta hasta un 35% extra
var angulo_actual = 10 * hover_val;           // Rota hasta 35 grados
var color_actual = merge_color(c_ltgray, c_white, hover_val);

var centro_x = x + (sprite_width / 2);
var centro_y = y + (sprite_height / 2);

var matriz = matrix_build(centro_x, centro_y, 0, 0, 0, angulo_actual, escala_actual, escala_actual, 1);
matrix_set(matrix_world, matriz);

draw_sprite_ext(sprite_index, image_index, -(sprite_width / 2), -(sprite_height / 2), 1, 1, 0, color_actual, image_alpha);

draw_set_font(fTahoma24);
draw_set_color(color_actual);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(0, 0, string(texto_boton));

matrix_set(matrix_world, matrix_build_identity());
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);