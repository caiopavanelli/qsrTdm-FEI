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

 %% This file contains actions to validate the experiment proposed on EJCAI08

 /****************************************************************
 * - Initial Situation assertion
 ****************************************************************/

:- module(initsingle,[
		initsingle/1
	]).

initsingle(assertz(situation(s0,[]))).
initsingle(assertz(start(s0, 0))).
initsingle(assertz(location(cpto, loc(-13,-2), s0))).
initsingle(assertz(location(bodyA, loc(-7,2), s0))).
initsingle(assertz(location(bodyB, loc(5,1), s0))).
initsingle(assertz(facing(90, loc(-13,-2), s0))).
initsingle(assertz(fieldView(120))).
initsingle(assertz(limitBoundary(15))).
initsingle(assertz(radius(bodyA,1))).
initsingle(assertz(radius(bodyB,1))).
initsingle(assertz(radius(cpto,0))).

 %% Introduction of thresholdBoundary. A small value needed for
 %% differentiating extending from appearing and vanishing from
 %% shrinking, as pointed in Paulo E. Santos, "REASONING ABOUT DEPTH AND MOTION FROM AN OBSERVER�S VIEWPOINT", SSC07
initsingle(assertz(thresholdBoundary(16))).

 %% Introduction of thresholdUnion. A small value needed for differentiating
 %% approaching to coalescing and receding from splitting
initsingle(assertz(thresholdUnion(10))).

initsingle(do(startMove(cpto, loc(-13,-2), loc(-14,-2), 1), s0)).
initsingle(do(endMove(cpto, loc(-13,-2), loc(-14,-2), 1), s0)).
initsingle(do(startMove(cpto, loc(-14,-2), loc(-13,-2), 1), s0)).
initsingle(do(endMove(cpto, loc(-14,-2), loc(-13,-2), 1), s0)).