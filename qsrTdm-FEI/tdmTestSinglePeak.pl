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

actionsingle(do(startMove(cpto,loc(-13,-2),loc(-12,-2),1),s0)).	
actionsingle(do(endMove(cpto,loc(-13,-2),loc(-12,-2),2),s0)).	
actionsingle(do(startMove(cpto,loc(-12,-2),loc(-11,-2),3),s0)).	
actionsingle(do(endMove(cpto,loc(-12,-2),loc(-11,-2),4),s0)).		
actionsingle(do(startMove(cpto,loc(-11,-2),loc(-10,-2),5),s0)).	
actionsingle(do(endMove(cpto,loc(-11,-2),loc(-10,-2),6),s0)).		
actionsingle(do(startMove(cpto,loc(-10,-2),loc(-9,-2),7),s0)).	
actionsingle(do(endMove(cpto,loc(-10,-2),loc(-9,-2),8),s0)).		
actionsingle(do(startMove(cpto,loc(-9,-2),loc(-8,-2),9),s0)).		
actionsingle(do(endMove(cpto,loc(-9,-2),loc(-8,-2),10),s0)).		
actionsingle(do(startMove(cpto,loc(-8,-2),loc(-7,-2),11),s0)).	
actionsingle(do(endMove(cpto,loc(-8,-2),loc(-7,-2),12),s0)).		
actionsingle(do(startMove(cpto,loc(-7,-2),loc(-6,-2),13),s0)).	
actionsingle(do(endMove(cpto,loc(-7,-2),loc(-6,-2),14),s0)).		
actionsingle(do(startPan(1,15),s0)).					
actionsingle(do(endPan(1,16),s0)).						
actionsingle(do(startPan(-1,17),s0)).					
actionsingle(do(endPan(-1,18),s0)).					
actionsingle(do(startMove(cpto,loc(-6,-2),loc(-7,-2),19),s0)).	
actionsingle(do(endMove(cpto,loc(-6,-2),loc(-7,-2),20),s0)).		
actionsingle(do(startMove(cpto,loc(-7,-2),loc(-8,-2),21),s0)).	
actionsingle(do(endMove(cpto,loc(-7,-2),loc(-8,-2),22),s0)).		
actionsingle(do(startMove(cpto,loc(-8,-2),loc(-9,-2),23),s0)).	
actionsingle(do(endMove(cpto,loc(-8,-2),loc(-9,-2),24),s0)).		
actionsingle(do(startMove(cpto,loc(-9,-2),loc(-10,-2),25),s0)).	
actionsingle(do(endMove(cpto,loc(-9,-2),loc(-10,-2),26),s0)).		
actionsingle(do(startMove(cpto,loc(-10,-2),loc(-11,-2),27),s0)).	
actionsingle(do(endMove(cpto,loc(-10,-2),loc(-11,-2),28),s0)).	
actionsingle(do(startMove(cpto,loc(-11,-2),loc(-12,-2),29),s0)).	
actionsingle(do(endMove(cpto,loc(-11,-2),loc(-12,-2),30),s0)).	
actionsingle(do(startMove(cpto,loc(-12,-2),loc(-13,-2),31),s0)).	
actionsingle(do(endMove(cpto,loc(-12,-2),loc(-13,-2),32),s0)).	

querysingle(X,Y, peak_static(pk(bodyB, _Depth, _Size, _Distance), loc(X, Y), s0)).
querysingle(X,Y, appearing(pk(bodyB, _Depth, _Size, _Distance), loc(X, Y), s0)).
querysingle(X,Y, extending(pk(bodyB, _Depth, _Size, _Distance), loc(X, Y), s0)).
querysingle(X,Y, shrinking(pk(bodyB, _Depth, _Size, _Distance), loc(X, Y), s0)).
querysingle(X,Y, vanishing(pk(bodyB, _Depth, _Size, _Distance), loc(X, Y), s0)).

querysingleAtribute(X,Y, depth(pk(bodyB, Depth, _, _), Depth, loc(X,Y), s0)).
querysingleAtribute(X,Y, size(pk(bodyB, _, Size, _), Size, loc(X,Y), s0)).
querysingleAtribute(X,Y, dist(pk(bodyB, _, _, Dist), Dist, loc(X,Y), s0)).

test_single_peak :-
	forall(initsingle(INIT),INIT),
	forall(actionsingle(DO), 
		    (	DO,
		    	writeln(actionsingle:DO),
		    	location(cpto, loc(X,Y), s0),
		    	forall(querysingleAtribute(X,Y,AT), (AT, writeln(AT))),
		    	forall(querysingle(X,Y,Q), (Q -> writeln(true:Q) ; writeln(false:Q)))
		    )).
		    
