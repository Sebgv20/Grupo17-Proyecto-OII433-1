var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var clic = mouse_check_button_pressed(mb_left);
var presiono_esc = keyboard_check_pressed(vk_escape); // <-- Detección de la tecla ESC

// Nuevas dimensiones cuadradas del botón de la esquina
var p_ancho = 50; 
var p_alto = 50;

// Calcular la esquina superior derecha (margen de 20 píxeles)
var p_x = display_get_gui_width() - p_ancho - 20; 
var p_y = 20;

// 1. CLIC EN EL BOTÓN DE LA ESQUINA O TECLA ESC (Abrir o cerrar pausa)
var clic_icono = (clic && mx >= p_x && mx <= p_x + p_ancho && my >= p_y && my <= p_y + p_alto);

if (clic_icono || presiono_esc) {
    
    // Solo permitimos pausar si el tutorial de inicio de nivel ya fue cerrado
    if (!instance_exists(oControladorInstrucciones)) {
        
        pausado = !pausado; // Alterna entre true y false
        
        if (pausado) {
            // Congela todos los objetos de la sala excepto este botón
            instance_deactivate_all(true); 
        } else {
            // Descongela todo para seguir jugando
            instance_activate_all(); 
        }
    }
}

// 2. OPCIONES DEL MENÚ (Solo si está pausado)
if (pausado) {
    var centro_x = display_get_gui_width() / 2;
    var centro_y = display_get_gui_height() / 2;
    
    // Alturas recalculadas para 4 botones bien centrados
    var btn1_y = centro_y - 105; // 1. Reanudar
    var btn2_y = centro_y - 40;  // 2. Reiniciar Sala
    var btn3_y = centro_y + 25;  // 3. Volver al Menú
    var btn4_y = centro_y + 90;  // 4. Salir del Juego
    
    var btn_x = centro_x - (boton_ancho / 2);
    
    // --- 1. CLIC EN "REANUDAR" ---
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn1_y && my <= btn1_y + boton_alto) {
        pausado = false;
        instance_activate_all();
    }
    
    // --- 2. CLIC EN "REINICIAR SALA" ---
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn2_y && my <= btn2_y + boton_alto) {
        pausado = false;
        instance_activate_all();
        
        // Destruimos la música porque el nivel volverá a empezar
        if (instance_exists(oControladorMusica)) {
            audio_stop_sound(musicBG);
            instance_destroy(oControladorMusica);
        }
        
        // Restauramos las vidas como si fuera un inicio nuevo
        global.life = 3; 
        
        // Leemos la sala y enviamos al selector correspondiente
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
    
    // --- 3. CLIC EN "VOLVER AL MENÚ" ---
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn3_y && my <= btn3_y + boton_alto) {
        pausado = false;
        instance_activate_all(); 
        
        if (instance_exists(oControladorMusica)) {
            audio_stop_sound(musicBG);
            instance_destroy(oControladorMusica);
        }
        
        room_goto(mSelectorLevel); 
    }

    // --- 4. NUEVO: CLIC EN "SALIR DEL JUEGO" ---
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn4_y && my <= btn4_y + boton_alto) {
        game_end(); // Cierra la aplicación limpiamente
    }
}