load('/Users/chenshumeng/Desktop/code/MATLABFunction/MATLABCode_Chen/EmGm/FilteredSimOutput.mat', 'FilteredSimOutput');
load('/Users/chenshumeng/Desktop/code/MATLABFunction/MATLABCode_Chen/EmGm/SummaryNaive.mat', 'SummaryNaive');

numSimu=200
UpdateperSeq=2
numIter=145   % equals to the row of the resuls

NaiveFRT(numSimu, FilteredSimOutput, SummaryNaive, numIter, UpdateperSeq)


