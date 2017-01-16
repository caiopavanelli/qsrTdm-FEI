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

 :- module(generalAxioms,[
		euD/3,
		angle/6,
		angleV/4,
		start/2,
		time/2,
%		do/2,
		do/3,
		situation/2,
		prevAction/3,
		robot/1
	]).

:- dynamic start/2.

robot(cpto).

euD(loc(X1, Y1), loc(X2, Y2), Distance):-
	Z is (X1 - X2)^2 + (Y1 - Y2)^2,
	Distance is sqrt(Z).

angle(loc(Xa, Ya), loc(Xb, Yb), loc(Xr, Yr), RadiusA, RadiusB, Gamma):-
	euD(loc(Xa, Ya), loc(Xr, Yr), EuDistanceA),
	euD(loc(Xr, Yr), loc(Xb, Yb), EuDistanceB),
	AlphaA is asin( (Ya - Yr)/EuDistanceA ),
	AlphaB is asin( (Yb - Yr)/EuDistanceB ),
	BetaA is atan( RadiusA/EuDistanceA ),
	BetaB is atan( RadiusB/EuDistanceB ),
	Gamma is pi - AlphaA - AlphaB - BetaA - BetaB.

angleV(loc(Xa, Ya), loc(Xb, Yb), loc(Xr, Yr), Gamma):-
	Vax is Xa-Xr,
	Vay is Ya-Yr,
	Vbx is Xb-Xr,
	Vby is Yb-Yr,
	GammaT is acos(((Vax*Vbx)+(Vay*Vby))/(sqrt(Vax^2+Vay^2)*sqrt(Vbx^2+Vby^2)))*180/pi,
	Gamma is abs(GammaT).

start(do(A,_S),T) :- time(A,T).

%time(startMove(_Body,_Location1,_Location2,Time), Time).
%time(endMove(_Body,_Location1,_Location2,Time), Time).
%time(startPan(_Omega,Time), Time).
%time(endPan(_Omega,Time), Time).
%time(sense(_P,loc(_Xr,_Yr),Time), Time).

%% Generalized version of time/2 advised from Prof. Dr. Silvio do Lago Pereira
time(Action,Time) :-
   Action =.. List,
   last(List,Time).
   
do(A, S, do(A,S)).

%axiom do, adds an action to the situation sequence
%do(A,S):-
%	primitive_action(A),
%	poss(A,S),
%	not(situation(S,_)),
%	start(S,T1),
%	actionConsequences(A,S),
%	persist([],[A|[]],S),
%	time(A,T),
%	retract(start(S,T1)),
%	assertz(start(S,T)),
%	!.
%
%do(A,S):-
%	primitive_action(A),
%	poss(A,S),
%	situation(S,A1),
%	append([A|[]],A1,A2),
%	start(S,T1),
%	actionConsequences(A,S),
%	persist(A1,A2,S),
%	time(A,T),
%	retract(start(S,T1)),
%	assertz(start(S,T)).

%do(A,S):-
%	primitive_action(A),
%	poss(A,S),
%%	situation(S,A1),
%	start(S,T1),
%	actionConsequences(A,S),
%%	persist(A1,[A|A1],S),
%	update_current_situation(A),
%	time(A,T),
%	retract(start(S,T1)),
%	assertz(start(S,T)).

%asserts the updated action list
%persist(A1,A2,S):-
%	(
%		retract(situation(S,A1)),!;
%	not(retract(situation(S,A1)))),
%	assertz(situation(S,A2)).

%% As stated by Prof. Dr. Silvio do Lago Pereira, the condition retract(situation(S,A1)) is never false
%% because situation/2 is defined in the initial situation
update_current_situation(A) :-
   retract(situation(s0,As)),
   assertz(situation(s0,[A|As])).

%previous(PA,T,[PA|T]).
%prevAction(PB,A,L):-
%	member(A,L),
%	previous(PA,TA,L),
%	(	PA=A,
%		previous(PB,_,TA), !;
%		prevAction(PB,A,TA), !
%	 ), !;
%	 not(L=[]),
%	 not(member(A,L)),
%	 previous(PB,_,L), !.

%% A more elegant approach by Prof. Dr. Silvio do Lago Pereira to find the previous action in a given situation
prevAction(PreviousAction,Action,ActionList):-
	(   var(Action)
	->  [PreviousAction|_] = ActionList
	;   append(_,[Action,PreviousAction|_],ActionList) ).

