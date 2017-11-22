function [idx,k] = normJordanspectralclustering(A,varargin)
if (nargin < 1 || nargin > 2)
    error 'incorrect nb of arguments! normJordanspectralclustering(matrix,<optional> nb of clusters';
end
[V,D] = eig(A);
%n = size(V,2);
if (varargin{1} < 1)
   k = nb_of_subtexts(A,varargin{1});
else
   k = varargin{1};
end
U = V(:,1:k);
for i=1:size(U,1)
    U(i,:) = U(i,:)/norm(U(i,:));
end
idx = kmeans(U,k);
