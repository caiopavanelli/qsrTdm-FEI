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

pstactionpairs(
[	startMove(cpto, loc(5,-4), loc(6,-4), 22),
	endMove(cpto, loc(5,-4), loc(6,-4), 22),
	startMove(cpto, loc(6,-4), loc(7,-4), 23),
	endMove(cpto, loc(6,-4), loc(7,-4), 23),
	startMove(cpto, loc(7,-4), loc(7,-3), 24),
	endMove(cpto, loc(7,-4), loc(7,-3), 24),
	startPan(-15, 24),
	endPan(-15, 24),
	startMove(cpto, loc(7,-3), loc(8,-3), 25),
	endMove(cpto, loc(7,-3), loc(8,-3), 25),
	startPan(-5, 25),
	endPan(-5, 25),
	startMove(cpto, loc(8,-3), loc(9,-3), 26),
	endMove(cpto, loc(8,-3), loc(9,-3), 26),
	startPan(-5, 26),
	endPan(-5, 26),
	startMove(cpto, loc(9,-3), loc(10,-3), 27),
	endMove(cpto, loc(9,-3), loc(10,-3), 27),
	startPan(-5, 27),
	endPan(-5, 27),
	startMove(cpto, loc(10,-3), loc(10,-2), 28),
	endMove(cpto, loc(10,-3), loc(10,-2), 28),
	startPan(-5, 28),
	endPan(-5, 28),
	startMove(cpto, loc(10,-2), loc(10,-1), 29),
	endMove(cpto, loc(10,-2), loc(10,-1), 29),
	startMove(cpto, loc(10,-1), loc(11,-1), 30),
	endMove(cpto, loc(10,-1), loc(11,-1), 30),
	startPan(-10, 30),
	endPan(-10, 30),
	startMove(cpto, loc(11,-1), loc(11,0), 31),
	endMove(cpto, loc(11,-1), loc(11,0), 31),
	startMove(cpto, loc(11,0), loc(11,1), 32),
	endMove(cpto, loc(11,0), loc(11,1), 32),
	startMove(cpto, loc(11,1), loc(11,2), 33),
	endMove(cpto, loc(11,1), loc(11,2), 33),
	startMove(cpto, loc(11,2), loc(10,2), 34),
	endMove(cpto, loc(11,2), loc(10,2), 34),
	startMove(cpto, loc(10,2), loc(10,3), 35),
	endMove(cpto, loc(10,2), loc(10,3), 35),
	startPan(-5, 35),
	endPan(-5, 35),
	startMove(cpto, loc(10,3), loc(10,4), 36),
	endMove(cpto, loc(10,3), loc(10,4), 36),
	startMove(cpto, loc(10,4), loc(9,4), 37),
	endMove(cpto, loc(10,4), loc(9,4), 37),
	startPan(-10, 37),
	endPan(-10, 37),
	startMove(cpto, loc(9,4), loc(9,5), 38),
	endMove(cpto, loc(9,4), loc(9,5), 38),
	startMove(cpto, loc(9,5), loc(8,5), 39),
	endMove(cpto, loc(9,5), loc(8,5), 39),
	startMove(cpto, loc(8,5), loc(7,5), 40),
	endMove(cpto, loc(8,5), loc(7,5), 40),
	startPan(-10, 40),
	endPan(-10, 40),
	startMove(cpto, loc(7,5), loc(7,6), 41),
	endMove(cpto, loc(7,5), loc(7,6), 41),
	startMove(cpto, loc(7,6), loc(6,6), 42),
	endMove(cpto, loc(7,6), loc(6,6), 42),
	startPan(-5, 42),
	endPan(-5, 42),
	startMove(cpto, loc(6,6), loc(5,6), 43),
	endMove(cpto, loc(6,6), loc(5,6), 43)
	]).

pstpstquerypairsAttribute(X,Y, depth(pk(bodyA, Depth, _, _), Depth, loc(X,Y), S0),S0).
pstpstquerypairsAttribute(X,Y, size(pk(bodyA, _, Size, _), Size, loc(X,Y), S0),S0).
pstpstquerypairsAttribute(X,Y, dist(pk(bodyA, _, _, Dist), Dist, loc(X,Y), S0),S0).
pstpstquerypairsAttribute(X,Y, depth(pk(bodyB, Depth, _, _), Depth, loc(X,Y), S0),S0).
pstpstquerypairsAttribute(X,Y, size(pk(bodyB, _, Size, _), Size, loc(X,Y), S0),S0).
pstpstquerypairsAttribute(X,Y, dist(pk(bodyB, _, _, Dist), Dist, loc(X,Y), S0),S0).
pstpstquerypairsAttribute(X,Y, dist(pk(bodyA, _, _, _DistA), pk(bodyB, _, _, _DistB), _Dist, loc(X,Y), S0),S0).

pstquerypairs(X,Y, approaching(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), S0),S0).
pstquerypairs(X,Y, coalescing(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), S0),S0).
pstquerypairs(X,Y, hiding(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), S0),S0).
pstquerypairs(X,Y, splitting(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), S0),S0).
pstquerypairs(X,Y, receding(pk(bodyA,_DepthA,_SizeA,_DistanceA), pk(bodyB,_DepthB,_SizeB,_DistanceB), loc(X, Y), S0),S0).
pstquerypairs(X,Y, two_peak_static(pk(bodyA, _DepthA, _SizeA, _DistanceA), pk(bodyB, _DepthB, _SizeB, _DistanceB), loc(X, Y), S0),S0).
   
test_pair_of_peaks_pst :-
	working_directory(_, 'C:/qsrTdm-FEI'),
	forall(pstinitpairs(INIT),INIT),
	do(endMove(cpto, loc(6,-4), loc(5,-4), 1), 
		do(startMove(cpto, loc(6,-4), loc(5,-4), 1), 
			do(endMove(cpto, loc(5,-4), loc(6,-4), 1), 
				do(startMove(cpto, loc(5,-4), loc(6,-4), 1), s0))), S0),
	pstactionpairs(Actions),
	act(Actions, S0,'test_pair_of_peaks_pst.txt').
		    
