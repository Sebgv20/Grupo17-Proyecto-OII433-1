// Mover las nubes
for(var i = 0; i < array_length(clouds); i++){
    var nueva_x = layer_sprite_get_x(clouds[i]) + 0.5;
    layer_sprite_x(clouds[i], nueva_x);
    
    if(nueva_x > room_width){
        var ancho_nube = sprite_get_width(layer_sprite_get_sprite(clouds[i]));
        layer_sprite_x(clouds[i], -ancho_nube);
    }
}

// Mover las colinas
for(var i = 0; i < array_length(hills); i++){
    var nueva_x = layer_sprite_get_x(hills[i]) - 0.5;
    layer_sprite_x(hills[i], nueva_x);
    if(nueva_x > room_width){
        var ancho_nube = sprite_get_width(layer_sprite_get_sprite(hills[i]));
        layer_sprite_x(hills[i], -ancho_nube);
    }
}