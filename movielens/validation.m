F = readtable("u1base.txt");
F = renamevars(F,["Var1","Var2","Var3"],["userId","movieId","rating"]);
f = readtable("uitem.txt");
f = renamevars(f,["Var1","Var2"],["movieId","title"]);
F = innerjoin(f,F,'Keys','movieId');
%% bipartite graph set up
s=categorical(F.userId);
t=categorical(F.title);
weights=F.rating;
G = graph(s,t);
%% projection to movies graph
A=adjacency(G);
tz = numel(unique(t));
sz = numel(unique(s));
n=tz;
A=A(sz+1:sz+tz,1:sz);
at = transpose(A);
pa = A*at;
pa = pa - diag(pa);
C=pa; 
e = ones(n,1);
%% the projected graph
P = graph(A*transpose(A),'omitselfloops');
%% test set 
F2 = readtable("u1test.txt");
F2 = renamevars(F2,["Var1","Var2","Var3"],["userId","movieId","rating"]);
f2 = readtable("uitem.txt");
f2 = renamevars(f2,["Var1","Var2"],["movieId","title"]);
F2 = innerjoin(f2,F2,'Keys','movieId');
%% bipartite graph set up
s2=categorical(F2.userId);
t2=categorical(F2.title);
weights2=F2.rating;
G3 = graph(s2,t2,weights2);
A2=adjacency(G3);
tz2 = numel(unique(t2));
sz2 = numel(unique(s2));
A2=A2(sz2+1:sz2+tz2,1:sz2);
%% personalisation vector set up
G2=graph(s,t,weights);
doa10 = 0;
for i=[1:10]
    v1 = pervec(G2,t,s,i);
    %% implement power method
    prvec = pwpr(C,n,v1);
    %% table of results
    X = num2cell(prvec);
    format long
    Z = table(unique((F.title)), X);
    Z = renamevars(Z,"Var1","title");
    %%
   doa10 = doa10 + DOA2(A2,F2,Z,i);
end
doa10/10