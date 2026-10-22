var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var clic = mouse_check_button_pressed(mb_left);

// Nuevas dimensiones cuadradas
var p_ancho = 50; 
var p_alto = 50;

// Calcular la esquina superior derecha (margen de 20 píxeles)
var p_x = display_get_gui_width() - p_ancho - 20; 
var p_y = 20;

// 1. CLIC EN EL BOTÓN DE PAUSA (Con bloqueo de tutorial)
if (clic && mx >= p_x && mx <= p_x + p_ancho && my >= p_y && my <= p_y + p_alto) {
    
    // Solo permitimos pausar si el tutorial de inicio de nivel ya fue cerrado y destruido
    if (!instance_exists(oControladorInstrucciones)) {
        
        pausado = !pausado; // Alterna entre true y false
        
        if (pausado) {
            // Congela todos los objetos de la sala excepto este botón de pausa
            instance_deactivate_all(true); 
        } else {
            // Descongela todo para seguir jugando
            instance_activate_all(); 
        }
    }
}

// 2. CLIC EN LAS OPCIONES DEL MENÚ (Solo si está pausado)
if (pausado) {
    var centro_x = display_get_gui_width() / 2;
    var centro_y = display_get_gui_height() / 2;
    
    // Coordenadas calculadas para 3 botones (separados por pequeños márgenes)
    var btn1_y = centro_y - 80; // Reanudar (Arriba)
    var btn2_y = centro_y - 15; // Reiniciar (Medio)
    var btn3_y = centro_y + 50; // Volver al Menú (Abajo)
    var btn_x = centro_x - (boton_ancho / 2);
    
    // --- CLIC EN "REANUDAR" ---
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn1_y && my <= btn1_y + boton_alto) {
        pausado = false;
        instance_activate_all();
    }
    
    // --- NUEVO: CLIC EN "REINICIAR SALA" ---
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
            room_restart(); // Por si acaso se usa en una sala sin número
        }
    }
    
    // --- CLIC EN "VOLVER AL MENÚ" ---
    if (clic && mx >= btn_x && mx <= btn_x + boton_ancho && my >= btn3_y && my <= btn3_y + boton_alto) {
        pausado = false;
        instance_activate_all(); 
        
        if (instance_exists(oControladorMusica)) {
            audio_stop_sound(musicBG);
            instance_destroy(oControladorMusica);
        }
        
        room_goto(mSelectorLevel); 
    }
}