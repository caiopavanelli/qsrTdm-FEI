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

:- module(initpairs,[
		initpairs/1
	]).
	
initpairs(assertz(situation(s0,[]))).
initpairs(assertz(start(s0, 0))).
initpairs(assertz(location(cpto, loc(5,-4), s0))).
initpairs(assertz(location(bodyA, loc(-7,2), s0))).
initpairs(assertz(location(bodyB, loc(5,1), s0))).
initpairs(assertz(facing(90, loc(5,-4), s0))).
initpairs(assertz(fieldView(120))).
initpairs(assertz(limitBoundary(15))).
initpairs(assertz(radius(bodyA,1))).
initpairs(assertz(radius(bodyB,1))).
initpairs(assertz(radius(cpto,0))). 

 %% Introduction of thresholdBoundary. A small value needed for
 %% differentiating extending from appearing and vanishing from
 %% shrinking, as pointed in Paulo E. Santos, "REASONING ABOUT DEPTH AND MOTION FROM AN OBSERVER�S VIEWPOINT", SSC07
initpairs(assertz(thresholdBoundary(16))).

 %% Introduction of thresholdUnion. A small value needed for differentiating
 %% approaching to coalescing and receding from splitting
initpairs(assertz(thresholdUnion(10))).

initpairs(do(startMove(cpto, loc(5,-4), loc(6,-4), 1), s0)).
initpairs(do(endMove(cpto, loc(5,-4), loc(6,-4), 1), s0)).
initpairs(do(startMove(cpto, loc(6,-4), loc(5,-4), 1), s0)).
initpairs(do(endMove(cpto, loc(6,-4), loc(5,-4), 1), s0)).