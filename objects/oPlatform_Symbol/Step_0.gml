
if (!activada) {

    // Detectar al jugador sobre la plataforma
    var _player = instance_place(x, y - 4, oPlayer);

    if (_player != noone) {

        if (_player.bbox_bottom <= bbox_top + 12) {

            activada = true;

            // Registrar la respuesta del estudiante
            var _respuesta = texto_plataforma;
            var _correcta = es_correcta;

            // Calcular tiempo desde el inicio del nivel
            // o desde la ultima respuesta correcta
            var _tiempo_respuesta =
                (get_timer() - global.tiempo_inicio_respuesta) / 1000000;

            // Redondear a dos decimales
            _tiempo_respuesta =
                round(_tiempo_respuesta * 100) / 100;

            // Guardar respuesta en el sistema de logs
            scrGuardarLog(
                1,
                "Comparacion de fracciones - " + string(grupo_id),
                ["<", "=", ">"],
                _respuesta,
                _correcta,
                _tiempo_respuesta
            );

            // Acumular tiempo solamente si responde correctamente
            if (es_correcta) {

                global.suma_tiempos_respuesta += _tiempo_respuesta;
                global.cantidad_respuestas_correctas += 1;

                // Reiniciar cronometro para la siguiente pregunta
                global.tiempo_inicio_respuesta = get_timer();
            }

            // Calcular centro de la plataforma
            var pos_x = bbox_left + (sprite_width / 2);
            var base_y = bbox_top;

            if (es_correcta == true) {

                audioReproduce(soundCorrectAnswer);

                var mapa_visual = layer_tilemap_get_id("GTiles");
                var indice_escalera_visual = 76;

                for (var i = 1; i <= altura_escalera; i++) {

                    var pos_y = base_y - (sprite_height * i) + 4;

                    if (i == altura_escalera) {

                        // Suelo solido en la cima
                        tilemap_set_at_pixel(
                            oGame.map, 1, pos_x, pos_y
                        );

                    } else {

                        // Colision de escalera
                        tilemap_set_at_pixel(
                            oGame.map, 2, pos_x, pos_y
                        );
                    }

                    // Escalera visual
                    tilemap_set_at_pixel(
                        mapa_visual,
                        indice_escalera_visual,
                        pos_x,
                        pos_y
                    );
                }

            } else {

                audioReproduce(soundWrongAnswer);

                // Eliminar suelo de la plataforma
                tilemap_set_at_pixel(
                    oGame.map, 0, pos_x, base_y + 4
                );

                // Destruir plataforma incorrecta
                instance_destroy();

                global.life -= 1;

                // Registrar vida perdida
                if (variable_global_exists("vidas_perdidas_nivel")) {
                    global.vidas_perdidas_nivel += 1;
                }

                with (oCartel) {
                    if (grupo_id == other.grupo_id) {
                        puede_interactuar = true;
                    }
                }
            }
        }
    }
}
