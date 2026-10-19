
function scrIniciarLogs() {
    global.logs_pendientes = [];
}

function scrGuardarLog(_pregunta, _alternativas, _respuesta, _correcta, _tiempo) {

    if (!variable_global_exists("logs_pendientes")) {
        global.logs_pendientes = [];
    }

    var _registro = {
        timestamp: date_datetime_string(date_current_datetime()),
        idJugador: global.idJugador,
        pregunta: _pregunta,
        alternativas: _alternativas,
        respuestaJugador: _respuesta,
        siFueCorrectaoNo: _correcta,
        tiempoDeRespuesta: _tiempo
    };

    array_push(global.logs_pendientes, _registro);
}

function scrExportarLogs(_nivel) {

    if (!variable_global_exists("logs_pendientes")) {
        return false;
    }

    if (array_length(global.logs_pendientes) == 0) {
        return true;
    }

    var _nombre = "logs_nivel_" + string(_nivel) + ".jsonl";
    var _archivo;

    if (file_exists(_nombre)) {
        _archivo = file_text_open_append(_nombre);
    } else {
        _archivo = file_text_open_write(_nombre);
    }

    if (_archivo == -1) {
        show_debug_message("ERROR: No se pudo guardar el log");
        return false;
    }

    var _total = array_length(global.logs_pendientes);

    for (var i = 0; i < _total; i++) {
        var _linea = json_stringify(global.logs_pendientes[i]);
        file_text_write_string(_archivo, _linea);
        file_text_writeln(_archivo);
    }

    file_text_close(_archivo);

    global.logs_pendientes = [];

    show_debug_message("Logs guardados: " + _nombre);

    return true;
}

