function RandomLevel_1(){
	randomize();
	var salas_disponibles = [rLevel1_1, rLevel1_2, rLevel1_3];
	var sala_aleatoria = choose(rLevel1_1, rLevel1_2, rLevel1_3); 
	room_goto(sala_aleatoria);
}

function RandomLevel_2(){
	randomize();
	var salas_disponibles = [rLevel1_1, rGrass];
	var sala_aleatoria = choose(rLevel1_1, rGrass); 
	room_goto(rLevel1_1);
}

function RandomLevel_3(){
	randomize();
	var salas_disponibles = [rLevel1_1, rGrass];
	var sala_aleatoria = choose(rLevel1_1, rGrass); 
	room_goto(rLevel1_1);
}