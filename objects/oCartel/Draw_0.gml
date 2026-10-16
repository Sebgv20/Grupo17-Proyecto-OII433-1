// 1. Dibujar el propio sprite del cartel siempre
draw_self();

// 2. Comprobar si el cartel ha sido habilitado (al fallar la respuesta)
if (puede_interactuar) {
    
    // Configurar alineación de texto centrada
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // --- DIBUJAR SÍMBOLO "?" EN EL CARTEL ---
    // (Opcional) puedes usar tu fuente aquí si lo deseas: draw_set_font(fTahoma24);[cite: 1]
    draw_set_color(c_white); // Color amarillo para que resalte, puedes cambiarlo
    draw_text(x, y+15, "?");     // Dibuja el "?" justo en el centro del cartel
    
    // --- DIBUJAR ELEMENTOS FLOTANTES ---
    // Comprobar si el jugador está parado frente al cartel
    if (place_meeting(x, y, oPlayer)) {
        
        if (!mostrar_mensaje) {
            // EL JUGADOR ESTÁ CERCA PERO NO HA APRETADO "W"
            // Dibujar el cuadro indicador de botones
            
            var prompt_y = bbox_top - 75; // Altura flotante arriba del cartel
            
            // Cuadro negro semitransparente del indicador
            draw_set_alpha(0.7);
            draw_set_color(c_black);
            draw_rectangle(x - 65, prompt_y - 15, x + 65, prompt_y + 15, false);
            
            // Texto indicando las teclas
            draw_set_alpha(1.0);
            draw_set_color(c_white);
            draw_text(x, prompt_y, "W / ^");
            
        } else { 
            var texto = string(mensaje);
            
            // ¡IMPORTANTE! Debemos aplicar la fuente ANTES de medir el texto 
            // para que GameMaker sepa el tamaño real de las letras
            draw_set_font(fTahoma24); 
            
            // Definimos un margen (padding) para que el texto no quede pegado a los bordes
            var margen_caja = 30; 
            
            // Calculamos el tamaño de la caja basándonos en las medidas exactas del texto
            var ancho_caja = string_width(texto) + margen_caja;
            var alto_caja = string_height(texto) + margen_caja;
            
            var padding_y = 50; // Distancia flotante sobre el cartel
            
            var xx = x - (ancho_caja / 2);
            var yy = bbox_top - alto_caja - padding_y;
            
            // Fondo negro 50% opacidad para el mensaje
            draw_set_alpha(0.5);
            draw_set_color(c_black);
            draw_rectangle(xx, yy, xx + ancho_caja, yy + alto_caja, false);
            
            // Texto del mensaje
            draw_set_alpha(1.0);
            draw_set_color(c_white);
            draw_text(x, yy + (alto_caja / 2), texto);
        }
    }
    
    // Restaurar alineación y color a la normalidad para no afectar otros dibujos del juego
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}