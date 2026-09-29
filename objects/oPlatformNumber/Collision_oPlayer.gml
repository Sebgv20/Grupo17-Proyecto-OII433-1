if (!activada) {
    
    // Verificamos que los pies del jugador estén por encima o tocando la superficie de la plataforma
    if (other.bbox_bottom <= bbox_top + 12) {
        
        activada = true; 
        
        // --- NUEVO: Calculamos el centro exacto a lo ancho de toda la plataforma ---
        // Al dividir el ancho total entre 2, si la plataforma mide 3 celdas, 
        // apuntará exactamente a la celda del medio.
        var pos_x = bbox_left + (sprite_width / 2); 
        var base_y = bbox_top; 
        
        if (es_correcta == true) {
            var mapa_visual = layer_tilemap_get_id("GTiles"); 
            var indice_escalera_visual = 76;                           
            
            for (var i = 1; i <= altura_escalera; i++) {
                
                var pos_y = base_y - (sprite_height * i) + 4;
                
                if (i == altura_escalera) {
                    // --- NUEVO: Colisión de suelo en la cima ---
                    // Cambié el 2 por un 1 para que ahora sí actúe como suelo sólido
                    tilemap_set_at_pixel(oGame.map, 2, pos_x, pos_y);
                } else {
                    // Colisión de escalera
                    tilemap_set_at_pixel(oGame.map, 2, pos_x, pos_y); 
                }
                
                // Escalera visual
                tilemap_set_at_pixel(mapa_visual, indice_escalera_visual, pos_x, pos_y);
            }
            
        } else {
            // Borramos el suelo sólido inicial (el de la plataforma en sí)
            tilemap_set_at_pixel(oGame.map, 0, pos_x, base_y + 4);
            
            // Destruimos la plataforma visual
            instance_destroy();
        }
    }
}