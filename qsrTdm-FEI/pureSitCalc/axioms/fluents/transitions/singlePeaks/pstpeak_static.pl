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

:- module(peak_static,[
		peak_static/3
	]).

peak_static(pk(Body, DepthB, SizeB, DistanceB), loc(Xr, Yr), do(Action, Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(Body, DepthB, SizeB, _DistanceB), Profile),
	robot(Robot),
	location(Robot, loc(Xr, Yr), Situation),
	size(pk(Body, DepthA, SizeA, DistanceA), SizeA, loc(Xr, Yr), Situation),
	depth(pk(Body, DepthA, SizeA, DistanceA), DepthA, loc(Xr, Yr), Situation),
	dist(pk(Body, DepthA, SizeA, DistanceA), DistanceA, loc(Xr, Yr), Situation),
	SizeA = SizeB,
	DepthA = DepthB,
	DistanceA = DistanceB,
	!.

peak_static(pk(Body, DepthB, SizeB, DistanceB), loc(Xr, Yr), do(Action, Situation)):-
	Action=endMove(Robot, loc(_Xa, _Ya), loc(Xr, Yr), _Time),
	robot(Robot),
	location(Robot, loc(Xr, Yr), Situation),
	location(Body, loc(Xb, Yb), Situation),
	radius(Body, Radius),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistance),
	SinAlpha is Radius/(EuDistance),
	Alpha is asin(SinAlpha),
	SizeB is 2*Alpha*180/pi,
	DepthB is EuDistance - Radius,
	size(pk(Body, DepthA, SizeA, DistanceA), SizeA, loc(Xr, Yr), Situation),
	depth(pk(Body, DepthA, SizeA, DistanceA), DepthA, loc(Xr, Yr), Situation),
	dist(pk(Body, DepthA, SizeA, DistanceA), DistanceA, loc(Xr, Yr), Situation),
	SizeA = SizeB,
	DepthA = DepthB,
	DistanceA = DistanceB,
	!.
	
peak_static(pk(Body, DepthB, SizeB, DistanceB), loc(Xr, Yr), do(Action, Situation)):-
	Action=endMove(Body, loc(Xa, Ya), loc(Xb, Yb), _Time),
	robot(Robot),
	location(Robot, loc(Xr, Yr), Situation),
	location(Body, loc(Xa, Ya), Situation),
	radius(Body, Radius),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistance),
	SinAlpha is Radius/(EuDistance),
	Alpha is asin(SinAlpha),
	SizeB is 2*Alpha*180/pi,
	DepthB is EuDistance - Radius,
	size(pk(Body, DepthA, SizeA, _), SizeA, loc(Xr, Yr), Situation),
	depth(pk(Body, DepthA, SizeA, _), DepthA, loc(Xr, Yr), Situation),
	dist(pk(Body, DepthA, SizeA, DistanceA), DistanceA, loc(Xr, Yr), Situation),
	SizeA = SizeB,
	DepthA = DepthB,
	DistanceA = DistanceB,
	!.
		
peak_static(pk(Body, DepthA, SizeA, DistanceA), loc(Xr, Yr), do(Action, Situation)):-
	not((
			Action=sense(Profile, loc(Xr, Yr), Time),
			member(pk(Body, DepthB, SizeB, DistanceB), Profile),
			(
				SizeA \= SizeB, !;
				DepthA \= DepthB, !;
				DistanceA \= DistanceB, !
			)
		)),
	not(Action=startMove(Robot, loc(Xr, Yr), loc(_Xrn, _Yrn), Time)),
	not(Action=startMove(Body, loc(Xb, Yb), loc(_Xbn, _Ybn), Time)),
	location(Robot, loc(Xr, Yr), Situation),
	location(Body, loc(Xb, Yb), Situation),
	peak_static(pk(Body, DepthA, SizeA, DistanceA), loc(Xr, Yr), Situation),
	!.
	