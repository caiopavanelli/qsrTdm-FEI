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

actionmove(poss(startMove(cpto, loc(-13,-2), loc(-12,-2), 1), s0)).
actionmove(poss(startPan(-15, 1), s0)).
actionmove(location(cpto, _Location, s0)).
actionmove(facing(_Theta,loc(-13,-2),s0)).
actionmove(visible(loc(-13,-2), bodyA, 120, 90, s0)).
actionmove(size(pk(bodyA, _, Size, _), Size, loc(-13,-2), s0)).
actionmove(depth(pk(bodyA, Depth, _, _), Depth, loc(-13,-2), s0)).
actionmove(dist(pk(bodyA , _, _, Distance ), Distance, loc(-13,-2), s0)).
actionmove(do(startMove(cpto, loc(-13,-2), loc(-12,-2), 1), s0)).
actionmove(do(startPan(-15, 1), s0)).
actionmove(moving(cpto, loc(-13,-2), loc(-12,-2), s0)).
actionmove(rotating(-15,s0)).
actionmove(do(endMove(cpto, loc(-13,-2), loc(-12,-2), 1), s0)).
actionmove(do(endPan(-15, 1), s0)).
actionmove(moving(cpto, loc(-13,-2), loc(-12,-2), s0)).
actionmove(rotating(-15,s0)).
actionmove(location(cpto, _Location, s0)).
actionmove(facing(_Theta,loc(-12,-2),s0)).
actionmove(visible(loc(-12,-2), bodyA, 120, 75, s0)).
actionmove(size(pk(bodyA, _, Size, _), Size, loc(-12,-2), s0)).
actionmove(depth(pk(bodyA, Depth, _, _), Depth, loc(-12,-2), s0)).
actionmove(dist(pk(bodyA , _, _, Distance ), Distance, loc(-12,-2), s0)).

:- use_module(initTestSingle).

test_movement :-
	forall(initsingle(INIT),INIT),
	forall(actionmove(DO), (DO -> writeln(true:DO) ; writeln(false:DO))).