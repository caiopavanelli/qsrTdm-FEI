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

:- module(pstinitpairs,[
		pstinitpairs/1
	]).
	
pstinitpairs(assertz(situation(s0,[]))).
pstinitpairs(assertz(start(s0, 0))).
pstinitpairs(assertz(location(cpto, loc(5,-4), s0))).
pstinitpairs(assertz(location(bodyA, loc(-7,2), s0))).
pstinitpairs(assertz(location(bodyB, loc(5,1), s0))).
pstinitpairs(assertz(facing(90, loc(5,-4), s0))).
pstinitpairs(assertz(fieldView(120))).
pstinitpairs(assertz(limitBoundary(15))).
pstinitpairs(assertz(radius(bodyA,1))).
pstinitpairs(assertz(radius(bodyB,1))).
pstinitpairs(assertz(radius(cpto,0))). 

 %% Introduction of thresholdBoundary. A small value needed for
 %% differentiating extending from appearing and vanishing from
 %% shrinking, as pointed in Paulo E. Santos, "REASONING ABOUT DEPTH AND MOTION FROM AN OBSERVER�S VIEWPOINT", SSC07
pstinitpairs(assertz(thresholdBoundary(16))).

 %% Introduction of thresholdUnion. A small value needed for differentiating
 %% approaching to coalescing and receding from splitting
pstinitpairs(assertz(thresholdUnion(15))).

%% threshold to differentiate coalescing from hiding
pstinitpairs(assertz(thresholdHiding(5))).

%pstinitpairs(do(startMove(cpto, loc(5,-4), loc(6,-4), 1), s0)).
%pstinitpairs(do(endMove(cpto, loc(5,-4), loc(6,-4), 1), s0)).
%pstinitpairs(do(startMove(cpto, loc(6,-4), loc(5,-4), 1), s0)).
%pstinitpairs(assertz(do(endMove(cpto, loc(6,-4), loc(5,-4), 1), 
%						do(startMove(cpto, loc(6,-4), loc(5,-4), 1), 
%							do(endMove(cpto, loc(5,-4), loc(6,-4), 1), 
%								do(startMove(cpto, loc(5,-4), loc(6,-4), 1), s0))), _S0))).