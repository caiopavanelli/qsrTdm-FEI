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

:- module(extending,[
		extending/3
	]).

extending(pk(Body, DepthA, SizeA, DistanceA), loc(Xr, Yr), do(Action, Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(Body, DepthB, SizeB, _DistanceB), Profile),
	robot(Robot),
	location(Robot, loc(Xr, Yr), Situation),
	limitBoundary(L),
	size(pk(Body, DepthA, SizeA, DistanceA), SizeA, loc(Xr, Yr), Situation),
	depth(pk(Body, DepthA, SizeA, DistanceA), DepthA, loc(Xr, Yr), Situation),
	SizeA < SizeB,
	DepthA =< L,
	DepthB =< L,
	!.

extending(pk(Body, DepthA, SizeA, DistanceA), loc(Xa, Ya), do(Action, Situation)):-
	Action=startMove(Robot, loc(Xa, Ya), loc(Xr, Yr), _Time),
	robot(Robot),
	location(Robot, loc(Xa, Ya), Situation),
	limitBoundary(L),
	location(Body, loc(Xb, Yb), Situation),
	radius(Body, Radius),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistance),
	SinAlpha is Radius/(EuDistance),
	Alpha is asin(SinAlpha),
	SizeB is 2*Alpha*180/pi,
	DepthB is EuDistance - Radius,
	size(pk(Body, DepthA, SizeA, DistanceA), SizeA, loc(Xa, Ya), Situation),
	depth(pk(Body, DepthA, SizeA, DistanceA), DepthA, loc(Xa, Ya), Situation),
	SizeA < SizeB,
	DepthA =< L,
	DepthB =< L,
	!.
	
extending(pk(Body, DepthA, SizeA, DistanceA), loc(Xr, Yr), do(Action, Situation)):-
	Action=startMove(Body, loc(Xa, Ya), loc(Xb, Yb), _Time),
	robot(Robot),
	location(Robot, loc(Xr, Yr), Situation),
	limitBoundary(L),
	location(Body, loc(Xa, Ya), Situation),
	radius(Body, Radius),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistance),
	SinAlpha is Radius/(EuDistance),
	Alpha is asin(SinAlpha),
	SizeB is 2*Alpha*180/pi,
	DepthB is EuDistance - Radius,
	size(pk(Body, DepthA, SizeA, DistanceA), SizeA, loc(Xr, Yr), Situation),
	depth(pk(Body, DepthA, SizeA, DistanceA), DepthA, loc(Xr, Yr), Situation),
	SizeA < SizeB,
	DepthA =< L,
	DepthB =< L,
	!.
		
extending(pk(Body, DepthA, SizeA, DistanceA), loc(Xr, Yr), do(Action, Situation)):-
	limitBoundary(L),
	not((
			Action=sense(Profile, loc(Xr, Yr), Time),
			member(pk(Body, DepthB, SizeB, _), Profile),
			(
				SizeA >= SizeB, !;
				DepthB > L, !
			)
		)),
	not(Action=endMove(Robot, loc(Xr, Yr), loc(_Xrn, _Yrn), Time)),
	not(Action=endMove(Body, loc(Xb, Yb), loc(_Xbn, _Ybn), Time)),
	location(Robot, loc(Xr, Yr), Situation),
	location(Body, loc(Xb, Yb), Situation),
	extending(pk(Body, DepthA, SizeA, DistanceA), loc(Xr, Yr), Situation),
	!.
	