// Verificamos si el ratón está sobre el botón
if (position_meeting(mouse_x, mouse_y, id)) {
    // Aumenta progresivamente hasta 1
    hover_val = lerp(hover_val, 1, 0.15); 
} else {
    // Disminuye progresivamente hasta 0
    hover_val = lerp(hover_val, 0, 0.15); 
}