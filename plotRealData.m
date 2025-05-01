load('/Users/chenshumeng/Desktop/code/MATLABFunction/MATLABCode_Chen/EmGm/results.mat', 'results');
load('/Users/chenshumeng/Desktop/code/MATLABFunction/MATLABCode_Chen/EmGm/results_sv.mat', 'results_sv');

fieldName='K151'
UpdateperSeq=2

RealDataFRT(results, results_sv,fieldName,UpdateperSeq)


