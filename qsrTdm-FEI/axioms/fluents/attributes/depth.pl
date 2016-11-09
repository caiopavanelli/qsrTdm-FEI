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
 
 :- module(depth,[
		depth/4
	]).

depth(pk(Body, Depth, Size, Distance), Depth, loc(Xr, Yr), do(Action, _Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(Body, Depth, Size, Distance), Profile),
	!.
	
depth(pk(Body, Depth, _, _), Depth, loc(Xr, Yr), do(Action, Situation)):-
	Action=endMove(Robot, loc(Xa, Ya), loc(Xr, Yr), _Time),
	location(Body, loc(X, Y), Situation),
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	location(Robot, loc(Xa, Ya), do(PreviousAction,Situation)),
	radius(Body, Radius),
	euD(loc(X, Y), loc(Xr, Yr), EuDistance),
	Depth is EuDistance - Radius,
	!.
		
depth(pk(Body, Depth, _, _), Depth, loc(Xr, Yr), do(Action, Situation)):-
	Action=endMove(Body, loc(_Xa, _Ya), loc(Xb, Yb), _Time),
	location(_Robot, loc(Xr, Yr), Situation),
	radius(Body, Radius),
	euD(loc(Xr, Yr), loc(Xb, Yb), EuDistance),
	Depth is EuDistance - Radius,
	!.
			
depth(pk(Body, Depth, Size, Distance), Depth, loc(Xr, Yr), do(Action, Situation)):-
	not((
			robot(Robot),
			Action=endMove(Robot,loc(Xr,Yr), _, Time)
		)),
	not(Action=endMove(Body, loc(_X, _Y), loc(_,_), Time)),
	not((
			Action=sense(OtherProfile, loc(Xr, Yr), Time),
			member(pk(Body, OtherDepth, _, _), OtherProfile),
			Depth\=OtherDepth
		)),
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	depth(pk(Body, Depth, Size, Distance), Depth, loc(Xr, Yr), do(PreviousAction, Situation)),
	!.
	
depth(pk(Body, Depth, Size, Distance), Depth, loc(Xr, Yr), Situation):-
	situation(Situation,[Action|_]),
	depth(pk(Body, Depth, Size, Distance), Depth, loc(Xr, Yr), do(Action, Situation)),
	!.