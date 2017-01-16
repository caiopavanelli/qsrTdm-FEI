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

:- module(pstinitStress1000,[
		pstinitStress1000/1
	]).
	
pstinitStress1000(assertz(situation(s0,[]))).
pstinitStress1000(assertz(start(s0, 0))).
pstinitStress1000(assertz(location(cpto, loc(8.52,6.35), s0))).
pstinitStress1000(assertz(location(bodyA, loc(-7,2), s0))).
pstinitStress1000(assertz(location(bodyB, loc(5,1), s0))).
pstinitStress1000(assertz(facing(180, loc(8.52,6.35), s0))).
pstinitStress1000(assertz(fieldView(120))).
pstinitStress1000(assertz(limitBoundary(15))).
pstinitStress1000(assertz(radius(bodyA,1))).
pstinitStress1000(assertz(radius(bodyB,1))).
pstinitStress1000(assertz(radius(cpto,0))). 

 %% Introduction of thresholdBoundary. A small value needed for
 %% differentiating extending from appearing and vanishing from
 %% shrinking, as pointed in Paulo E. Santos, "REASONING ABOUT DEPTH AND MOTION FROM AN OBSERVER�S VIEWPOINT", SSC07
pstinitStress1000(assertz(thresholdBoundary(16))).

 %% Introduction of thresholdUnion. A small value needed for differentiating
 %% approaching to coalescing and receding from splitting
pstinitStress1000(assertz(thresholdUnion(15))).

%% threshold to differentiate coalescing from hiding
pstinitStress1000(assertz(thresholdHiding(5))).