/// Mover las nubes del menú
for(var i = 0; i < array_length(clouds); i++){
    // Movemos la nube a la derecha (cambia 0.5 por la velocidad que desees)
    var nueva_x = layer_sprite_get_x(clouds[i]) + 0.5;
    layer_sprite_x(clouds[i], nueva_x);
    
    // Si la nube sale completamente por la derecha de la pantalla[cite: 9]
    if(nueva_x > room_width){
        // La teletransportamos al inicio de la pantalla por la izquierda[cite: 9]
        var ancho_nube = sprite_get_width(layer_sprite_get_sprite(clouds[i]));
        layer_sprite_x(clouds[i], -ancho_nube);
    }
}

for(var i = 0; i < array_length(hills); i++){
    // Movemos la nube a la derecha (cambia 0.5 por la velocidad que desees)
    var nueva_x = layer_sprite_get_x(hills[i]) - 0.5;
    layer_sprite_x(hills[i], nueva_x);
    
    // Si la nube sale completamente por la derecha de la pantalla[cite: 9]
    if(nueva_x > room_width){
        // La teletransportamos al inicio de la pantalla por la izquierda[cite: 9]
        var ancho_nube = sprite_get_width(layer_sprite_get_sprite(hills[i]));
        layer_sprite_x(hills[i], -ancho_nube);
    }
}