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

:- module(initFluentsTest,[
		initFluents/1
	]).
	
initFluents(assertz(situation(s0,[]))).
initFluents(assertz(start(s0, 0))).
initFluents(assertz(location(cpto, loc(0.0,8.0), s0))).
initFluents(assertz(location(bodyA, loc(-7,2), s0))).
initFluents(assertz(location(bodyB, loc(5,1), s0))).
initFluents(assertz(facing(180, loc(0.0,8.0), s0))).
initFluents(assertz(fieldView(120))).
initFluents(assertz(limitBoundary(15))).
initFluents(assertz(radius(bodyA,1))).
initFluents(assertz(radius(bodyB,1))).
initFluents(assertz(radius(cpto,0))). 

 %% Introduction of thresholdBoundary. A small value needed for
 %% differentiating extending from appearing and vanishing from
 %% shrinking, as pointed in Paulo E. Santos, "REASONING ABOUT DEPTH AND MOTION FROM AN OBSERVER�S VIEWPOINT", SSC07
initFluents(assertz(thresholdBoundary(16))).

 %% Introduction of thresholdUnion. A small value needed for differentiating
 %% approaching to coalescing and receding from splitting
initFluents(assertz(thresholdUnion(15))).

%% threshold to differentiate coalescing from hiding
initFluents(assertz(thresholdHiding(5))).

initFluents(do(startMove(cpto, loc(0.0,8.0), loc(0.1,8.1), 1), s0)).
initFluents(do(endMove(cpto, loc(0.0,8.0), loc(0.1,8.1), 1), s0)).
initFluents(do(startMove(cpto, loc(0.1,8.1), loc(0.0,8.0), 1), s0)).
initFluents(do(endMove(cpto, loc(0.1,8.1), loc(0.0,8.0), 1), s0)).
		 
			
				