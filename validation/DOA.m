function [DOAi] = DOA(A,prvec,b)
     byuser = A(b,:);
     bu = byuser == 1;
     rbu = prvec(bu,:);
     nrbu = prvec(~bu,:);
     modl = numel(rbu);
     modnw = numel(nrbu);
     k = 0;
     for i = 1:numel(rbu)
         for j = 1:numel(nrbu)
             k = k + (rbu(i)>=nrbu(j));
         end
     end    
     DOAi = k/(modl*modnw);