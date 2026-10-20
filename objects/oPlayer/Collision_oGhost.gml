global.life--;
audioReproduce(soundHurt);

// --- EFECTO RECOIL (Retroceso) ---
var dir_empuje = sign(x - other.x);
if (dir_empuje == 0) dir_empuje = 1; 

x += dir_empuje * 30; 

grav = -4; 
jump = true;

// --- PREPARAR EL PARPADEO ---
// Iniciar en 39 garantiza que toda la primera decena (39 a 30) devuelva 3 al dividir por 10.
// Esto nos obliga a cambiar la condición par/impar en el Draw para encender el blanco.
flash_timer = 39; 

with(other){			
	instance_destroy();
}