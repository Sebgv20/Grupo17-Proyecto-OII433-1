// 1. Cargar lista local como respaldo inmediato
ranking_completo = cargar_ranking_completo();
cargando_global = true;

// 2. Consultar el ranking global por GET (usa el doGet que ya probaste en Chrome)
var _url_base = "https://script.google.com/macros/s/AKfycbxog5LkCEO2fkhwMq-KqUN_JtgmasIt1UOG3I5QkpNS_PhCMb-8pHGtJXq-UVKqM_AH/exec";

var _rut_enc = string_trim(string(global.rut_jugador));
var _nom_enc = string_trim(string(global.nombre_jugador));
_nom_enc = string_replace_all(_nom_enc, " ", "%20");
_nom_enc = string_replace_all(_nom_enc, "&", "%26");
_nom_enc = string_replace_all(_nom_enc, "#", "%23");
_nom_enc = string_replace_all(_nom_enc, "+", "%2B");

req_ranking = http_get(_url_base + "?rut=" + _rut_enc + "&nombre=" + _nom_enc);
show_debug_message("RANKING GET INICIADO | req_id: " + string(req_ranking));

// 3. Buscar posición inicial con datos locales
mi_posicion = -1;
mi_registro = undefined;

for (var i = 0; i < array_length(ranking_completo); i++) {
    if (ranking_completo[i].rut == global.rut_jugador) {
        mi_posicion = i + 1;
        mi_registro = ranking_completo[i];
        break;
    }
}

alpha_texto = 0;