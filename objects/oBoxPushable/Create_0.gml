vspd = 0;
grav = 0.4;
vel_empuje = 2; // Velocidad al empujar

// --- MÉTODO DE EMPUJE EN CADENA ---
empujar_en_cadena = function(_vel) {
    // Calculamos qué borde evaluar según la dirección
    var borde = (_vel > 0) ? bbox_right : bbox_left;
    var tile_frente = tilemap_get_at_pixel(oGame.map, borde + _vel, bbox_bottom - 1);

    // Si hay una pared (índices 1 o 3), el movimiento se cancela para toda la cadena[cite: 3]
    if (tile_frente == 1 || tile_frente == 3) {
        return false; 
    }

    // Verificamos si hay otra caja bloqueando el paso[cite: 1]
    var otra_caja = instance_place(x + _vel, y, oBoxPushable);
    
    if (otra_caja != noone) {
        // Le decimos a la OTRA caja que intente moverse primero
        if (!otra_caja.empujar_en_cadena(_vel)) {
            // Si la otra caja chocó con una pared o no pudo moverse, nosotros tampoco
            return false;
        }
    }

    // Si llegamos aquí, el camino está libre o las cajas contiguas ya se movieron
    x += _vel;
    return true;
}