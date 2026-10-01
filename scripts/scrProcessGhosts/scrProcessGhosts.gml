function scrProcessGhosts() {
	var xx,yy,c1,c2;											

	hspd = dir * spd;											
	x+=hspd;													

	if(dir == -1){												// if moving left
		image_index = 1;										
		c1 = -1;												
	    c2 = -1;
	    c1 = tilemap_get_at_pixel(oGame.map, x, y);				
	    c2 = tilemap_get_at_pixel(oGame.map,x,y+sprite_height);	
        
        // Agregamos && c1 != 2 para ignorar las escaleras
	    if((c1 >= 1 && c1 != 2) || (c2 <= 0)){								
	        x = (x&$ffffffc0)+sprite_width;						
			dir *= -1;											
	    }
	}else if(dir == 1)											// if moving right
	{															
		image_index = 0;										
		c1 = -1													
	    c2 = -1;
	    c1 = tilemap_get_at_pixel(oGame.map,x+sprite_width,y);					
	    c2 = tilemap_get_at_pixel(oGame.map,x+sprite_width,y+sprite_height);	
        
        // Agregamos && c1 != 2 para ignorar las escaleras
		if((c1 >= 1 && c1 != 2) || (c2 <= 0)){								
		    x = (x&$ffffffc0);									
			dir *= -1;											
		}
	}
}
