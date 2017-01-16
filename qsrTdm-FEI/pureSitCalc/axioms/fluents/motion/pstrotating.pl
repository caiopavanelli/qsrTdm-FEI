/*****************************************************************
 * This file is part of the masterTDM projet based on the paper
 * M. Soutchanski and  P.Santos
 * "Reasoning about Dynamic Depth Profiles"
 * 
 * mail: caiopava@fei.edu.br
 * author: Caio Pavanelli Truffe de Oliveira
 * Copyright (C): 2016, Electrical Engineering Department, Centro Universit�rio da FEI
 *
 *****************************************************************/
 
 :- module(rotating,[
		rotating/2
	]).

rotating(Omega, do(Action, _Situation)):-
	Action=startPan(Omega, _Time),
	!.
	
rotating(Omega, do(Action, Situation)):-
	not(Action=endPan(Omega, _)),
	rotating(Omega, Situation), 
	!.
	
	