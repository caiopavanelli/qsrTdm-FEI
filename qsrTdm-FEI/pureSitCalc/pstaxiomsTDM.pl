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

act([],_,_).	
act([LH|LT],S0,Filename):-
	do(LH,S0,S2),
	writeln(do(LH,S0),Filename),
	test_action( S2, Filename),
	act(LT,S2,Filename).
   
test_action(S, Filename) :-
	location(cpto, loc(X,Y), S), 
	forall(pstpstquerypairsAttribute(X,Y,AT,S), (call_time(AT, Ta), writeln(Ta:AT,Filename))),
   	forall(pstquerypairs(X,Y,Q,S), (Q -> call_time(Q, Ts), writeln(Ts:true:Q,Filename) ; call_time(Q, Ts), writeln(Ts:false:Q,Filename))).
   

call_time(G,T) :-
   statistics(runtime,[T0|_]),
   (G; not(G)),
   statistics(runtime,[T1|_]), 
   T is T1 - T0.

:- use_module(pstinitTestPairs).
:- include(psttdmTestPairOfPeaks).

:- use_module(pstinitFluentsTest).
:- include(psttdmFluentsTest).

:- use_module(pstinitStress1000).
:- include(psttdmStress1000).

