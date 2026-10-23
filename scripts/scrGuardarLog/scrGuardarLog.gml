
/// SISTEMA CENTRAL DE LOGS

// Inicializa el sistema una sola vez por partida.

function scrIniciarLogs() {

    // Identificador del jugador
    if (!variable_global_exists("idJugador")) {
        global.idJugador = "J" + string(get_timer());
    }

    // Registros pendientes de respaldo local
    if (!variable_global_exists("logs_pendientes")) {
        global.logs_pendientes = [];
    }

    // Historial de registros de la partida
    if (!variable_global_exists("logs_historial")) {
        global.logs_historial = [];
    }

    // Registros pendientes de enviar a Google Sheets
    if (!variable_global_exists("logs_google_pendientes")) {
        global.logs_google_pendientes = [];
    }

    // Estado del envío HTTP
    if (!variable_global_exists("logs_google_enviando")) {
        global.logs_google_enviando = false;
    }

    // Identificador de la solicitud HTTP en curso
    if (!variable_global_exists("logs_google_request_id")) {
        global.logs_google_request_id = -1;
    }

    // Cantidad de registros incluidos en el envío en curso
    if (!variable_global_exists("logs_google_cantidad_envio")) {
        global.logs_google_cantidad_envio = 0;
    }
}



// Registra una respuesta del estudiante.
// _tiempo debe venir expresado en segundos.
function scrGuardarLog(_nivel, _pregunta, _alternativas,
                      _respuesta, _correcta, _tiempo) {

    scrIniciarLogs();
	
	if (_correcta == true || _correcta == 1 || string_lower(string(_correcta)) == "true" || string_lower(string(_correcta)) == "correcta") {
        global.aciertos += 1;
    } else {
        global.fallos += 1;
    }

    var _registro = {
        timestamp: date_datetime_string(date_current_datetime()),
        idJugador: global.idJugador,
        nivel: _nivel,
        pregunta: _pregunta,
        alternativas: _alternativas,
        respuestaJugador: _respuesta,
        siFueCorrectaoNo: _correcta,
        tiempoDeRespuesta: _tiempo
    };

    array_push(global.logs_pendientes, _registro);
	array_push(global.logs_historial, _registro);
	array_push(global.logs_google_pendientes, _registro);

    show_debug_message(
        "LOG | Nivel: " + string(_nivel)
        + " | Respuesta: " + string(_respuesta)
        + " | Correcta: " + string(_correcta)
    );
}


// Exporta todos los registros pendientes a un archivo local.
// Solo limpia la memoria pendiente si la escritura se completa.
function scrExportarLogs() {

    scrIniciarLogs();

    var _total = array_length(global.logs_pendientes);

    if (_total == 0) {
        show_debug_message("No hay registros pendientes.");
        return true;
    }

    var _nombre = "logs_" + string(global.idJugador) + ".jsonl";

    var _archivo = -1;

    if (file_exists(_nombre)) {
        _archivo = file_text_open_append(_nombre);
    } else {
        _archivo = file_text_open_write(_nombre);
    }

    if (_archivo == -1) {
        show_debug_message("ERROR: No se pudo abrir el archivo.");
        return false;
    }

    for (var i = 0; i < _total; i++) {

        file_text_write_string(
            _archivo,
            json_stringify(global.logs_pendientes[i])
        );

        file_text_writeln(_archivo);
    }

    file_text_close(_archivo);

    if (!file_exists(_nombre)) {
        show_debug_message("ERROR: No se encontro el archivo.");
        return false;
    }

    global.logs_pendientes = [];

    show_debug_message("Archivo guardado: " + _nombre);
    show_debug_message("Registros exportados: " + string(_total));

    return true;
}


// Muestra en consola cuantos registros tenemos.
function scrVerificarLogs() {

    scrIniciarLogs();

    show_debug_message("===== ESTADO DE LOGS =====");

    show_debug_message(
        "Jugador: " + string(global.idJugador)
    );

    show_debug_message(
        "Registros pendientes: "
        + string(array_length(global.logs_pendientes))
    );

    show_debug_message(
        "Registros de la partida: "
        + string(array_length(global.logs_historial))
    );

    show_debug_message("==========================");
}


// Iniciar el seguimiento de un nivel

function scrIniciarNivel(_nivel) {

    // No reiniciar si este nivel ya esta siendo medido
    if (variable_global_exists("nivel_actual_log")) {
        if (global.nivel_actual_log == _nivel) {

            if (!variable_global_exists("tiempo_inicio_respuesta")) {
                global.tiempo_inicio_respuesta = get_timer();
            }

            if (!variable_global_exists("suma_tiempos_respuesta")) {
                global.suma_tiempos_respuesta = 0;
            }

            if (!variable_global_exists("cantidad_respuestas_correctas")) {
                global.cantidad_respuestas_correctas = 0;
            }

            return;
        }
    }

    // Asegurar que las vidas esten inicializadas
    if (!variable_global_exists("life")) {
        global.life = 3;
    }

    // Iniciar seguimiento del nivel
    global.nivel_actual_log = _nivel;
    global.tiempo_inicio_nivel = get_timer();

    global.vidas_inicio_nivel = global.life;
    global.vidas_perdidas_nivel = 0;
    global.estrellas_obtenidas_nivel = 0;
	
	// Reiniciar contador de palancas al comenzar un nuevo intento del nivel 3
	if (_nivel == 3) {
		global.reinicios_nivel3 = 0;
	}

    // Cronometro de respuestas
    global.tiempo_inicio_respuesta = get_timer();

    // Acumulador de tiempos
    global.suma_tiempos_respuesta = 0;

    // Contador de respuestas correctas
    global.cantidad_respuestas_correctas = 0;

    show_debug_message(
        "INICIO NIVEL " + string(_nivel)
        + " | Vidas iniciales: "
        + string(global.vidas_inicio_nivel)
    );
}



// Registrar el resumen al finalizar el nivel

function scrFinalizarNivel(_nivel) {

    // Evitar finalizar un nivel que no se ha iniciado
    if (!variable_global_exists("nivel_actual_log")) {
        return;
    }

    if (global.nivel_actual_log != _nivel) {
        return;
    }

    // Calcular tiempo total en segundos
    var _tiempo = (get_timer() - global.tiempo_inicio_nivel)
                  / 1000000;

    _tiempo = round(_tiempo * 100) / 100;

    // Obtener vidas restantes
    var _vidas_finales = global.life;

    // Obtener estrellas recogidas durante el nivel
    var _estrellas = 0;

    if (variable_global_exists("estrellas_obtenidas_nivel")) {
        _estrellas = global.estrellas_obtenidas_nivel;
    }
	var _promedio_respuestas = 0;

	if (global.cantidad_respuestas_correctas > 0) {
		_promedio_respuestas =
        global.suma_tiempos_respuesta /
        global.cantidad_respuestas_correctas;
	}
	
	_promedio_respuestas = round(_promedio_respuestas * 100) / 100;

	show_debug_message(
		"PROMEDIO RESPUESTAS NIVEL " + string(_nivel)
		+ ": " + string(_promedio_respuestas) + " segundos"
	);

    // Crear registro de finalización
    var _registro = {
		tipo: "fin_nivel",
		timestamp: date_datetime_string(date_current_datetime()),
		idJugador: global.idJugador,
		nivel: _nivel,
		resultado: "completado",
		tiempoTotal: _tiempo,
		vidasPerdidas: global.vidas_perdidas_nivel,
		vidasRestantes: _vidas_finales,
		estrellasObtenidas: _estrellas,
		promedioTiempoRespuesta: _promedio_respuestas
	};
	// Agregar cantidad de reinicios solamente para el nivel 3
	if (_nivel == 3) {

		if (variable_global_exists("reinicios_nivel3")) {
			_registro.reinicios = global.reinicios_nivel3;
		} else {
			_registro.reinicios = 0;
		}

		show_debug_message(
			"REINICIOS TOTALES NIVEL 3: "
			+ string(_registro.reinicios)
		);
	}

    // Guardar registro
    array_push(global.logs_pendientes, _registro);
	array_push(global.logs_historial, _registro);
	array_push(global.logs_google_pendientes, _registro);

    // Mostrar resumen en consola
    show_debug_message(
        "FIN NIVEL " + string(_nivel)
        + " | Tiempo: " + string(_tiempo)
        + " s | Vidas perdidas: "
        + string(global.vidas_perdidas_nivel)
        + " | Vidas restantes: "
        + string(_vidas_finales)
        + " | Estrellas obtenidas: "
        + string(_estrellas)
    );

    // Evitar registrar dos veces el mismo final
    global.nivel_actual_log = -1;
	
	// ========================================================
    // SI ES EL FIN DEL NIVEL 3 -> GUARDAR RANKING Y MOSTRAR SALA
    // ========================================================
    if (_nivel == 3) {
        global.timer_activo = false; // Detener cronómetro
        calcular_puntaje_final();     // Calcular puntaje final de la partida
        
        // Usar rut_jugador o idJugador como identificador
        var id_final = global.rut_jugador;
        if (id_final == "Estudiante_01" && variable_global_exists("idJugador")) {
            id_final = global.idJugador;
        }
        
        // Guardar partida en ranking.json local con los 4 parámetros:
        guardar_partida_ranking(global.rut_jugador, global.nombre_jugador, global.puntos, global.tiempo_total);
        
        // Exportar los logs pendientes a archivo local antes de ir a ranking
        scrExportarLogs();

        // Ir a la sala del ranking
        room_goto(rRanking);
	}
}

function scrEnviarLogsGoogle() {

    scrIniciarLogs();

    // Evitar enviar dos solicitudes simultáneamente
    if (global.logs_google_enviando) {
        show_debug_message("GOOGLE | Ya existe un envio en curso.");
        return;
    }

    var _total = array_length(global.logs_google_pendientes);

    if (_total == 0) {
        show_debug_message("GOOGLE | No hay registros pendientes.");
        return;
    }

    // URL de la aplicación web de Google Apps Script
    var _url = "https://script.google.com/macros/s/AKfycbyESKAeucoom3FXUC90HyYy55Jl56nvUuA-cPd9_-Z4PSqodGL-vc4GMVMwTkOpcdU/exec";

    // Reemplazar por la misma clave de Apps Script
    var _clave = "holasoymatusdelaparra";

    // Enviar una copia de los registros pendientes
    var _registros = [];

    for (var i = 0; i < _total; i++) {
        array_push(_registros, global.logs_google_pendientes[i]);
    }

    var _datos = {
        clave: _clave,
        registros: _registros
    };

    var _json = json_stringify(_datos);

    var _headers = ds_map_create();
    ds_map_add(_headers, "Content-Type", "application/json");

    var _request = http_request(
        _url,
        "POST",
        _headers,
        _json
    );

    ds_map_destroy(_headers);

    if (_request < 0) {
        show_debug_message("GOOGLE | No se pudo iniciar el envio.");
        return;
    }

    global.logs_google_enviando = true;
    global.logs_google_request_id = _request;
    global.logs_google_cantidad_envio = _total;

    show_debug_message(
        "GOOGLE | Enviando " + string(_total) + " registros..."
    );
}
