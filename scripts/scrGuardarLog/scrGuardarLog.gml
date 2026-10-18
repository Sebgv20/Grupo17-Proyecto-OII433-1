function scrGuardarLog(_pregunta, _alternativas, _respuesta, _correcta, _tiempo) {
    var _fecha = date_current_datetime();
    var _timestamp = date_datetime_string(_fecha);

    var _registro = {
        timestamp: _timestamp,
        idJugador: global.idJugador,
        pregunta: _pregunta,
        alternativas: _alternativas,
        respuestaJugador: _respuesta,
        siFueCorrectaoNo: _correcta,
        tiempoDeRespuesta: _tiempo
    };

    var _archivo = "log_interacciones.jsonl";
    var _f;

    if (file_exists(_archivo)) {
        _f = file_text_open_append(_archivo);
    } else {
        _f = file_text_open_write(_archivo);
    }

    if (_f != -1) {
        file_text_write_string(_f, json_stringify(_registro));
        file_text_writeln(_f);
        file_text_close(_f);
    }
}
