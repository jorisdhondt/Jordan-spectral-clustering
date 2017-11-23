function [result,result2] = densityline(A,ra)
result = zeros(size(A));
result2 = zeros(size(A));
for i=1:size(A,1)
  result(i,i) = densityAt(i,i,A,ra);  
end

for i=1:size(A,1)
  result2(i,i) = densityAt2(i,i,A,ra);  
end

function dens = densityAt(x,y,A,ra)
%sum over neighbours in het square rond (i,j)
[X,Y] = line(x,y,ra,size(A,1));
%%%%FILTER de slechte coordinaten
% X>=1 X<= size && Y >= 1 Y <= size
dens = 0;
for i=1:size(X,2)
    if (A(X(i),Y(i)) == 1)
       dist = pdist([x,y;X(i),Y(i)],'cityblock');
       dens = dens + exp(-(dist^2)/((ra/2)^2));
    end
end

function [X,Y] = line(x,y,r,maxr)
X = [];
Y = [];
for i=x+1:x+r
    if (i > maxr)
        return
    end
    X = [X i];
    Y = [Y y];
end

function dens = densityAt2(x,y,A,ra)
%sum over neighbours in het square rond (i,j)
[X,Y] = line2(x,y,ra);
%%%%FILTER de slechte coordinaten
% X>=1 X<= size && Y >= 1 Y <= size
dens = 0;
for i=1:size(X,2)
    if (A(X(i),Y(i)) == 1)
       dist = pdist([x,y;X(i),Y(i)],'cityblock');
       dens = dens + exp(-(dist^2)/((ra/2)^2));
    end
end    

function [X,Y] = line2(x,y,r)
X = [];
Y = [];
for i=x-1:-1:x-r
    if (i <= 0)
        return
    end
    X = [X i];
    Y = [Y y];
end