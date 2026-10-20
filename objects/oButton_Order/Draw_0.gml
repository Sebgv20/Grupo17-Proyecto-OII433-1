draw_self();

// Si el temporizador está activo, mostramos el mensaje
if (timer_incompleto > 0) {
    // Usamos \n para saltar de línea, como hicimos en el cartel[cite: 1]
    var texto = "No hay errores, pero \nfaltan cajas por ordenar"; 
    
    // Configurar la fuente ANTES de medir para que el cálculo sea exacto[cite: 1]
    // (Asumo que tienes fTahoma24, si tienes otra, pon su nombre aquí)
    draw_set_font(fTahoma24); 
    
    var margen_caja = 30; 
    var ancho_caja = string_width(texto) + margen_caja;
    var alto_caja = string_height(texto) + margen_caja;
    var padding_y = 135; 
    
    // Centramos la caja usando la 'x' de tu botón
    var xx = x - (ancho_caja / 2);
    var yy = bbox_top - alto_caja - padding_y;
    
    // Dibujar el bloque negro al 70% de opacidad
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(xx, yy, xx + ancho_caja, yy + alto_caja, false);
    
    // Dibujar el texto del mensaje
    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_text(x, yy + (alto_caja / 2), texto);
    
    // Restaurar alineación
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
} 
// Si el mensaje NO está activo, mostramos el botón "W" de interacción normal
else if (place_meeting(x, y, oPlayer)) {
    var prompt_y = bbox_top - 135; 

    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(x - 45, prompt_y - 15, x + 45, prompt_y + 15, false);

    draw_set_alpha(1.0);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Puedes aplicar tu fuente aquí también para que la W se vea mejor
    // draw_set_font(fTahoma24); 
    draw_text(x, prompt_y, "W");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}