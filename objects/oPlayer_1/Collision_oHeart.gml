if(global.life < 3){				// if the player is not at max health
	global.life++;				// increase the players health
	with(other){			// destroy the pickup
		instance_destroy();
	}
}