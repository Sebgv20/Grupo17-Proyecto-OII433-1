function RandomLevel_1(){
	randomize();
	var salas_disponibles = [rLevel1_1, rLevel1_2, rLevel1_3];
	var sala_aleatoria = choose(rLevel1_1, rLevel1_2, rLevel1_3); 
	room_goto(sala_aleatoria);
}

function RandomLevel_2(){
	randomize(); 
	var salas_disponibles = [rLevel2_1, rLevel2_2, rLevel2_3];
	var sala_aleatoria = choose(rLevel2_1, rLevel2_2, rLevel2_3); 
	room_goto(sala_aleatoria);
}

function RandomLevel_3(){
	randomize();
	var salas_disponibles = [rLevel3_1, rLevel3_2, rLevel3_3];
	var sala_aleatoria = choose(rLevel3_1, rLevel3_2, rLevel3_3); 
	room_goto(sala_aleatoria);
}