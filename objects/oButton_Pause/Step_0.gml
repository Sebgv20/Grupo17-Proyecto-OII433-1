var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var clic = mouse_check_button_pressed(mb_left);
var presiono_esc = keyboard_check_pressed(vk_escape); // <-- Detección de la tecla ESC

var p_ancho = 50; 
var p_alto = 50;

var p_x = display_get_gui_width() - p_ancho - 20; 
var p_y = 20;

var clic_icono = (clic && mx >= p_x && mx <= p_x + p_ancho && my >= p_y && my <= p_y + p_alto);
if (clic_icono || presiono_esc) {
    if (!instance_exists(oControladorInstrucciones)) {        
        pausado = !pausado;
        
        if (pausado) {
            instance_deactivate_all(true); 
        } else {
            instance_activate_all(); 
        }
    }
}

// Opciones menu
if (pausado) {
    var centro_x = display_get_gui_width() / 2;
    var centro_y = display_get_gui_height() / 2;
    
    var btn1_y = centro_y - 105; // 1. Reanudar
    var btn2_y = centro_y - 40;  // 2. Reiniciar Sala
    var btn3_y = centro_y + 25;  // 3. Volver al Menú
    var btn4_y = centro_y + 90;  // 4. Salir del Juego
    
    var btn_x = centro_x - (boton_ancho / 2);
    
    // CLick reanudar
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn1_y && my <= btn1_y + boton_alto) {
        pausado = false;
        instance_activate_all();
    }
    
    // click reiniciar sala
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn2_y && my <= btn2_y + boton_alto) {
        pausado = false;
        instance_activate_all();
        
        if (instance_exists(oControladorMusica)) {
            audio_stop_sound(musicBG);
            instance_destroy(oControladorMusica);
        }
        global.life = 3; 

        var nombre_sala = room_get_name(room);
        
        if (string_pos("Level3", nombre_sala) > 0) {
            room_goto(rLevel3Selector);
        } else if (string_pos("Level2", nombre_sala) > 0) {
            room_goto(rLevel2Selector);
        } else if (string_pos("Level1", nombre_sala) > 0) {
            room_goto(rLevel1Selector);
        } else {
            room_restart();
        }
    }
    
    // Click volver menu
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn3_y && my <= btn3_y + boton_alto) {
        pausado = false;
        instance_activate_all(); 
        
        if (instance_exists(oControladorMusica)) {
            audio_stop_sound(musicBG);
            instance_destroy(oControladorMusica);
        }
        
        room_goto(mSelectorLevel); 
    }

    // Click cerrar juego
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn4_y && my <= btn4_y + boton_alto) {
        game_end();
    }
}