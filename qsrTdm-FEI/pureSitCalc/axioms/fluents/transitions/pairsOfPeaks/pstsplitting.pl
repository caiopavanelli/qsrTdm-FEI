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

:- module(splitting,[
		splitting/4
	]).

splitting(pk(BodyA,_,SizeA,DistA), pk(BodyB,_,SizeB,DistB), loc(Xr,Yr), do(Action,Situation)):-
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
	DistanceB > Distance, 
	thresholdUnion(Delta), 
	DistanceB < Delta,
	thresholdHiding(Lambda),
	DistanceB >= Lambda,
	location(BodyA, loc(Xa,Ya), Situation),
	location(BodyB, loc(Xb,Yb), Situation),
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistanceB),
	(
		EuDistanceA >= EuDistanceB,
		Distance > SizeA*(-1), !;
		EuDistanceB > EuDistanceA,
		Distance > SizeB*(-1), !
	),
	!.

splitting(pk(BodyA, _, SizeA, _), pk(BodyB, _, SizeB ,_), loc(X,Y), do(Action,Situation)):-
	robot(Robot),
	Action=startMove(Robot, loc(X,Y), loc(Xr,Yr), _Time), 
	location(BodyA, loc(Xa,Ya), Situation),
	location(BodyB, loc(Xb,Yb), Situation),
	dist(pk(BodyA,_,SizeA,_), pk(BodyB,_,SizeB,_), DistanceA, loc(X,Y), Situation),
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
	DistanceB > DistanceA,
	thresholdUnion(Delta), 
	DistanceB < Delta,
	thresholdHiding(Lambda),
	DistanceB >= Lambda,
	(
		EuDistanceA >= EuDistanceB,
		DistanceA > SizeA2*(-1), !;
		EuDistanceB > EuDistanceA,
		DistanceA > SizeB2*(-1), !
	),!.


splitting(pk(BodyA, _, SizeA, _), pk(BodyB, _, SizeB ,_), loc(Xr,Yr), do(Action,Situation)):-
	Action=startMove(BodyA, loc(X,Y), loc(Xa,Ya), _Time), 
	robot(Robot),
	location(Robot, loc(Xr,Yr), Situation), 
	location(BodyA, loc(X,Y), Situation), 
	location(BodyB, loc(Xb,Yb), Situation),
	dist(pk(BodyA,_,SizeA,_), pk(BodyB,_,SizeB,_), DistanceA, loc(Xr,Yr), Situation),
	radius(BodyA, RadiusA), 
	radius(BodyB, _RadiusB), 
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistanceB),
	SinAlphaA is RadiusA/(EuDistanceA),
	AlphaA is asin(SinAlphaA),
	SizeA2 is 2*AlphaA*180/pi,
	angleV(loc(Xa,Ya), loc(Xb,Yb), loc(Xr,Yr), DistB),
	DistanceB is DistB - (SizeA2/2) - (SizeB/2),
	DistanceB > DistanceA,
	thresholdUnion(Delta), 
	DistanceB < Delta,
	thresholdHiding(Lambda),
	DistanceB >= Lambda,
	(
		EuDistanceA >= EuDistanceB,
		DistanceA > SizeA2*(-1), !;
		EuDistanceB > EuDistanceA,
		DistanceA > SizeB*(-1), !
	),!.

splitting(pk(BodyA, _, SizeA, _), pk(BodyB, _, SizeB ,_), loc(Xr,Yr), do(Action,Situation)):-
	Action=startMove(BodyB, loc(X,Y), loc(Xb,Yb), _Time), 
	robot(Robot),
	location(Robot, loc(Xr,Yr), Situation), 
	location(BodyA, loc(Xa,Ya), Situation), 
	location(BodyB, loc(X,Y), Situation),
	dist(pk(BodyA,_,SizeA,_), pk(BodyB,_,SizeB,_), DistanceA, loc(Xr,Yr), Situation),
	radius(BodyA, _RadiusA), 
	radius(BodyB, RadiusB), 
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistanceB),
	SinAlphaB is RadiusB/(EuDistanceB),
	AlphaB is asin(SinAlphaB),
	SizeB2 is 2*AlphaB*180/pi,
	angleV(loc(Xa,Ya), loc(Xb,Yb), loc(Xr,Yr), DistB),
	DistanceB is DistB - (SizeA/2) - (SizeB2/2),
	DistanceB > DistanceA,
	thresholdUnion(Delta), 
	DistanceB < Delta,
	thresholdHiding(Lambda),
	DistanceB >= Lambda,
	(
		EuDistanceA >= EuDistanceB,
		DistanceA > SizeA*(-1), !;
		EuDistanceB > EuDistanceA,
		DistanceA > SizeB2*(-1), !
	),!.

splitting(pk(BodyA,_,SizeA,_),pk(BodyB,_,SizeB,_),loc(Xr,Yr),do(Action,Situation)):-	
	thresholdUnion(Delta), 
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
				DistanceB2 =< Distance, !; 
				DistanceB2 >= Delta, !
			)
		)),
	not(Action=endMove(BodyA, loc(Xa,Ya), loc(_,_), Time)),
	not(Action=endMove(BodyB, loc(Xb,Yb), loc(_,_), Time)),
	not((
			robot(Robot),
			Action=endMove(Robot, loc(Xr,Yr), loc(_,_), Time)
		)),
	location(Robot, loc(Xr,Yr), Situation), 
	location(BodyA, loc(Xa,Ya), Situation), 
	location(BodyB, loc(Xb,Yb), Situation), 
	splitting(pk(BodyA,_,SizeA,DistA),pk(BodyB,_,SizeB,DistB),loc(Xr,Yr),Situation), 
	!.
	