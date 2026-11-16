// Evitar error si no hay sprite válido y memorizar el sprite real de la sala
if (!variable_instance_exists(id, "sprite_instrucciones") || !sprite_exists(sprite_instrucciones)) {
    instance_destroy();
    exit;
}
global.sprite_tutorial_actual = sprite_instrucciones;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var ancho = sprite_get_width(sprite_instrucciones);
var alto = sprite_get_height(sprite_instrucciones);

var xx = (display_get_gui_width() - ancho) / 2;
var yy = (display_get_gui_height() - alto) / 2;

var boton_x = xx + ancho - 40;
var boton_y = yy;

if (mouse_check_button_pressed(mb_left)) {
    if (mx >= boton_x && mx <= boton_x + 40 && my >= boton_y && my <= boton_y + 40) {
        io_clear(); 
        instance_destroy();
    }
}