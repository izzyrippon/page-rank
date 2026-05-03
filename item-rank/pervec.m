function [v1] = pervec(G2,t,s,m) 
tz = numel(unique(t));
sz = numel(unique(s));
us = unique(s);
k = find(us==m);
A2=adjacency(G2,"weighted");
A2=A2(sz+1:end,1:sz);
user1 = A2(:,k);
v1 = user1 / sum(user1);