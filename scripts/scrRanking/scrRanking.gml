// 1. Calcula el puntaje final basado en las variables del juego
function calcular_puntaje_final() {
    var vidas_bonus = 0;
    if (variable_global_exists("life")) {
        vidas_bonus = max(0, (global.life * 50) - 50);
    }
    
    var pts = (global.estrellas * 50) + (global.aciertos * 50) - (global.fallos * 25) + vidas_bonus;
    global.puntos = max(0, pts);
    return global.puntos;
}

// 2. Guarda en ranking.json conservando únicamente la mejor partida por RUT
function guardar_partida_ranking(_rut, _nombre, _puntos, _tiempo) {
    var file_path = working_directory + "ranking.json";
    var lista_ranking = [];

    // Cargar ranking existente si el archivo ya fue creado
    if (file_exists(file_path)) {
        var f = file_text_open_read(file_path);
        var contenido = "";
        while (!file_text_eof(f)) {
            contenido += file_text_readln(f);
        }
        file_text_close(f);

        if (contenido != "") {
            try {
                lista_ranking = json_parse(contenido);
            } catch(e) {
                lista_ranking = [];
            }
        }
    }

    // Comprobar si el RUT ya jugó anteriormente
    var index_existente = -1;
    for (var i = 0; i < array_length(lista_ranking); i++) {
        if (lista_ranking[i].rut == _rut) {
            index_existente = i;
            break;
        }
    }

    // Si por algún motivo _tiempo llega undefined o nulo, toma global.tiempo_total o 0
    if (is_undefined(_tiempo) || !is_numeric(_tiempo)) {
        _tiempo = variable_global_exists("tiempo_total") ? global.tiempo_total : 0;
    }
    var t_redondeado = round(_tiempo);

    if (index_existente != -1) {
        // El alumno ya tenía partida: solo actualizamos si este intento es MEJOR
        var reg_previo = lista_ranking[index_existente];
        var es_mejor = false;

        if (_puntos > reg_previo.puntos) {
            es_mejor = true;
        } else if (_puntos == reg_previo.puntos && t_redondeado < reg_previo.tiempo) {
            es_mejor = true; // Desempate por menor tiempo
        }

        if (es_mejor) {
            reg_previo.nombre = _nombre;
            reg_previo.puntos = _puntos;
            reg_previo.tiempo = t_redondeado;
        }
    } else {
        // Primer intento registrado de este RUT
        var nuevo_registro = {
            rut: _rut,
            nombre: _nombre,
            puntos: _puntos,
            tiempo: t_redondeado
        };
        array_push(lista_ranking, nuevo_registro);
    }

    // Ordenar: 1° Mayor Puntaje, 2° Menor Tiempo
    array_sort(lista_ranking, function(a, b) {
        if (b.puntos != a.puntos) {
            return b.puntos - a.puntos;
        }
        return a.tiempo - b.tiempo;
    });

    // Guardar archivo JSON actualizado
    var json_str = json_stringify(lista_ranking, true);
    var f_out = file_text_open_write(file_path);
    file_text_write_string(f_out, json_str);
    file_text_close(f_out);
}

// 3. Carga todo el ranking completo ordenado
function cargar_ranking_completo() {
    var file_path = working_directory + "ranking.json";
    var lista = [];

    if (file_exists(file_path)) {
        var f = file_text_open_read(file_path);
        var str = "";
        while (!file_text_eof(f)) {
            str += file_text_readln(f);
        }
        file_text_close(f);

        if (str != "") {
            try {
                lista = json_parse(str);
            } catch(e) {
                lista = [];
            }
        }
    }
    return lista;
}