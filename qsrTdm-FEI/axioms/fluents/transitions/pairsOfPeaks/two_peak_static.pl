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

:- module(two_peak_static,[
		two_peak_static/4
	]).
	
two_peak_static(pk(BodyA,_,SizeA,DistA), pk(BodyB,_,SizeB,DistB), loc(Xr,Yr), do(Action,Situation)):-
	Action=sense(Profile, loc(Xr,Yr), _Time), 
	member(pk(BodyA,_,SizeA,DistA), Profile),
	member(pk(BodyB,_,SizeB,DistB), Profile),
	robot(Robot), 
	location(Robot, loc(Xr, Yr), Situation),
	( 
		DistB > DistA + SizeA,
		DistanceB is  DistB - DistA - SizeA ;
	  	DistA > DistB + SizeB,
		DistanceB is DistA - DistB - SizeB
	),
	dist(pk(BodyA,_,SizeA,DistA), pk(BodyB,_,SizeB,DistB), Distance, loc(Xr,Yr), Situation),
	DistanceB = Distance,
	!.

two_peak_static(pk(BodyA, _, SizeA, _), pk(BodyB, _, SizeB ,_), loc(Xr,Yr), do(Action,Situation)):-
	robot(Robot),
	Action=endMove(Robot, loc(_Xa,_Ya), loc(Xr,Yr), _Time), 
	location(BodyA, loc(Xa,Ya), Situation),
	location(BodyB, loc(Xb,Yb), Situation),
	dist(pk(BodyA,_,SizeA,_), pk(BodyB,_,SizeB,_), DistanceA, loc(Xr,Yr), Situation),
	radius(BodyA, RadiusA),
	radius(BodyB, RadiusB),
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	SinAlphaA is RadiusA/(EuDistanceA),
	AlphaA is asin(SinAlphaA),
	SizeA2 is 2*AlphaA*180/pi,
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistanceB),
	SinAlphaB is RadiusB/(EuDistanceB),
	AlphaB is asin(SinAlphaB),
	SizeB2 is 2*AlphaB*180/pi,
	angleV(loc(Xa,Ya), loc(Xb,Yb), loc(Xr,Yr), DistB),
	DistanceB is DistB - (SizeA2/2) - (SizeB2/2),
	DistanceB = DistanceA,
	!.


two_peak_static(pk(BodyA, _, SizeA, _), pk(BodyB, _, SizeB ,_), loc(Xr,Yr), do(Action,Situation)):-
	Action=endMove(BodyA, loc(X,Y), loc(Xa,Ya), _Time), 
	robot(Robot),
	location(Robot, loc(Xr,Yr), Situation), 
	location(BodyA, loc(X,Y), Situation), 
	location(BodyB, loc(Xb,Yb), Situation),
	dist(pk(BodyA,_,SizeA,_), pk(BodyB,_,SizeB,_), DistanceA, loc(Xr,Yr), Situation),
	radius(BodyA, RadiusA), 
	radius(BodyB, _RadiusB), 
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	SinAlphaA is RadiusA/(EuDistanceA),
	AlphaA is asin(SinAlphaA),
	SizeA2 is 2*AlphaA*180/pi,
	angleV(loc(Xa,Ya), loc(Xb,Yb), loc(Xr,Yr), DistB),
	DistanceB is DistB - (SizeA2/2) - (SizeB/2),
	DistanceB = DistanceA,
	!.

two_peak_static(pk(BodyA, _, SizeA, _), pk(BodyB, _, SizeB ,_), loc(Xr,Yr), do(Action,Situation)):-
	Action=endMove(BodyB, loc(X,Y), loc(Xb,Yb), _Time), 
	robot(Robot),
	location(Robot, loc(Xr,Yr), Situation), 
	location(BodyA, loc(Xa,Ya), Situation), 
	location(BodyB, loc(X,Y), Situation),
	dist(pk(BodyA,_,SizeA,_), pk(BodyB,_,SizeB,_), DistanceA, loc(Xr,Yr), Situation),
	radius(BodyA, _RadiusA), 
	radius(BodyB, RadiusB), 
	euD(loc(Xb, Xb), loc(Xr, Yr), EuDistanceB),
	SinAlphaB is RadiusB/(EuDistanceB),
	AlphaB is asin(SinAlphaB),
	SizeB2 is 2*AlphaB*180/pi,
	angleV(loc(Xa,Ya), loc(Xb,Yb), loc(Xr,Yr), DistB),
	DistanceB is DistB - (SizeA/2) - (SizeB2/2),
	DistanceB = DistanceA,
	!.

two_peak_static(pk(BodyA,_,SizeA,_),pk(BodyB,_,SizeB,_),loc(Xr,Yr),do(Action,Situation)):-	
	not((
			Action=sense(Profile, loc(Xr,Yr), Time), 
			member(pk(BodyA, _, SizeA2, DistA2), Profile),
			member(pk(BodyB, _, SizeB2, DistB2), Profile), 
			( 
				DistB2 > DistA2 + SizeA2,
				DistanceB2 is  DistB2 - DistA2 - SizeA2 ;
			  	DistA2 > DistB2 + SizeB2,
				DistanceB2 is DistA2 - DistB2 - SizeB2
			),
			dist(pk(BodyA,_,SizeA,DistA), pk(BodyB,_,SizeB,DistB), Distance, loc(Xr,Yr), Situation),
			( 
				DistanceB2 > Distance, !;
				DistanceB2 < Distance, !
			)
		)),
	not(Action=startMove(BodyA, loc(Xa,Ya), loc(_,_), Time)),
	not(Action=startMove(BodyB, loc(Xb,Yb), loc(_,_), Time)),
	not((
			robot(Robot),
			Action=startMove(Robot, loc(Xr,Yr), loc(_,_), Time)
		)),
	location(Robot, loc(Xr,Yr), Situation), 
	location(BodyA, loc(Xa,Ya), Situation), 
	location(BodyB, loc(Xb,Yb), Situation), 
	situation(Situation,ActionList),
	prevAction(PreviousAction, Action, ActionList),
	two_peak_static(pk(BodyA,_,SizeA,DistA),pk(BodyB,_,SizeB,DistB),loc(Xr,Yr),do(PreviousAction,Situation)), 
	!.
	
two_peak_static(pk(BodyA,_,SizeA,_),pk(BodyB,_,SizeB,_),loc(Xr,Yr),Situation):-
	situation(Situation,[Action|_]),
	two_peak_static(pk(BodyA,_,SizeA,_),pk(BodyB,_,SizeB,_),loc(Xr,Yr),do(Action,Situation)),
	!.
