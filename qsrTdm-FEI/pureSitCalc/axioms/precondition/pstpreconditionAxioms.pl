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
 
 :- module(preconditionAxioms,[
		poss/2
	]).

poss(startMove(Body, Location1, Location2, Time), Situation):- 
	location(Body,Location1,Situation),
	not(moving(Body,Location,_,Situation)),
	not(moving(Body,Location,Location2,Situation)),
	Location1 \= Location2,
	start(Situation,OtherTime),
	Time >= OtherTime, !.

poss(endMove(Body, Location1, Location2, Time), Situation):- 
	moving(Body, Location1, Location2, Situation),
	start(Situation,OtherTime),
	Time>=OtherTime,
	Location1\=Location2, !.
									
poss(startPan(Omega, Time), Situation):- 
	not(rotating(Omega, Situation)),
	start(Situation, OtherTime),
	Time>=OtherTime, !.
									
poss(endPan(Omega,Time), Situation):- 
	rotating(Omega, Situation),
	start(Situation,OtherTime),
	Time>=OtherTime, !.
						
poss(sense(Profile, Location, Time2), Situation):- 
	start(Situation, Time1),
	Time2>=Time1,
	robot(Robot),
	location(Robot, Location, Situation),
	member(pk(Body, Depth, Size, AngularDistance), Profile),
	Depth>0,
	Size>0,
	AngularDistance>0,
	facing(Theta, loc(Xr, Yr), Situation),
	fieldView(Beta),
	visible(loc(Xr, Yr), Body, Beta, Theta, Situation),
	not((member(pk(InvisibleBody, _Depth1, _Size1, _AngularDistance1), Profile),
		 not(InvisibleBody=Body),
		 not(visible(loc(Xr, Yr), InvisibleBody, Beta, Theta, Situation)))), !.

	
	
	
	
	
						