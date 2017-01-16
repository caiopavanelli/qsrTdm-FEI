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

:- module(pstinitFluentsTest,[
		pstinitFluents/1
	]).
	
pstinitFluents(assertz(situation(s0,[]))).
pstinitFluents(assertz(start(s0, 0))).
pstinitFluents(assertz(location(cpto, loc(0,8), s0))).
pstinitFluents(assertz(location(bodyA, loc(-7,2), s0))).
pstinitFluents(assertz(location(bodyB, loc(5,1), s0))).
pstinitFluents(assertz(facing(180, loc(0,8), s0))).
pstinitFluents(assertz(fieldView(120))).
pstinitFluents(assertz(limitBoundary(15))).
pstinitFluents(assertz(radius(bodyA,1))).
pstinitFluents(assertz(radius(bodyB,1))).
pstinitFluents(assertz(radius(cpto,0))). 

 %% Introduction of thresholdBoundary. A small value needed for
 %% differentiating extending from appearing and vanishing from
 %% shrinking, as pointed in Paulo E. Santos, "REASONING ABOUT DEPTH AND MOTION FROM AN OBSERVER�S VIEWPOINT", SSC07
pstinitFluents(assertz(thresholdBoundary(16))).

 %% Introduction of thresholdUnion. A small value needed for differentiating
 %% approaching to coalescing and receding from splitting
pstinitFluents(assertz(thresholdUnion(15))).

%% threshold to differentiate coalescing from hiding
pstinitFluents(assertz(thresholdHiding(5))).