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

:- module(primitiveActions,[
		primitive_action/1,
		actionConsequences/2
	]).

primitive_action(startMove(_Body,_Location1,_Location2,_Time)).

primitive_action(endMove(_Body,_Location1,_Location2,_Time)).

primitive_action(startPan(_Omega,_Time)).

primitive_action(endPan(_Omega,_Time)).

primitive_action(sense(_P,loc(_Xr,_Yr),_Time)).

startMove(_Body,_Location1,_Location2,_Time).

endMove(_Body,_Location1,_Location2,_Time).

startPan(_Omega,_Time).

endPan(_Omega,_Time).

sense(_P,loc(_Xr,_Yr),_Time).

%% Some actions have consequences, and for that reason it was
%% created an special axiom that assert the novel knowledge
%% of the world
actionConsequences(startMove(_Body,_Location1,_Location2,_Time), _Situation).

%% this has to update the current location of the body
actionConsequences(endMove(Body,_Location1,Location2,_Time), Situation):-
	location(Body, Location, Situation),
	retract(location(Body, Location, Situation)),
	assertz(location(Body,Location2,Situation)),
	(
		not(robot(Body)), !;
		robot(Body),
		facing(Omega,Location,Situation),
		retract(facing(Omega,Location,Situation)),
		assertz(facing(Omega,Location2,Situation))
	).
	
actionConsequences(startPan(_Omega,_Time), _Situation).

%% this has to update the current angle from the North the robot is currently facing
actionConsequences(endPan(Omega,_Time), Situation):-
	robot(Robot),
	location(Robot, Location, Situation),
	facing(OldTheta, OldLocation, Situation),
	OmegaT is (OldTheta+Omega) mod 360,
	(
		OmegaT >= 0,
		OmegaT =< 180,
		NewTheta is OmegaT, !;
		OmegaT > 180,
		NewTheta is (-1*(180 - (OmegaT - 180))), !;
		OmegaT < 0,
		OmegaT >= -180,
		NewTheta is OmegaT, !;
		OmegaT < -180,
		NewTheta is (180 + (OmegaT + 180)), !
	 ),
	retract(facing(OldTheta, OldLocation, Situation)),
	assertz(facing(NewTheta, Location, Situation)).

%% this has to update the current sensed profile
actionConsequences(sense(Profile,loc(_Xr,_Yr),_Time), _Situation):-
	sensedProfile(P),
	retract(sensedProfile(P)),
	assertz(sensedProfile(Profile)).
	
	
	