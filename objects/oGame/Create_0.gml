/// Init
tilesize = 64;															// size of tiles
map = layer_tilemap_get_id("Collisions");								// this will be the layer we use for collisions
hills = layer_get_all_elements("Hills");								// all the hill sprites
stars = layer_get_all_elements("Stars");								// all the star sprites
clouds = layer_get_all_elements("Clouds");	

// prueba para los logs 
global.puntaje = 0;
global.life = 3;
scrIniciarLogs();
// Iniciar cronometro solamente en salas jugables del nivel 1
if (room == rLevel1_1 || room == rLevel1_2 || room == rLevel1_3) {
    scrIniciarNivel(1);
}
// Iniciar seguimiento del nivel 2
if (room == rLevel2_1 || room == rLevel2_2 || room == rLevel2_3) {
    scrIniciarNivel(2);
}

// Iniciar seguimiento del nivel 3
if (room == rLevel3_1 || room == rLevel3_2 || room == rLevel3_3) {
    scrIniciarNivel(3);
}

switch(room){
	case rSand:															// if we are in the sand room
		for(i=0;i<array_length(hills);i++){							// loop through all the hill sprites
			if(layer_sprite_get_sprite(hills[i]) == sBGHills_grass){	// if the sprite is a default grass one
				layer_sprite_change(hills[i],sBGHills_sand);			// set it to the default sand one
			} else {													// if its not the default
				layer_sprite_change(hills[i],sBGHills1_sand);			// set it to the other sand one
			}
		}
		for(i=0;i<array_length(clouds);i++){							// loop through all the cloud sprites
			if(layer_sprite_get_sprite(clouds[i]) == sCloud_grass){		// if the sprite is a default grass one
				layer_sprite_change(clouds[i],sCloud_sand);				// set it to the default sand one
			} else {													// if its not the default
				layer_sprite_change(clouds[i],sCloud1_sand);			// set it to the other sand one
			}
		}
		for(i=0;i<array_length(stars);i++){							// loop through all the star sprites
			layer_sprite_change(stars[i],sStar_sand);					// set them to the sand ones
		}
		break;
}

// ==========================================
// REGISTRO INICIAL DEL ESTUDIANTE (LOGIN)
// ==========================================
if (!variable_global_exists("rut_jugador")) {
    var rut_ingresado = "";
    while (string_trim(rut_ingresado) == "") {
        rut_ingresado = get_string("Bienvenido(a) a Learn2Math\n\nIngresa tu RUT sin puntos y con guion (ej: 20123456-7):", "");
    }
    global.rut_jugador = string_trim(rut_ingresado);
}

if (!variable_global_exists("nombre_jugador")) {
    var nom_ingresado = "";
    while (string_trim(nom_ingresado) == "") {
        nom_ingresado = get_string("Ingresa tu Nombre o Alias para la Tabla de Clasificación:", "");
    }
    global.nombre_jugador = string_trim(nom_ingresado);
}

// Sincronizar con el idJugador de telemetría de logs
global.idJugador = global.rut_jugador;

// Variables de interacción y gamificación (se inicializan una sola vez)
if (!variable_global_exists("estrellas"))     global.estrellas = 0;
if (!variable_global_exists("aciertos"))      global.aciertos = 0;
if (!variable_global_exists("fallos"))        global.fallos = 0;
if (!variable_global_exists("puntos"))        global.puntos = 0;
if (!variable_global_exists("life"))          global.life = 3; // Corazones del juego

// Cronómetro general acumulativo
if (!variable_global_exists("tiempo_total"))  global.tiempo_total = 0; // En segundos
if (!variable_global_exists("timer_activo"))  global.timer_activo = true;

// on screen controls
button_pressed = false;													// flag to see if any button is being pressed
button_down_left = false;												// if the left button is pressed
button_down_right = false;												// if the up button is pressed
button_down_up = false;													// if the down button is pressed
button_down_down = false;												// if the right button is pressed
button_down_jump = false;												// if the jump button is pressed
button_x_left = 100;													// set the x value for the left button	
button_x_right = 300;													// set the x value for the right button
button_x_jump = view_wport[0]-100;										// set the x value for the jump button
button_y = view_hport[0] - 100;											// set the y value for the buttons
button_r = 80;															// radius of buttons
button_a = 0;															// used to fade in the buttons
button_x1 = view_wport[0]-300-button_r;									// left x value of up and down buttons
button_x2 = view_wport[0]-300+button_r;									// right x value of up and down buttons	
button_y1_up = button_y-button_r;										// top y value of up button
button_y2_up = button_y-(button_r/8);									// bottom y value of up button
button_y1_down = button_y+(button_r/8);									// top y value of down button
button_y2_down = button_y+button_r;										// bottom y value of down button