s=[1 2 2 3 3 4 4 4 5];
t=[2 3 6 2 4 3 5 6 6];
G = digraph(s,t);
G.Edges.Weight = [0.9 0.8 0.1 0.3 0.7 0.6 0.2 0.4 0.5]';
n=6;
A = adjacency(G,'weighted'); %adjacency matrix
At = transpose(A);
c=full(sum(At));
k= find(c~=0);
D=sparse(k,k,1./c(k),n,n); %diagonal matrix
Ht = At * D; 
e = ones(n,1);
et = ones(1,n);
at = et - sum(Ht);

x1=ones(n,1);
x2=zeros(n,1);
epsilon = 0.00000001;
alp = 0.85;
error = sum(abs(x1-x2));

v=[1 1 5 1 1 1];
v= transpose(v);
v = v/sum(v);
while error > epsilon
    x2= v*et*x1+ alp*(1/n*e*at+Ht-v*et)*x1 ;
    x2=x2/sum(x2); %normalisation
    error = sum(abs(x1-x2));
    x1=x2;
end    
x1