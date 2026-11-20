# Learn2Math

Learn2Math es un videojuego educativo para practicar **comparación, ubicación y ordenamiento de fracciones**. Fue desarrollado en GameMaker por el Grupo 17 para la asignatura OII-433 de la Pontificia Universidad Católica de Valparaíso.

## Cómo jugar en Windows

1. Descarga el repositorio desde **Code → Download ZIP** y extrae su contenido.
2. Abre la carpeta [Ejecutable Learn2Math](Ejecutable%20Learn2Math/).
3. Ejecuta `Learn2Math.exe`. Mantén `data.win` y `options.ini` en la misma carpeta que el ejecutable.

También puedes descargar el proyecto con Git.

```bash
git clone https://github.com/Sebgv20/Grupo17-Proyecto-OII433-1.git
```

## Niveles

| Nivel | Objetivo de aprendizaje | Mecánica |
| --- | --- | --- |
| 1. Comparación | Comparar dos fracciones. | Selecciona el signo `<`, `>` o `=` saltando a la plataforma correspondiente. |
| 2. Recta numérica | Ubicar fracciones en la recta numérica. | Captura los fantasmas que representan fracciones y colócalos en la posición correspondiente. |
| 3. Ordenamiento | Ordenar una secuencia de fracciones. | Empuja las cajas hacia las cintas y usa la palanca para comprobar el orden. |

### Controles básicos

- **A / D** para desplazarte.
- **Espacio** para saltar.
- **W / S** para subir o bajar por las escaleras.
- **I o clic izquierdo** para usar la pistola captura-fantasmas en el nivel 2.

## Abrir el código fuente

1. Abre [Grupo17-ProyectoOII433-1.yyp](Grupo17-ProyectoOII433-1.yyp) desde GameMaker. El archivo del proyecto registra la versión **2026.0.0.16** del editor.
2. Ejecuta el proyecto desde el editor para probar tus cambios.

Los niveles y pantallas están en [`rooms/`](rooms/), los objetos y sus eventos en [`objects/`](objects/) y los scripts en GML en [`scripts/`](scripts/). Los recursos gráficos y de audio se encuentran en [`sprites/`](sprites/), [`tilesets/`](tilesets/) y [`sounds/`](sounds/).

## Evaluación y registro de datos

La evaluación con usuarios combinó un pretest y un postest de conocimientos, cuestionarios de percepción y preguntas abiertas. El juego registra respuestas, comprobaciones e intentos de nivel. El código incluye exportación local en formato **JSONL** y envío de eventos a **Google Sheets**.

## Equipo

- Sebastián García
- Ignacio Matus de la Parra
- Vicente Quezada
