# qsrTdm-FEI
Prolog implementation of a qualitative spatial reasoning theory based on the perception of depth and motion. It was developed during a Master's degree program at Centro Universitário da FEI - São Bernardo do Campo / SP - Brazil - 2016.

This project is composed of mutiple modules:

-- The entry point is the file "axiomsTDM.pl". It will load everything else;

-- Files "initTestSingle.pl" and "initTestPairs.pl" have data which represents the initial situation for the test environment;

-- File "tdmTestMovement.pl" corresponds to the first test in which fluents size, depth and dist are before and after movement actions;
  > After consulting file "axiomsTDM.pl", call "test_movement." to execute the test.

-- File "tdmTestSinglePeak.pl" corresponds to the second test in which fluents for transitions in single peaks are tested over actions;
  > After consulting file "axiomsTDM.pl", call "test_single_peak." to execute the test.
  
-- File "tdmTestPairOfPeaks.pl" corresponds to the third test in which fluents for transitions in pairs of peaks are tested over actions;
  > After consulting file "axiomsTDM.pl", call "test_pair_of_peaks." to execute the test.
  
After each test the Prolog environment should be reset and the entry point should be reconsulted.

The project was developed using PDT for Eclipse. You can reach more info in https://sewiki.iai.uni-bonn.de/research/pdt/docs/start.
