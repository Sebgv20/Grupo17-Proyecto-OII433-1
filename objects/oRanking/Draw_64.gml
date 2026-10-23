var gw = display_get_gui_width();
var gh = display_get_gui_height();
var cx = gw / 2;

// 1. Fondo translúcido
draw_set_alpha(0.90 * alpha_texto);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// 2. Encabezado
draw_set_alpha(alpha_texto);
draw_set_font(fTahoma24);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_set_color(c_yellow);
draw_text(cx, 30, "¡FELICITACIONES, COMPLETAS EL JUEGO!");

draw_set_color(c_white);
var tiempo_seg = floor(global.tiempo_total);
var min_t = string(floor(tiempo_seg / 60));
var sec_t = string(tiempo_seg mod 60);
if (string_length(sec_t) < 2) sec_t = "0" + sec_t;

draw_text(cx, 75, "Estudiante: " + string(global.nombre_jugador) + " (" + string(global.rut_jugador) + ") | Puntos: " + string(global.puntos) + " | Tiempo: " + min_t + ":" + sec_t);

// 3. Título de la tabla
draw_set_color(c_aqua);
draw_text(cx, 135, "=== TABLA DE CLASIFICACIÓN (TOP 5) ===");

// Configuración de columnas
var col_pos  = cx - 300;
var col_nom  = cx - 200;
var col_pts  = cx + 80;
var col_time = cx + 220;
var start_y  = 185;

draw_set_halign(fa_left);
draw_set_color(c_gray);
draw_text(col_pos, start_y, "POS");
draw_text(col_nom, start_y, "ESTUDIANTE");
draw_text(col_pts, start_y, "PUNTOS");
draw_text(col_time, start_y, "TIEMPO");

draw_set_color(c_white);
draw_line(col_pos, start_y + 35, col_time + 90, start_y + 35);

// 4. Dibujar las filas del Top 5
var fila_y = start_y + 45;
var total_top = min(5, array_length(ranking_completo));

for (var i = 0; i < total_top; i++) {
    var reg = ranking_completo[i];
    
    var r_min = string(floor(reg.tiempo / 60));
    var r_sec = string(reg.tiempo mod 60);
    if (string_length(r_sec) < 2) r_sec = "0" + r_sec;

    // Resaltar en amarillo si es el alumno actual
    if (reg.rut == global.rut_jugador) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }

    draw_text(col_pos, fila_y, "#" + string(i + 1));
    draw_text(col_nom, fila_y, string(reg.nombre));
    draw_text(col_pts, fila_y, string(reg.puntos) + " pts");
    draw_text(col_time, fila_y, r_min + ":" + r_sec);

    fila_y += 35;
}

// 5. SI NO QUEDÓ EN EL TOP 5: Mostrar su posición abajo para desafiarlo
if (mi_posicion > 5) {
    fila_y += 15;
    draw_set_color(c_orange);
    draw_line(col_pos, fila_y, col_time + 90, fila_y);
    fila_y += 10;
    
    draw_set_color(c_yellow);
    var m_min = string(floor(mi_registro.tiempo / 60));
    var m_sec = string(mi_registro.tiempo mod 60);
    if (string_length(m_sec) < 2) m_sec = "0" + m_sec;

    draw_text(col_pos, fila_y, "#" + string(mi_posicion));
    draw_text(col_nom, fila_y, string(mi_registro.nombre) + " (Tú)");
    draw_text(col_pts, fila_y, string(mi_registro.puntos) + " pts");
    draw_text(col_time, fila_y, m_min + ":" + m_sec);

    fila_y += 35;
    draw_set_halign(fa_center);
    draw_set_color(c_orange);
    draw_text(cx, fila_y, "¡Estás en la posición #" + string(mi_posicion) + "! ¡Sigue jugando para entrar al Top 5!");
}

// 6. Pie de pantalla
draw_set_alpha(alpha_texto);
draw_set_color(c_silver);
draw_set_halign(fa_center);
draw_text(cx, gh - 55, "Presiona ENTER para finalizar");

// Restaurar configuración gráfica
draw_set_alpha(1);
draw_set_halign(fa_left);