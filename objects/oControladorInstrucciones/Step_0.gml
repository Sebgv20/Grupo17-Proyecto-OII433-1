// Obtener las coordenadas del clic del ratón relativas a la pantalla GUI, no a la Room[cite: 1]
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Volvemos a calcular la posición del botón para la colisión matemática
var ancho = sprite_get_width(sprite_instrucciones);
var alto = sprite_get_height(sprite_instrucciones);

var xx = (display_get_gui_width() - ancho) / 2;
var yy = (display_get_gui_height() - alto) / 2;

var boton_x = xx + ancho - 40;
var boton_y = yy;

// Si el jugador hace clic izquierdo
if (mouse_check_button_pressed(mb_left)) {
    // Verificamos si las coordenadas del ratón están dentro de los 40x40 píxeles de la "X"
    if (mx >= boton_x && mx <= boton_x + 40 && my >= boton_y && my <= boton_y + 40) {
        
        // Destruye el controlador, eliminando el cartel de la pantalla permanentemente
        instance_destroy();
    }
}