% [A, W, P] = readSparseFloatMatrix(baseFileName)
%
% following files must exist:
%   baseFileName+"_rowIDs.bin"
%   baseFileName+"_colIDs.bin"
%   baseFileName+"_vals.bin"
%
% A is doc-by-term or term-by-doc, depending on what's in rowNbrs.bin and
% colNbrs.bin // the values are weighted with external scheme

function [A, W] = readSparseDoubleMatrix (baseFileName)

W = [];

fid1 = fopen(sprintf('%s%s',baseFileName,'_rowNbrs.bin')); %contains repeated entries consecutive row numbers (1..maxRowNbr), repeated as many times as there are nonzero values on the row
Z1 = fread(fid1,'int32');
W = [W Z1];
fclose(fid1);
disp('rowNbrs ingelezen.');

fid2 = fopen(sprintf('%s%s',baseFileName,'_colNbrs.bin')); %contains col nrs with nonzero values for each consecutive row
Z2=fread(fid2,'int32');
W= [W Z2];
fclose(fid2);
disp('colNbrs ingelezen.');

fid3 = fopen(sprintf('%s%s',baseFileName,'_vals.bin')); %contains values //external (the normal) scheme
%Z3=fread(fid3,'float');
W= [W fread(fid3,'float')];
fclose(fid3);
disp('Sparse matrix ingelezen')
A = spconvert(W);
[M,N] = size(A);

%fid4 = fopen(sprintf('%s%s',baseFileName,'_extra_vals.bin')); %contains
%values //internal scheme (for hypergraph clustering)
disp(strcat('Aantal rijen:',num2str(M)))
disp(strcat('Aantal kolommen:',num2str(N)))