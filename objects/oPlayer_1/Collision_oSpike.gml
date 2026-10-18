// if the player collides with a ghost
global.life--;				// reduce the players health
with(other){			// destroy the spike
	instance_destroy();
}