// 1. Por defecto, asumimos que está vacío o incorrecto
caja_colocada = "";
posicion_correcta = false;

// 2. Escaneamos TODAS las cajas del nivel
with (oBoxPushable) {
    
    // Si esta caja específica está colisionando con el detector (other)
    if (place_meeting(x, y, other)) {
        
        // Guardamos el texto de la caja que lo está tocando
        other.caja_colocada = fraccion_texto;
        
        // Si resulta que es la caja correcta, validamos la posición
        if (fraccion_texto == other.fraccion_esperada) {
            other.posicion_correcta = true;
            
            // 'break' detiene el bucle instantáneamente. 
            // Como ya encontramos la correcta, no necesitamos revisar las demás que lo estén rozando.
            break; 
        }
    }
}