// Cargar lista completa de partidas
ranking_completo = cargar_ranking_completo();

// Buscar qué puesto obtuvo el estudiante actual
mi_posicion = -1;
mi_registro = undefined;

for (var i = 0; i < array_length(ranking_completo); i++) {
    if (ranking_completo[i].rut == global.rut_jugador) {
        mi_posicion = i + 1; // Posición humana (1, 2, 3...)
        mi_registro = ranking_completo[i];
        break;
    }
}

// Transición visual
alpha_texto = 0;