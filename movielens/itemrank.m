F = readtable("udata.txt");
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
%% plot of G
glt = plot(G)
glt.NodeColor = 'g';
highlight(glt, 1:sz ,'NodeColor','r')
%%
Gs = subgraph(G,[1:20,sz+10:sz+20]);
plot(Gs)
%%
Gs2 = subgraph(G,[1:400,sz+10:sz+100]);
glt2 = plot(Gs2)
glt2.NodeColor = 'g';
highlight(glt2, 1:400 ,'NodeColor','r')
%% the projected graph
P = graph(A*transpose(A),'omitselfloops');
%% plot of P
P = graph(A*transpose(A),'omitselfloops');
plt = plot(P)
plt.NodeColor = 'g';
%%
Ps2 = subgraph(P,[1:100,101:200]);
plt2 = plot(Ps2)
plt2.NodeColor = 'g';
%% create personalisation vector
G2=graph(s,t,weights);
v1 = pervec(G2,t,s,1);
%% implement power method
prvec = pwpr(C,n,v1);
%% table of results
X = num2cell(prvec);
format long
Z = table(unique((F.title)), X);
Z = renamevars(Z,"Var1","title");
res = sortrows(Z, 'X', 'descend');
res(1:20,:)
%%
err = sum(abs(C*prvec-prvec));