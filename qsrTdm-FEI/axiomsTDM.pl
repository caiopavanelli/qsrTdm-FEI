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

:-dynamic situation/2,
			fieldView/1,
			limitBoundary/1,
			sensedProfile/1,
			thresholdBoundary/1.

:- ['axioms/general/load'].
:- ['axioms/primitiveActions/load'].
:- ['axioms/precondition/load'].
:- ['axioms/fluents/load'].

%% fake data for processing sense action without an actual sensor
%% sensed data represents a body perceived at distance 4, size 3 and angular distance 60
%% \     3     /
%%  \ 60 O    /
%%   \   |   /
%%    \  |4 /
%%     \ | /
%%      \|/
%%       R
sensedProfile([pk(bodyA, 4, 3, 60)]).

writeln(T,Filename) :- open(Filename,append,Stream), write(Stream,T), nl(Stream), close(Stream). 

querypairs(X,Y, approaching(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), s0)).
querypairs(X,Y, coalescing(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), s0)).
querypairs(X,Y, hiding(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), s0)).
querypairs(X,Y, splitting(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), s0)).
querypairs(X,Y, receding(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), s0)).
querypairs(X,Y, two_peak_static(pk(bodyA, _DepthA, _SizeA, _DistanceA), pk(bodyB, _DepthB, _SizeB, _DistanceB), loc(X, Y), s0)).

querypairsAttribute(X,Y, depth(pk(bodyA, Depth, _, _), Depth, loc(X,Y), s0)).
querypairsAttribute(X,Y, size(pk(bodyA, _, Size, _), Size, loc(X,Y), s0)).
querypairsAttribute(X,Y, dist(pk(bodyA, _, _, Dist), Dist, loc(X,Y), s0)).
querypairsAttribute(X,Y, depth(pk(bodyB, Depth, _, _), Depth, loc(X,Y), s0)).
querypairsAttribute(X,Y, size(pk(bodyB, _, Size, _), Size, loc(X,Y), s0)).
querypairsAttribute(X,Y, dist(pk(bodyB, _, _, Dist), Dist, loc(X,Y), s0)).
querypairsAttribute(X,Y, dist(pk(bodyA, _, _, _DistA), pk(bodyB, _, _, _DistB), _Dist, loc(X,Y), s0)).

call_time(G,T) :-
   statistics(runtime,[T0|_]),
   (G; not(G)),
   statistics(runtime,[T1|_]),
   T is T1 - T0.

:- use_module(initTestSingle).
:- use_module(initTestPairs).

:- include(tdmTestMovement).
:- include(tdmTestSinglePeak).
:- include(tdmTestPairOfPeaks).

