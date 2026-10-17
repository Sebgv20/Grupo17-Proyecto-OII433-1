function scrProcessPlayer() {
	var xx,yy,c1,c2,c3,c4;

	// Apply gravity (and jumping)
	y = y+grav;
	grav+=gravdelta;
	if( grav>=gravmax ) grav=gravmax;

	/////////////////////
	//    JUMP/FALL    //
	/////////////////////

	if(!jump){									// if we are already jumping dont do anything
		if((keyboard_check(vk_space)) || (gamepad_button_check(0,gp_face1))){
			grav=grav_jump;						// make the player jump
			jump=true;							// flag that we are jumping	
		}
	}

	// check gamepad left stick
	stick_l_h = gamepad_axis_value(0,gp_axislh);// get the horizontal value from the left stick
	stick_l_v = gamepad_axis_value(0,gp_axislv);// get the vertical value from the left stick

	// horizontal movement
	if(stick_l_h < 0){							// if the stick is to the left move left
		move_left = true;
		move_right = false;
	} else if(stick_l_h > 0){					// if the stick is to the right move left
		move_left = false;
		move_right = true;
	} else {									// if it is neither then dont move
		move_left = false;
		move_right = false;
	}
	// vertical movement
	if(stick_l_v < 0){							// if the stick is to the top move up
		move_up = true;
		move_down = false;
	} else if(stick_l_v > 0){					// if the stick is to the bottom move down
		move_up = false;
		move_down = true;
	} else {									// if it is neither then dont move
		move_up = false;
		move_down = false;
	}

	// --- NUEVO: Variable para agrupar los inputs de presionar hacia abajo ---
	var presiona_abajo = (keyboard_check(ord("S"))) || (oGame.button_down_down == true) || (gamepad_button_check(0,gp_padd)) || (move_down);


	if( grav<0 ){								// If jumping check above player
	    sprite_index = sJump;
	} else {									// otherwise, falling so check UNDER the player
	    if(jump){								// if coming down after jumping display the correct sprite
	        sprite_index = sJumpFall;
	    } else if(fall){						// if falling from an edge display the fall sprite
	        sprite_index = sFall;    
	    } else {								// if not already falling or jumping
			grav = 0;							// first stop falling (used for ladders)
			fall = true;						// flag that we are falling
		}
		// check the points at the bottom of the player character
		c1 = tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y);	// left
		c2 = tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y);	// right
		c3 = tilemap_get_at_pixel(oGame.map,x,y);										// center

		if( c1>=1 || c2>=1 || c3 >= 1){			// if they are intersecting with a tile
			
			// 1. COLISIÓN SÓLIDA NORMAL Y CAJAS (Índices 1 y 3)
			if((c1 == 1) || (c2 == 1) || (c3 == 1) || (c1 == 3) || (c2 == 3) || (c3 == 3)){
				// if the tile we are intersecting with cannot be fallen through
				y = real(y&$ffffffc0);			// move the sprite to the top of the tile
				sprite_index = sIdle1;			// set the sprite to the idle sprite
				climbing = false;				// stop any climbing
				jump = false;					// stop any jumping
				fall = false;					// stop any falling
			}
			
			// --- NUEVO: 2. PLATAFORMA TRASPASABLE (Índice 4) ---
			else if ((c1 == 4) || (c2 == 4) || (c3 == 4)) {
				var tope_tile_y = real(y&$ffffffc0);
				
				// Usamos 'yprevious' (variable nativa) para saber dónde estaba el jugador 
				// exactamente antes de que la gravedad de este frame lo empujara hacia abajo
				if (!presiona_abajo && (yprevious <= tope_tile_y)) {
					y = tope_tile_y;			
					sprite_index = sIdle1;	
					climbing = false;				
					jump = false;					
					fall = false;	
				}
			}
			
			// Ejemplo dentro de la verificación de colisiones en scrProcessPlayer:
			if (c1 == 5 || c2 == 5 || c3 == 5) {
			    // Si el jugador toca el tile 5 (oGhost_Container), puedes hacer que actúe como suelo sólido:
			    y = real(y & $ffffffc0);
			    sprite_index = sIdle1;
			    climbing = false;
			    jump = false;
			    fall = false;
			}
			
			// ESCALERAS (Índice 2)
			if(c3 == 2){						// if we are intersecting with a ladder (corregí un pequeño error duplicado que tenías aquí)
				can_climb = true;				// flag that we can climb
			}
		} else {								// if we are not intersecting any tiles
			climbing = false;					// flag that we cannot climb
		}
	}    

	/////////////////////
	//     MOVING      //
	/////////////////////

	if( (keyboard_check(ord("A"))) || (oGame.button_down_left == true) || (gamepad_button_check(0,gp_padl)) || (move_left)){				// moving left collisions
	    dir=-1;									// set the correct direction
		image_xscale = dir;						// make the sprite face the correct direction
		climbing = false;						// since we are moving left we are not climbing
		can_climb = false;						// and we cannot climb
	    if(!jump && !fall){						// if we are not jumping or falling
	        sprite_index = sWalk;				// set the sprite to walking
	    }
	    x=x-xspeed								// move the player left
	    c2 = -1;
		c3 = -1;
		// check the points at the bottom of the sprite
	    c1 = tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y-1);				// left
	    c3 = tilemap_get_at_pixel(oGame.map,x,y-1);													// center
	    if( y&$3f>0 ) c2=tilemap_get_at_pixel(oGame.map,x-(sprite_get_width(sprite_index)/2),y+1);	// left below (only check if there is a tile below)
	    if((c1 == 3) || (c2 == 3)){																	// if we are intersecting with a box
			x = real(x&$ffffffc0)+(sprite_get_width(sprite_index)/2);								// stop the player from moving
	    }
		if(c3 == 2){							// if we are intersecting with a ladder
			can_climb = true;					// flag that we can climb
		} else {								// if we are not a ladder
			can_climb = false;					// flag we cant climb
			image_speed = anim_speed;			// make sure the animations will play at correct speed
		}
		/*Teleport al otro extremo de la sala (Borde Izquierdo)		
		if(x < 0){								// the the player has moved off the edge of the screen
			x = room_width;						// wrap around to the other side of the screen
		}*/
		
		var half_width = sprite_get_width(sprite_index) / 2;
		if(x - half_width < 0){					
			x = half_width;						// Frena al jugador exactamente contra el borde izquierdo
		}
		
	}else if( (keyboard_check(ord("D"))) || (oGame.button_down_right == true) || (gamepad_button_check(0,gp_padr)) || (move_right)){			// moving right collisions (check with else so that both directions cant be triggered at the same time)
	    dir=1;									// set the correct direction
		image_xscale = dir;						// make the sprte face the correct direction 
		climbing = false;						// set that we are not climbing
		can_climb = false;						// set that we cant climb
	    if(!jump && !fall){						// if we are not jumping or falling
	        sprite_index = sWalk;				// set the sprite to walking
	    }
	    x=x+xspeed;								// move the player right
	    c2 = -1;
		c3 = -1;
		// check the points at the bottom of the sprite
	    c1 = tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y-1);				// right
		c3 = tilemap_get_at_pixel(oGame.map,x,y-1);													// center
	    if( y&$3f>0 ) c2=tilemap_get_at_pixel(oGame.map,x+(sprite_get_width(sprite_index)/2),y+1);	// right below (only check if there is a tile below)
	    if((c1 == 3) || (c2 == 3)){																	// if we are intersecting with a box
				x = real(x&$ffffffc0)+oGame.tilesize-(sprite_get_width(sprite_index)/2);			// stop the player from moving
	    }
		if(c3 == 2){							// if we are intersecting with a ladder
			can_climb = true;					// flag that we can climb
		} else {								// if we are not a ladder
			can_climb = false;					// flag we cant climb
			image_speed = anim_speed;			// make sure the animations will play at correct speed
		}
		/*Teleport al otro extremo de la sala (Borde Derecho)
		if(x > room_width){						// the the player has moved off the edge of the screen
			x = 0;								// wrap around to the other side of the screen
		}*/
		
		var half_width = sprite_get_width(sprite_index) / 2;
		if(x + half_width > room_width){		
			x = room_width - half_width;		// Frena al jugador exactamente contra el borde derecho
		}
	
	} else if(!can_climb){						// if we are not moving left or right check that we are not climbing
		if(!jump){
			sprite_index = choose(sIdle1,sIdle2);	// set the sprite to one of the idles (choose at random)
		}
		image_speed = anim_speed;				// set the speed of the sprite to the correct level
	}

	/////////////////////
	//    Climbing     //
	/////////////////////

	if(can_climb){									// if we can climb
		c3 = tilemap_get_at_pixel(oGame.map,x,y-1);	// check the bottom center of the sprite
		if(c3 == 2){								// if it is still on a ladder
			if( (keyboard_check(ord("W"))) || (oGame.button_down_up == true) || (gamepad_button_check(0,gp_padu)) || (move_up)){				// and we are pressing up
				y = y+yspeed;						// move the player up the ladder
				image_index+=0.3;					// manually control which frame of the animation we are on 
				climbing = true;					// flag that we are now climbing
			}
			if( (keyboard_check(ord("S"))) || (oGame.button_down_down == true) || (gamepad_button_check(0,gp_padd)) || (move_down)){			// or if we are pressing down
				y = y-yspeed;						// move the player down the ladder
				image_index+=0.3;					// manually control which frame of the animation we are on 
				climbing = true;					// flag that we are now climbing
			}
			if(climbing){							// if we are climbing
				jump = false;						// make sure we are not jumping
				fall = false;						// make sure that we are not falling
				sprite_index = sClimb;				// set the sprite to climbing
				image_speed = 0						// stop the animation from playing as we are controlling that manually
				x = real(x&$ffffffc0)+oGame.tilesize-(sprite_get_width(sprite_index)/2);	// make sure that the player stays on the ladder
			}
		} else {									// if we are no longer on a ladder
			can_climb = false;						// flag that we cannot climb
		}
	}
	
	/////////////////////
	// PISTOLA NIVEL 2 //
	/////////////////////

	var boton_disparo = keyboard_check(ord("I")) || mouse_check_button(mb_left);
	var boton_disparo_presionado = keyboard_check_pressed(ord("I")) || mouse_check_button_pressed(mb_left);

	disparando = boton_disparo;

	if (!variable_instance_exists(id, "longitud_rayo")) {
	    longitud_rayo = 0;
	}

	var interactuando_caja = false;

	if (boton_disparo_presionado) {
	    // Verificamos si estamos sobre la caja (Tile 5 o el objeto directo)
	    var tile_bajo_jugador = tilemap_get_at_pixel(oGame.map, x, bbox_bottom);
	    var caja = instance_place(x, y, oGhost_Container);
	    
	    if (caja == noone && tile_bajo_jugador == 5) {
	        caja = instance_nearest(x, y, oGhost_Container);
	    }

	    if (caja != noone) {
	        interactuando_caja = true; // Evita disparar el rayo al mismo tiempo que interactúas
	        
	        // CASO A: Tenemos fantasma y la caja está vacía -> Lo metemos sin evaluar
	        if (fantasma_capturado != "" && !caja.ocupado) {
	            caja.ocupado = true;
	            caja.fantasma_guardado = fantasma_capturado;
	            caja.sprite_fantasma = sprite_fantasma_cap;
	            caja.parpadeo_error = false; // Limpiamos cualquier error previo
	            
	            // Vaciamos las manos del jugador
	            fantasma_capturado = "";
	            sprite_fantasma_cap = noone;
	        }
	        // CASO B: Manos vacías y la caja tiene un fantasma -> Lo recogemos
	        else if (fantasma_capturado == "" && caja.ocupado) {
	            fantasma_capturado = caja.fantasma_guardado;
	            sprite_fantasma_cap = caja.sprite_fantasma;
	            
	            // Vaciamos la caja
	            caja.ocupado = false;
	            caja.fantasma_guardado = "";
	            caja.sprite_fantasma = noone;
	            caja.parpadeo_error = false;
	        }
	    }
	}

	// Buscamos si actualmente YA estamos atrayendo a un fantasma
	var fantasma_en_proceso = noone;
	with (oGhost_Catch) {
	    if (siendo_atraido && jugador_destino == other.id) {
	        fantasma_en_proceso = id;
	    }
	}
	
	// EL RAYO DE LA PISTOLA
	// La condición ahora se mantiene verdadera si estás disparando O si ya hay un fantasma atrapado en el rayo
	if ((disparando || fantasma_en_proceso != noone) && fantasma_capturado == "" && !interactuando_caja) {
	    
	    var x_inicio = x;
	    var y_arma = y - (sprite_height / 2);
	    
	    // FASE 1: BUSCANDO FANTASMA (Solo ocurre si no hemos enganchado a ninguno)
	    if (fantasma_en_proceso == noone) {
	        
	        // El rayo crece hasta el máximo
	        if (longitud_rayo < rango_pistola) {
	            longitud_rayo += 15;
	            if (longitud_rayo > rango_pistola) longitud_rayo = rango_pistola;
	        }
	        
	        var x_fin = x + (dir * longitud_rayo);
	        
	        // Disparamos la línea de colisión
	        var fantasma_hit = collision_line(x_inicio, y_arma, x_fin, y_arma, oGhost_Catch, false, true);
	        
	        // Si chocamos con uno, iniciamos la atracción irreversible
	        if (fantasma_hit != noone && !fantasma_hit.siendo_atraido) {
	            fantasma_hit.siendo_atraido = true;
	            fantasma_hit.jugador_destino = id;
	        }
	        
	    } 
	    // FASE 2: TRAYENDO EL FANTASMA AL JUGADOR
	    else {
	        // El rayo se mantiene atado al fantasma independientemente de si sueltas el botón
	        longitud_rayo = point_distance(x_inicio, y_arma, fantasma_en_proceso.x, fantasma_en_proceso.y);
	    }
	    
	} else {
	    // Solo desaparece el rayo si soltaste el botón Y no habías atrapado nada
	    longitud_rayo = 0;
	    
	    // (El código de liberación del fantasma que estaba aquí fue eliminado)
	}
}