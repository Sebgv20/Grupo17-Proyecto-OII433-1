// Si el jugador está tocando la palanca
if (place_meeting(x, y, oPlayer)) {
    
    // Si presiona "W" o "Arriba"[cite: 3]
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        
        var cajas_movidas = false;
        
        // Escaneamos todas las cajas empujables en el nivel[cite: 3]
        with (oBoxPushable) {
            
            // Verificamos si la caja pertenece al mismo grupo que esta palanca
            if (grupoCajas == other.grupoCajas) {
                
                // Calculamos un margen de error del 5% respecto a sus coordenadas originales
                var margen_x = abs(xstart * 0.1);
                var margen_y = abs(ystart * 0.1);
                
                // Si la caja actual está fuera de su posición inicial superando el margen del 5%
                if (abs(x - xstart) > margen_x || abs(y - ystart) > margen_y) {
                    cajas_movidas = true;
                }
                
                // Restauramos su posición a las coordenadas originales exactas[cite: 1]
                x = xstart;
                y = ystart;
                
                // Reseteamos su velocidad vertical para que no reaparezca cayendo[cite: 6]
                vspd = 0; 
            }
        }
        
        // EVALUACIÓN DE VIDAS Y GAME OVER
        // Solo penalizamos si al menos una caja estaba fuera del margen del 5%[cite: 1]
        if (cajas_movidas) {
            global.life -= 1; 
            audioReproduce(soundLever);
            if (global.life <= 0) {
                // Usamos el script centralizado para volver al hub selector correcto[cite: 2]
                scrGameOver(); 
            }
        }
    }
}