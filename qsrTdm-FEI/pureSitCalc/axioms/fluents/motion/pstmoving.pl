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
 
 :- module(moving,[
		moving/4
	]).

/* Time constraints are verified in action axioms, for fluents they are not necessary */
moving(Body, Location1, Location2, do(Action, _Situation)):-
	Action=startMove(Body, Location1, Location2, _Time), 
	!.

moving(Body, Location1, Location2, do(Action, Situation)):-
	not(Action=endMove(Body, Location1, Location2, _Time)),
	moving(Body, Location1, Location2, Situation),
	!.
	
	