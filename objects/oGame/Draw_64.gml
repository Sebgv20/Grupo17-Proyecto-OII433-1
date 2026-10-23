// Corazones (Vidas)
for(i = 0; i < global.life; i++) {
    draw_sprite(sHeart, 0, 50 + (sprite_get_width(sHeart) * i), 50);
}

// Estrellas (Puntaje)
var estrella_x = 50;
var estrella_y = 100;

draw_sprite(sPickupStar, 0, estrella_x, estrella_y);

draw_set_font(fTahoma24);
draw_set_colour(c_black);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var centro_y_estrella = estrella_y + (sprite_get_height(sPickupStar) / 2);
draw_text(estrella_x+35, centro_y_estrella-30, string(global.puntaje));

draw_set_halign(fa_left);
draw_set_valign(fa_top);


draw_set_colour(c_white);
draw_set_alpha(button_a);
draw_circle(button_x_left, button_y, button_r, false);
draw_circle(button_x_right, button_y, button_r, false);
draw_roundrect(button_x1, button_y1_up, button_x2, button_y2_up, false);
draw_roundrect(button_x1, button_y1_down, button_x2, button_y2_down, false);
draw_circle(button_x_jump, button_y, button_r, false);
draw_set_alpha(1);											// reset alpha