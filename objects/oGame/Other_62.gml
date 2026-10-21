
/// CONFIRMACION DE ENVIO A GOOGLE SHEETS

// Comprobar que existe un envio en curso
if (!variable_global_exists("logs_google_enviando")) {
    exit;
}

if (!global.logs_google_enviando) {
    exit;
}

// Identificar la solicitud HTTP
var _id = async_load[? "id"];

if (_id != global.logs_google_request_id) {
    exit;
}

// Obtener respuesta del servidor
var _estado = async_load[? "status"];
var _http = async_load[? "http_status"];
var _resultado = async_load[? "result"];

var _confirmado = false;

if (_estado == 0 && _http == 200) {

    try {

        var _respuesta = json_parse(_resultado);

        if (is_struct(_respuesta)) {
            if (variable_struct_exists(_respuesta, "ok")) {
                _confirmado = (_respuesta.ok == true);
            }
        }

    } catch (_error) {

        show_debug_message(
            "GOOGLE | Error al interpretar respuesta JSON."
        );
    }
}

if (_confirmado) {

    var _cantidad = global.logs_google_cantidad_envio;

    // Eliminar solamente los registros confirmados
    repeat (_cantidad) {

        if (array_length(global.logs_google_pendientes) > 0) {
            array_delete(global.logs_google_pendientes, 0, 1);
        }
    }

    show_debug_message(
        "GOOGLE | Envio confirmado: "
        + string(_cantidad) + " registros."
    );

} else {

    show_debug_message(
        "GOOGLE | No se pudo confirmar el envio."
    );

    show_debug_message(
        "HTTP: " + string(_http)
        + " | Estado: " + string(_estado)
        + " | Respuesta: " + string(_resultado)
    );
}

// Restablecer estado del envio
global.logs_google_enviando = false;
global.logs_google_request_id = -1;
global.logs_google_cantidad_envio = 0;
