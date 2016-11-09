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
 
 :- module(visible,[
		visible/5
	]).

	
%% the body is visible if after moving that body to another location, or the
%% robot moved to another location, the euclidean distance
%% between the new location and the location of the robot is smaller than the Limit
%% boundary of sensor capacity, and the angle formed by the vectors formed by
%% the coordinates of body location and robot location and the coordinates
%% of the robot location and an arbitrary point north of of the robot location.
%% Since we have the angle related to the North the robot is facing, the angle of
%% the field of view of the robot, by calculating the angle to the north of the vectors
%% robot body we can see if its located within the field of view of the robot
visible(loc(Xr, Yr), Body, _Beta, _Theta, do(Action,_Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(Body, _Depth, _Size, _Distance), Profile),
	!.

visible(loc(Xr, Yr), Body, Beta, Theta, do(Action,Situation)):-
	fieldView(Beta),
	facing(Theta, loc(Xr, Yr), Situation),
	location(Body, loc(Xb, Yb), Situation),
	Action=endMove(Body, loc(Xb, Yb), loc(NXb, NYb), _Time),
	euD(loc(Xr,Yr), loc(NXb,NYb), EuDistance),
	limitBoundary(L),
	EuDistance=<L,
	angleV(loc(NXb, NYb),loc(Xr, Yr+1), loc(Xr, Yr), Gamma),
	abs(Theta-Gamma)=<(Beta/2),
	!.
	
visible(loc(NXr, NYr), Body, Beta, Theta, do(Action,Situation)):-
	fieldView(Beta),
	facing(Theta, loc(NXr, NYr), Situation),
	location(Body, loc(Xb, Yb), Situation),
	robot(Robot),
	Action=endMove(Robot, loc(_Xr, _Yr), loc(NXr, NYr), _Time),
	euD(loc(NXr,NYr), loc(Xb,Yb), EuDistance),
	limitBoundary(L),
	EuDistance=<L,
	angleV(loc(Xb, Yb),loc(NXr, NYr+1), loc(NXr, NYr), Gamma),
	abs(Theta-Gamma)=<(Beta/2),
	!.

visible(loc(Xr, Yr), Body, Beta, Theta, do(Action,Situation)):-
	location(Body, loc(Xb, Yb), Situation),
	not(Action=endMove(_Robot,loc(Xr,Yr), _, Time)),
	not(Action=endMove(Body, loc(Xb, Yb), loc(_,_), Time)),
	not((
			Action=sense(OtherProfile, loc(Xr, Yr), Time),
			not(member(pk(Body, _, _, _), OtherProfile))
		)),
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	visible(loc(Xr, Yr), Body, Beta, Theta, do(PreviousAction,Situation)),
	!.
	
/* Verifies if the body is moving after last actions */
visible(loc(Xr, Yr), Body, Beta, Theta, Situation):-
	situation(Situation,[Action|_]),
	visible(loc(Xr, Yr), Body, Beta, Theta, do(Action,Situation)), !.
	
	
	
	
	