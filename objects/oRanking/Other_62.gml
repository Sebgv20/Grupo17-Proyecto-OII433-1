if (ds_map_find_value(async_load, "id") == req_ranking) {
    var _status = ds_map_find_value(async_load, "status");

    // Status 1 = descargando aún; esperamos a que termine (status == 0)
    if (_status == 1) exit;

    cargando_global = false;

    if (_status == 0) {
        var _res = ds_map_find_value(async_load, "result");
        try {
            var _lista_global = json_parse(_res);

            if (is_array(_lista_global)) {
                var _ya_esta = false;
                var _t_actual = round(global.tiempo_total);

                for (var i = 0; i < array_length(_lista_global); i++) {
                    if (_lista_global[i].rut == global.rut_jugador) {
                        _ya_esta = true;
                        _lista_global[i].nombre = global.nombre_jugador;
                        if (global.puntos > _lista_global[i].puntos || (global.puntos == _lista_global[i].puntos && _t_actual < _lista_global[i].tiempo)) {
                            _lista_global[i].puntos = global.puntos;
                            _lista_global[i].tiempo = _t_actual;
                        }
                        break;
                    }
                }

                if (!_ya_esta) {
                    array_push(_lista_global, {
                        rut: global.rut_jugador,
                        nombre: global.nombre_jugador,
                        puntos: global.puntos,
                        tiempo: _t_actual
                    });
                }

                // Ordenar por mayor puntaje y desempatar por menor tiempo
                array_sort(_lista_global, function(a, b) {
                    if (b.puntos != a.puntos) return b.puntos - a.puntos;
                    return a.tiempo - b.tiempo;
                });

                ranking_completo = _lista_global;

                // Actualizar caché local ranking.json
                var _f = file_text_open_write(working_directory + "ranking.json");
                file_text_write_string(_f, json_stringify(ranking_completo, true));
                file_text_close(_f);

                // Recalcular posición del estudiante actual
                for (var j = 0; j < array_length(ranking_completo); j++) {
                    if (ranking_completo[j].rut == global.rut_jugador) {
                        mi_posicion = j + 1;
                        mi_registro = ranking_completo[j];
                        break;
                    }
                }

                show_debug_message("RANKING GLOBAL CARGADO OK | Total jugadores: " + string(array_length(ranking_completo)));
            }
        } catch(e) {
            show_debug_message("ERROR JSON RANKING: " + string(e) + " | RES: " + string_copy(_res, 1, 150));
        }
    } else {
        var _http_code = ds_map_find_value(async_load, "http_status");
        show_debug_message("ERROR HTTP RANKING | Status: " + string(_status) + " | HTTP: " + string(_http_code));
    }
}