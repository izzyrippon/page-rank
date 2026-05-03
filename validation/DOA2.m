function [DOAi] = DOA2(A2,F2,Z,b)
     byuser = A2(:,b);
     bu = byuser == 1;
     wmovies = F2(bu,:);
     wmovies1 = array2table(unique(wmovies.title));
     wmovies1 = renamevars(wmovies1,"Var1","title");
     unwmovies =  F2(~bu,:);
     unwmovies1 = array2table(unique(unwmovies.title));
     unwmovies1 = renamevars(unwmovies1,"Var1","title");
     wmovies = innerjoin(Z,wmovies1,'Keys','title');
     unwmovies = innerjoin(Z,unwmovies1,'Keys','title');
     k =0; 
     for i = 1: numel ( wmovies . X )
         for j = 1: numel ( unwmovies . X )
             k = k + ( wmovies . X {i ,:} >= unwmovies . X {j ,:}) ;
         end
     end
     DOAi = k/(numel(wmovies.X)*numel(unwmovies.X));