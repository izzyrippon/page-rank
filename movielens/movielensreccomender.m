F = readtable("ratings.csv");
f = readtable("movies.csv");
V = readtable("movietitles.xlsx");
%% 
F = innerjoin(f,F);
v1 = V.User1;
v2 = V.User2;
Deleteif = F.movieId <= 2.0363e+05;
F(Deleteif,:) = [];
%%
writetable(F,'recdata.csv','Delimiter',',','QuoteStrings','all');
type 'recdata.csv'
%%
s=categorical(F.userId);
t=categorical(F.movieId);
weights=F.rating;
G = graph(s,t,weights);
%%
A=adjacency(G);
tz = numel(unique(t));
sz = numel(unique(s));
n=tz;
%%
A=A(sz+1:sz+tz,1:sz);
pa = A*transpose(A);
pa = pa - diag(pa);
e = ones(n,1);
P = graph(A*transpose(A),'omitselfloops');
%%
prvec = pwpr(pa,n,user1);
%%
X = num2cell(prvec);
format long
Z = table(unique((F.movieId)), X);
Z = renamevars(Z,"Var1","movieId");
%%
T = join(Z, f(:,["movieId", "title","genres"]));
res = sortrows(T, 'X', 'descend');
res(1:20,:)
%%
User = cellfun(@(c) contains(c, {'Mystery'}),T.genres);
user1 = User + 2.5;