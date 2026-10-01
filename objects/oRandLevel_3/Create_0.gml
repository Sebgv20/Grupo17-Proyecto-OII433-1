randomize();
// Definimos las salas que queremos que participen en el azar
// Reemplaza rGrass, rSand y rTuOtraSala por los nombres reales de tus rooms
var salas_disponibles = [rLevel1_1, rGrass];

// Elegimos una posición al azar dentro del arreglo
var sala_aleatoria = choose(rLevel1_1, rGrass); 
// O de forma más automatizada:
// var sala_aleatoria = salas_disponibles[irandom(array_length(salas_disponibles) - 1)];

// Nos transportamos inmediatamente a esa sala
room_goto(sala_aleatoria);