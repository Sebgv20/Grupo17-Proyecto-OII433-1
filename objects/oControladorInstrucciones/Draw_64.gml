draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

var ancho = sprite_get_width(sprite_instrucciones);
var alto = sprite_get_height(sprite_instrucciones);

var xx = (display_get_gui_width() - ancho) / 2;
var yy = (display_get_gui_height() - alto) / 2;

// Imagen tutorial
draw_set_alpha(1.0);
draw_set_color(c_white);
draw_sprite(sprite_instrucciones, 0, xx, yy);

// Botón de cierre
var boton_x = xx + ancho - 40;
var boton_y = yy;

draw_set_color(c_red);
draw_rectangle(boton_x, boton_y, boton_x + 40, boton_y + 40, false);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fTahoma24);
draw_text(boton_x + 20, boton_y + 20, "X");

draw_set_halign(fa_left);
draw_set_valign(fa_top);