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
  
 :- module(dist,[
 		dist/4,
		dist/5
	]).

dist(pk(BodyA , DepthA , SizeA , DistanceA ),pk( BodyB , DepthB , SizeB , DistanceB ), Distance, loc( Xr, Yr ), do(Action, _Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(BodyA, DepthA, SizeA, DistanceA), Profile),
	member(pk(BodyB, DepthB, SizeB, DistanceB), Profile),
	(
		DistanceB - SizeB > DistanceA,
		Distance is DistanceB - DistanceA - SizeB;
		DistanceA - SizeA > DistanceB,
		Distance is DistanceA - DistanceB - SizeA
	),
	!.
	
dist(pk(BodyA , _DepthA , _SizeA , _DistanceA ),pk( BodyB , _DepthB , _SizeB , _DistanceB ), Distance, loc( Xr, Yr ), do(Action, Situation)):-
	robot(Robot),
	Action=endMove(Robot, loc(Xra, Yra), loc(Xr, Yr), _Time),
	location(Robot, loc(Xra, Yra), Situation),
	location(BodyA, loc(Xa, Ya), Situation),
	location(BodyB, loc(Xb, Yb), Situation),
	size(pk(BodyA, _, SizeA, _), SizeA, loc(Xr, Yr), do(Action, Situation)),
	size(pk(BodyB, _, SizeB, _), SizeB, loc(Xr, Yr), do(Action, Situation)),
	angleV(loc(Xa,Ya), loc(Xb,Yb), loc(Xr,Yr), Gamma),
	Distance is Gamma - (SizeA/2) - (SizeB/2),
	!.
	
dist(pk(BodyA , _DepthA , _SizeA , _DistanceA ),pk( BodyB , _DepthB , _SizeB , _DistanceB ), Distance, loc( Xr, Yr ), do(Action, Situation)):-
	Action=endMove(BodyA, loc(_Xa1, _Ya1), loc(Xa, Ya), _Time),
	location(_Robot, loc(Xr, Yr), Situation),
	location(BodyB, loc(Xb, Yb), Situation),
	size(pk(BodyA, _, SizeA, _), SizeA, loc(Xr, Yr), do(Action, Situation)),
	size(pk(BodyB, _, SizeB, _), SizeB, loc(Xr, Yr), do(Action, Situation)),
	angleV(loc(Xa, Ya), loc(Xb,Yb), loc(Xr, Yr), Gamma),
	Distance is Gamma - (SizeA/2) - (SizeB/2),
	!.
	
dist(pk(BodyA , _DepthA , _SizeA , _DistanceA ),pk( BodyB , _DepthB , _SizeB , _DistanceB ), Distance, loc( Xr, Yr ), do(Action, Situation)):-
	Action=endMove(BodyB, loc(_Xb1, _Yb1), loc(Xb, Yb), _Time),
	location(_Robot, loc(Xr, Yr), Situation),
	location(BodyA, loc(Xa, Ya), Situation),
	size(pk(BodyA, _, SizeA, _), SizeA, loc(Xr, Yr), do(Action, Situation)),
	size(pk(BodyB, _, SizeB, _), SizeB, loc(Xr, Yr), do(Action, Situation)),
	angleV(loc(Xa, Ya), loc(Xb,Yb), loc(Xr, Yr), Gamma),
	Distance is Gamma - (SizeA/2) - (SizeB/2),
	!.
	
dist(pk(BodyA , DepthA , SizeA , DistanceA ),pk( BodyB , DepthB , SizeB , DistanceB ), Distance, loc( Xr, Yr ), do(Action, Situation)):-	
	not(Action=endMove(Robot, loc(Xr, Yr), loc(_,_), Time)),
	not(Action=endMove(BodyA, loc(Xa, Ya), loc(_,_), Time)),
	not(Action=endMove(BodyB, loc(Xb, Yb), loc(_,_), Time)),
	not((
			Action=sense(OtherProfile, loc(Xr,Yr), Time),
			member(pk(BodyA, _, OtherSizeA, OtherDistanceA), OtherProfile),
			member(pk(BodyB, _, OtherSizeB, OtherDistanceB), OtherProfile),
			(
				OtherDistanceA - OtherSizeA > DistanceB,
				OtherDistance is OtherDistanceA - OtherDistanceB - OtherSizeA,
				not(Distance=OtherDistance);
				OtherDistanceB - OtherSizeB > DistanceA,
				OtherDistance is OtherDistanceB - OtherDistanceA - OtherSizeB,
				not(Distance=OtherDistance)
			)
		)),
	location(BodyA, loc(Xa, Ya), Situation),
	location(BodyB, loc(Xb, Yb), Situation),
	location(Robot, loc(Xr, Yr), Situation),
	dist(pk(BodyA, DepthA, SizeA, DistanceA), pk(BodyB, DepthB, SizeB, DistanceB), Distance, loc(Xr, Yr), Situation),
	!.
	
%% one peak
dist(pk(BodyA , DepthA , SizeA , Distance ), Distance, loc( Xr, Yr ), do(Action, _Situation)):-
	Action=sense(Profile, loc(Xr, Yr), _Time),
	member(pk(BodyA, DepthA, SizeA, Distance), Profile),
	!.
	
dist(pk(BodyB , _DepthB , _SizeB , Distance ), Distance, loc( Xr, Yr ), do(Action, Situation)):-
	Action=endMove(Robot, loc(Xra, Yra), loc(Xr, Yr), _Time),
	location(Robot, loc(Xra, Yra), Situation),
	location(BodyB, loc(Xb, Yb), Situation),
	size(pk(BodyB, _, SizeB, _), SizeB, loc(Xr, Yr), do(Action, Situation)),
	fieldView(Beta),
	angleV(loc(Xb,Yb), loc(Xr,Yr+1), loc(Xr,Yr), Gamma),
	facing(Theta,loc(Xr,Yr),Situation),
	Distance is (Beta/2) + Gamma - Theta - (SizeB/2), 
	!.
	
dist(pk(BodyA , _DepthA , _SizeA , Distance ), Distance, loc( Xr, Yr ), do(Action, Situation)):-
	Action=endMove(BodyA, loc(_Xa1, _Ya1), loc(Xa, Ya), _Time),
	location(_Robot, loc(Xr, Yr), Situation),
	size(pk(BodyA, _, SizeA, _), SizeA, loc(Xr, Yr), do(Action, Situation)),
	fieldView(Beta),
	angleV(loc(Xa,Ya), loc(Xr,Yr+1), loc(Xr,Yr), Gamma),
	facing(Theta,loc(Xr,Yr),Situation),
	Distance is (Beta/2) + Gamma - Theta - (SizeA/2), 
	!.
	
dist(pk(BodyA , DepthA , SizeA , DistanceA ), Distance, loc( Xr, Yr ), do(Action, Situation)):-	
	not(Action=endMove(Robot, loc(Xr, Yr), loc(_,_), Time)),
	not(Action=endMove(BodyA, loc(Xa, Ya), loc(_,_), Time)),
	not((
			Action=sense(OtherProfile, loc(Xr,Yr), Time),
			member(pk(BodyA, _, _, OtherDistanceA), OtherProfile),
			not(DistanceA=OtherDistanceA)
		)),
	location(BodyA, loc(Xa, Ya), Situation),
	location(Robot, loc(Xr, Yr), Situation),
	dist(pk(BodyA, DepthA, SizeA, DistanceA), Distance, loc(Xr, Yr), Situation),
	!.