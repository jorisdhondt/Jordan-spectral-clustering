function result = diagonaldensity(A,ra)
result = zeros(size(A));
for i=1:size(A,1)
      result(i,i) = densityAt(i,i,A,ra);  
end
%result = norm_sparserows(result);

function dens = densityAt(x,y,A,ra)
%sum over neighbours in het square rond (i,j)
[X,Y] = plusform(x,y,ra,size(A,1));
%%%%FILTER de slechte coordinaten
% X>=1 X<= size && Y >= 1 Y <= size
dens = 0;
for i=1:size(X,2)
    if (A(X(i),Y(i)) == 1)
       dist = pdist([x,y;X(i),Y(i)],'cityblock');
       dens = dens + exp(-(dist^2)/((ra/2)^2));
    end
end
%dens = dens/size(X,2);

function [X,Y] = plusform(x,y,ra,maxS)
%returns all point in the plus in range of the manhattandistance
%ra around the point (i,j), without point (i,j) !
X = [];
Y = [];
%ra = 3;
for i=1:ra
    X = [X x+i];
    Y = [Y y];
    X = [X x-i];
    Y = [Y y];
    X = [X x];
    Y = [Y y-i];
    X = [X x];
    Y = [Y y+i];
end
[X,Y] = filter(X,Y,maxS);

function [A,B] = filter(X,Y,maxS)
A = [];
B = [];
for i=1:size(X,2)
   if (((X(i)>0) && (X(i) <=maxS)) && (Y(i)>0 && Y(i)<=maxS))  
        A = [A X(i)];
        B = [B Y(i)];
   end
end
