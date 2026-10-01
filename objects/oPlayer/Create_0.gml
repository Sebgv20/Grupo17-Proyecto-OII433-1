/// Init
dir = -1;					// direction the player is facing
spd = 5;					// speed the player will move at
g = 0.2;					// gravity that applies to the player
sprite_index = sIdle1;		// animation to play
anim_speed = 0.7;			// default speed of the animation
image_speed = anim_speed;	// animation speed
global.life = 3;					// heath of the player
can_climb = false;			// flag if the player can climb
climbing = false;			// flag if the player is climbing
xspeed = 7;					// horizontal speed of the player
yspeed = -7;				// vertical speed of the player	
fall = false;				// flag if the player is falling
grav=0;						// gravity that applies to the player
gravmax=12;					// terminal velocity when falling
gravdelta=1.2;				// difference in gravity
grav_jump = -19;			// jump gravity
jump=false;					// flag if the player is jumping

/*
// camera that follows the player
view_enabled = true;
view_visible[0] = true;
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = 960;
view_hport[0] = 540;
view_camera[0] = camera_create_view(0, 0, view_wport[0], view_hport[0], 0, oPlayer, -1, -1, 1000, 1000);
surface_resize(application_surface, 960, 540);
window_set_size(view_wport[0],view_hport[0]);

// set the deadzone for gamepad input
gamepad_set_axis_deadzone(0,0.2);
*/
// 1. TAMAÑO DE LA CÁMARA (Alejar la vista)
// Aumenta estos valores para ver más de la sala (ej. 1280x720 o 1920x1080)
var cam_ancho = 1280; 
var cam_alto = 720;

// 2. TAMAÑO DE LA VENTANA (Al compilar)
// Aumenta estos valores para que la ventana física en tu monitor sea más grande
var ventana_ancho = 1280; 
var ventana_alto = 720;

view_enabled = true;
view_visible[0] = true;
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = ventana_ancho;
view_hport[0] = ventana_alto;

// Pasamos cam_ancho y cam_alto al 3er y 4to argumento para definir cuánto terreno captura la cámara
view_camera[0] = camera_create_view(0, 0, cam_ancho, cam_alto, 0, oPlayer, -1, -1, 1000, 1000);

// Redimensionamos la superficie de dibujo a la resolución de la cámara
surface_resize(application_surface, cam_ancho, cam_alto);

// Aplicamos el tamaño de la ventana
window_set_size(ventana_ancho, ventana_alto);

// Centramos la ventana en tu monitor al abrir el juego
window_center();