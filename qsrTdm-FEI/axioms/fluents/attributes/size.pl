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
 
 :- module(size,[
		size/4
	]).

size(pk(Body, Depth, Size, Distance), Size, loc(Xr, Yr), do(Action, _Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(Body, Depth, Size, Distance), Profile),
	!.
	
size(pk(Body, _, Size, _), Size, loc(Xr, Yr), do(Action, Situation)):-
	Action=endMove(Robot, loc(Xa, Ya), loc(Xr, Yr), _Time),
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	location(Robot, loc(Xa, Ya), do(PreviousAction,Situation)),
	location(Body, loc(X, Y), Situation),
	radius(Body, Radius),
	euD(loc(X, Y), loc(Xr, Yr), EuDistance),
	SinAlpha is Radius/(EuDistance),
	Alpha is asin(SinAlpha),
	Size is 2*Alpha*180/pi,
	!.
		
size(pk(Body, _, Size, _), Size, loc(Xr, Yr), do(Action, Situation)):-
	Action=endMove(Body, loc(_Xa, _Ya), loc(Xb, Yb), _Time),
	location(_Robot, loc(Xr, Yr), Situation),
	radius(Body, Radius),
	euD(loc(Xr, Yr), loc(Xb, Yb), EuDistance),
	SinAlpha is Radius/(EuDistance),
	Alpha is asin(SinAlpha),
	Size is 2*Alpha*180/pi,
	!.
			
size(pk(Body, Depth, Size, Distance), Size, loc(Xr, Yr), do(Action, Situation)):-
	not((
			robot(Robot),
			Action=endMove(Robot,loc(Xr,Yr), loc(_,_), Time)
		)),
	not(Action=endMove(Body, loc(_X, _Y), loc(_,_), Time)),
	not((
			Action=sense(OtherProfile, loc(Xr, Yr), Time),
			member(pk(Body, _, OtherSize, _), OtherProfile),
			Size\=OtherSize
		)),
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	size(pk(Body, Depth, Size, Distance), Size, loc(Xr, Yr), do(PreviousAction,Situation)),
	!.
	
size(pk(Body, Depth, Size, Distance), Size, loc(Xr, Yr), Situation):-
	situation(Situation,[Action|_]),
	size(pk(Body, Depth, Size, Distance), Size, loc(Xr, Yr), do(Action, Situation)),
	!.