

// --- HACER LA CINTA SÓLIDA PARA TODOS ---
// Calculamos cuántas celdas de ancho tiene la cinta en caso de que 
// la hayas estirado en el Room Editor (asumiendo tiles de 64x64).
var tamano_tile = 64; 
var celdas = ceil(sprite_width / tamano_tile);

for (var i = 0; i < celdas; i++) {
    // Calculamos el punto central de cada bloque a lo largo de la cinta
    var pos_x = bbox_left + (i * tamano_tile) + (tamano_tile / 2);
    var pos_y = bbox_top + (tamano_tile / 2);
    
    // Le decimos al mapa de colisiones global que ponga un suelo sólido (índice 1) ahí
    tilemap_set_at_pixel(oGame.map, 1, pos_x, pos_y);
}