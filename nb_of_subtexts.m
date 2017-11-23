function nb = nb_of_subtexts(A,thr)
global docset;
global docid;
dens = 10; %laten afhangen van het aantal blokken die A omvatten
%[result,result2] = densityline(A,dens);
%result = densitycloudinline(A,dens);
result = densitycloud(A,dens);
%h = figure;
%spy(result);
%saveas(h,['figures/',docset,'_',num2str(docid),'_A'],'fig');
%saveas(h,['figures/',docset,'_',num2str(docid),'_A'],'eps');
%close(h);
%result = diagonaldensity(A,dens);
%surfl(result);
row = diag(result)';
%row2 = diag(result2)';
reduced = row - thr;
reduced = removenegative(reduced);
cells = partsofgraph(reduced); %het aantal cells duidt aan hoeveel subtexts er zijn.
%%%TODO afhankelijk van de waarde van de max, kan er een kans voor elk
%%%aantal bepaald worden
nb = size(cells,2);


function row = removenegative(row)

for i=1:size(row,2)
   if (row(i) < 0)
       row(i) = 0;
   end
end


function cells = partsofgraph(row)
cells = {};
index = 1;
startpos = 1;
for i=1:size(row,2)
   if (row(i) == 0)
       if (startpos == i)
           startpos = startpos + 1;
           continue;
       end
       cells{index} = row(startpos:i-1);
       startpos = i+1;
       index = index + 1;
   end
end
if (startpos ~= i)
    cells{index} = row(startpos:i);
end







