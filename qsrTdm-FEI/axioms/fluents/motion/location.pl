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
 
 :- module(location,[
		location/3
	]).
	
:- dynamic location/3.

location(Body, loc(X, Y), do(Action, _Situation)):-
	Action=endMove(Body, loc(_, _), loc(X, Y), _Time),
	!.

location(Body, loc(X, Y), do(Action, Situation)):-	
	not((
			Action=endMove(Body, loc(X, Y), loc(_, _), Time),
			start(Situation, Time1),
			Time =< Time1
		)),
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	location(Body, loc(X, Y), do(PreviousAction, Situation)),
	!.
		
location(Body, loc(X, Y), Situation):-	
	situation(Situation,[Action|_]),
	location(Body, loc(X, Y), do(Action, Situation)),
	!.