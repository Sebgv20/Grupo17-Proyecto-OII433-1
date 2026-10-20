// --- 1. FÍSICA DE GRAVEDAD Y CAÍDA ---
vspd += grav;

var tile_abajo_izq = tilemap_get_at_pixel(oGame.map, bbox_left, bbox_bottom + vspd);
var tile_abajo_der = tilemap_get_at_pixel(oGame.map, bbox_right, bbox_bottom + vspd);
var caja_abajo = instance_place(x, y + vspd, oBoxPushable);

if (tile_abajo_izq == 1 || tile_abajo_der == 1 || tile_abajo_izq == 3 || tile_abajo_der == 3 || caja_abajo != noone) {
    if (vspd > 0) {
        if (caja_abajo != noone) {
            y = caja_abajo.bbox_top - (bbox_bottom - y);
        } else {
            var tope_suelo = real((bbox_bottom + vspd) & $ffffffc0);
            y = tope_suelo - (bbox_bottom - y) - 1;
        }
        vspd = 0;
    }
}
y += vspd;

// Guardamos la posición X inicial para calcular empujes externos (como la cinta)
var x_inicial = x;

// --- 2. CINTA TRANSPORTADORA ---
// 1. Buscamos la cinta normalmente debajo de la caja
var cinta = instance_place(x, y + 4, oCintaTransportadora);

// 2. Si ya no la tocamos en el centro, damos un margen de gracia a los lados
// para garantizar que la caja reciba el empuje final y caiga al vacío.
if (cinta == noone) {
    var cinta_empujando_izq = instance_place(x + 2, y + 4, oCintaTransportadora);
    var cinta_empujando_der = instance_place(x - 2, y + 4, oCintaTransportadora);

    // Si la caja asoma por la izquierda, buscamos si la cinta a su derecha la empuja hacia la izquierda
    if (cinta_empujando_izq != noone && cinta_empujando_izq.dir_cinta == -1) {
        cinta = cinta_empujando_izq;
    } 
    // Si la caja asoma por la derecha, buscamos si la cinta a su izquierda la empuja hacia la derecha
    else if (cinta_empujando_der != noone && cinta_empujando_der.dir_cinta == 1) {
        cinta = cinta_empujando_der;
    }
}

// 3. Aplicamos el movimiento si encontramos la cinta directa o en el margen[cite: 2]
if (cinta != noone) {
    empujar_en_cadena(cinta.vel_cinta * cinta.dir_cinta);
}

// Calculamos cuántos píxeles movió la cinta a esta caja
var desp_x = x - x_inicial;

// --- 3. COLISIÓN SÓLIDA Y EMPUJE ---
if (place_meeting(x, y, oPlayer) || place_meeting(x, y - 1, oPlayer)) {
    
    // Extraemos la velocidad REAL del jugador
    var vel_y_player = oPlayer.y - oPlayer.yprevious;
    
    // Leemos si el jugador activó su salto en este frame
    var intentando_saltar = (variable_instance_exists(oPlayer, "grav") && oPlayer.grav < 0);
    
    // Calculamos dónde estaban los pies y el techo en el frame anterior
    var pies_anteriores = oPlayer.bbox_bottom - vel_y_player;
    var caja_techo_anterior = yprevious + (bbox_top - y);
    
    // 1. ¿El jugador estaba netamente por encima de la caja antes de este frame?
    var estaba_arriba = (pies_anteriores <= caja_techo_anterior + 12);
    
    // 2. ¿El jugador viene cayendo o se mantiene quieto sin intentar saltar?
    var cayendo_o_quieto = (vel_y_player >= 0) && !intentando_saltar;
    
    if (estaba_arriba) {
        // CASO C: El jugador aterrizó o ya estaba parado sobre el techo
        // Si intenta saltar o subir, lo ignoramos para no empujarlo horizontalmente
        if (cayendo_o_quieto) {
            oPlayer.y = bbox_top - (oPlayer.bbox_bottom - oPlayer.y);
            
            if (variable_instance_exists(oPlayer, "grav")) oPlayer.grav = 0;
            oPlayer.fall = false;
            oPlayer.jump = false;
            
            // Si la caja se movió sola (ej: por la cinta), arrastramos al jugador
            if (desp_x != 0) {
                oPlayer.x += desp_x;
            }
        }
    } 
    else {
        // CASO A y B: El jugador definitivamente NO venía de arriba. Choca por los lados.
        var centro_caja = bbox_left + (sprite_width / 2);
        var centro_player = oPlayer.bbox_left + ((oPlayer.bbox_right - oPlayer.bbox_left) / 2);
        
        var intenta_derecha = keyboard_check(ord("D"));
        var intenta_izquierda = keyboard_check(ord("A"));
        
        // Empuja o choca desde la IZQUIERDA
        if (centro_player < centro_caja) {
            if (intenta_derecha) {
                empujar_en_cadena(vel_empuje);
            }
            // Pared sólida
            oPlayer.x = (bbox_left + (x - x_inicial)) - (oPlayer.bbox_right - oPlayer.x);
        } 
        // Empuja o choca desde la DERECHA
        else {
            if (intenta_izquierda) {
                empujar_en_cadena(-vel_empuje);
            }
            // Pared sólida
            oPlayer.x = (bbox_right + (x - x_inicial)) + (oPlayer.x - oPlayer.bbox_left);
        }
    }
}