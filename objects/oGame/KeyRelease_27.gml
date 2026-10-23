// Al soltar Escape, simular el clic en el botón de pausa
if (instance_exists(oButton_Pause)) {
    with (oButton_Pause) {
        // Ejecuta el evento de clic del botón
        event_perform(ev_mouse, ev_left_press);
        event_perform(ev_mouse, ev_left_release);
    }
}