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

:- module(hiding,[
		hiding/4
	]).
	
	
/*
	Hiding does not actually need movement to be true, as it is rather a condition than a transition.
	For that reason, it cannot be bound to an action, as it can be true for any given action as long
	as the calculated distances indicate that an object A is completely ocluding an object B
*/	

hiding(pk(BodyA,_,SizeA,DistA), pk(BodyB,_,SizeB,DistB), loc(Xr,Yr), do(_Action,Situation)):-
	dist(pk(BodyA,_,SizeA,DistA), pk(BodyB,_,SizeB,DistB), Distance, loc(Xr,Yr), Situation),
	location(BodyA, loc(Xa,Ya), Situation),
	location(BodyB, loc(Xb,Yb), Situation),
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	euD(loc(Xb, Yb), loc(Xr, Yr), EuDistanceB),
	(
		EuDistanceA >= EuDistanceB,
		size(pk(BodyA, _, SizeA, _), SizeA, loc(Xr, Yr), Situation),
		Distance =< SizeA*(-1), !;
		EuDistanceB > EuDistanceA,
		size(pk(BodyB, _, SizeB, _), SizeB, loc(Xr, Yr), Situation),
		Distance =< SizeB*(-1), !
	), !.
	
hiding(pk(BodyA,_,SizeA,_),pk(BodyB,_,SizeB,_),loc(Xr,Yr),Situation):-
	situation(Situation,[Action|_]),
	hiding(pk(BodyA,_,SizeA,_),pk(BodyB,_,SizeB,_),loc(Xr,Yr),do(Action,Situation)),
	!.