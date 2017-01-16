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

actionpairs(do(startMove(cpto, loc(5,-4), loc(6,-4), 22), s0)).
actionpairs(do(endMove(cpto, loc(5,-4), loc(6,-4), 22), s0)).
actionpairs(do(startMove(cpto, loc(6,-4), loc(7,-4), 23), s0)).
actionpairs(do(endMove(cpto, loc(6,-4), loc(7,-4), 23), s0)).
actionpairs(do(startMove(cpto, loc(7,-4), loc(7,-3), 24), s0)).
actionpairs(do(endMove(cpto, loc(7,-4), loc(7,-3), 24), s0)).
actionpairs(do(startPan(-15, 24), s0)).
actionpairs(do(endPan(-15, 24), s0)).
actionpairs(do(startMove(cpto, loc(7,-3), loc(8,-3), 25), s0)).
actionpairs(do(endMove(cpto, loc(7,-3), loc(8,-3), 25), s0)).
actionpairs(do(startPan(-5, 25), s0)).
actionpairs(do(endPan(-5, 25), s0)).
actionpairs(do(startMove(cpto, loc(8,-3), loc(9,-3), 26), s0)).
actionpairs(do(endMove(cpto, loc(8,-3), loc(9,-3), 26), s0)).
actionpairs(do(startPan(-5, 26), s0)).
actionpairs(do(endPan(-5, 26), s0)).
actionpairs(do(startMove(cpto, loc(9,-3), loc(10,-3), 27), s0)).
actionpairs(do(endMove(cpto, loc(9,-3), loc(10,-3), 27), s0)).
actionpairs(do(startPan(-5, 27), s0)).
actionpairs(do(endPan(-5, 27), s0)).
actionpairs(do(startMove(cpto, loc(10,-3), loc(10,-2), 28), s0)).
actionpairs(do(endMove(cpto, loc(10,-3), loc(10,-2), 28), s0)).
actionpairs(do(startPan(-5, 28), s0)).
actionpairs(do(endPan(-5, 28), s0)).
actionpairs(do(startMove(cpto, loc(10,-2), loc(10,-1), 29), s0)).
actionpairs(do(endMove(cpto, loc(10,-2), loc(10,-1), 29), s0)).
actionpairs(do(startMove(cpto, loc(10,-1), loc(11,-1), 30), s0)).
actionpairs(do(endMove(cpto, loc(10,-1), loc(11,-1), 30), s0)).
actionpairs(do(startPan(-10, 30), s0)).
actionpairs(do(endPan(-10, 30), s0)).
actionpairs(do(startMove(cpto, loc(11,-1), loc(11,0), 31), s0)).
actionpairs(do(endMove(cpto, loc(11,-1), loc(11,0), 31), s0)).
actionpairs(do(startMove(cpto, loc(11,0), loc(11,1), 32), s0)).
actionpairs(do(endMove(cpto, loc(11,0), loc(11,1), 32), s0)).
actionpairs(do(startMove(cpto, loc(11,1), loc(11,2), 33), s0)).
actionpairs(do(endMove(cpto, loc(11,1), loc(11,2), 33), s0)).
actionpairs(do(startMove(cpto, loc(11,2), loc(10,2), 34), s0)).
actionpairs(do(endMove(cpto, loc(11,2), loc(10,2), 34), s0)).
actionpairs(do(startMove(cpto, loc(10,2), loc(10,3), 35), s0)).
actionpairs(do(endMove(cpto, loc(10,2), loc(10,3), 35), s0)).
actionpairs(do(startPan(-5, 35), s0)).
actionpairs(do(endPan(-5, 35), s0)).
actionpairs(do(startMove(cpto, loc(10,3), loc(10,4), 36), s0)).
actionpairs(do(endMove(cpto, loc(10,3), loc(10,4), 36), s0)).
actionpairs(do(startMove(cpto, loc(10,4), loc(9,4), 37), s0)).
actionpairs(do(endMove(cpto, loc(10,4), loc(9,4), 37), s0)).
actionpairs(do(startPan(-10, 37), s0)).
actionpairs(do(endPan(-10, 37), s0)).
actionpairs(do(startMove(cpto, loc(9,4), loc(9,5), 38), s0)).
actionpairs(do(endMove(cpto, loc(9,4), loc(9,5), 38), s0)).
actionpairs(do(startMove(cpto, loc(9,5), loc(8,5), 39), s0)).
actionpairs(do(endMove(cpto, loc(9,5), loc(8,5), 39), s0)).
actionpairs(do(startMove(cpto, loc(8,5), loc(7,5), 40), s0)).
actionpairs(do(endMove(cpto, loc(8,5), loc(7,5), 40), s0)).
actionpairs(do(startPan(-10, 40), s0)).
actionpairs(do(endPan(-10, 40), s0)).
actionpairs(do(startMove(cpto, loc(7,5), loc(7,6), 41), s0)).
actionpairs(do(endMove(cpto, loc(7,5), loc(7,6), 41), s0)).
actionpairs(do(startMove(cpto, loc(7,6), loc(6,6), 42), s0)).
actionpairs(do(endMove(cpto, loc(7,6), loc(6,6), 42), s0)).
actionpairs(do(startPan(-5, 42), s0)).
actionpairs(do(endPan(-5, 42), s0)).
actionpairs(do(startMove(cpto, loc(6,6), loc(5,6), 43), s0)).
actionpairs(do(endMove(cpto, loc(6,6), loc(5,6), 43), s0)).
   
test_pair_of_peaks :-
	working_directory(_, 'C:/qsrTdm-FEI'),
	forall(initpairs(INIT),INIT),
	forall(actionpairs(DO), 
		    (	DO,
		    	writeln(DO,'test_pair_of_peaks.txt'),
		    	location(cpto, loc(X,Y), s0),
		    	forall(querypairsAttribute(X,Y,AT), (call_time(AT, Ta), writeln(Ta:AT,'test_pair_of_peaks.txt'))),
		    	forall(querypairs(X,Y,Q), (Q -> call_time(Q, Ts), writeln(Ts:true:Q,'test_pair_of_peaks.txt') ; call_time(Q, Ts), writeln(Ts:false:Q,'test_pair_of_peaks.txt')))
		    )).
		    
