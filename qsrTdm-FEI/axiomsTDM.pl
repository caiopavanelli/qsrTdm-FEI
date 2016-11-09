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

:-dynamic situation/2,
			fieldView/1,
			limitBoundary/1,
			sensedProfile/1,
			thresholdBoundary/1.

:- ['axioms/general/load'].
:- ['axioms/primitiveActions/load'].
:- ['axioms/precondition/load'].
:- ['axioms/fluents/load'].

%% fake data for processing sense action without an actual sensor
%% sensed data represents a body perceived at distance 4, size 3 and angular distance 60
%% \     3     /
%%  \ 60 O    /
%%   \   |   /
%%    \  |4 /
%%     \ | /
%%      \|/
%%       R
sensedProfile([pk(bodyA, 4, 3, 60)]).

writeln(T) :- write(T), nl. 

:- use_module(initTestSingle).
:- use_module(initTestPairs).

:- include(tdmTestMovement).
:- include(tdmTestSinglePeak).
:- include(tdmTestPairOfPeaks).

