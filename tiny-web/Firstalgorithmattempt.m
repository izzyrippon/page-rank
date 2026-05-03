s=[1 2 2 3 3 4 4 4 5];
t=[2 3 6 2 4 3 5 6 6];
n=6;
A = sparse(s,t,1,n,n); %adjacency matrix
At = sparse(t,s,1,n,n);
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
while error > epsilon
    x2=alp*Ht*x1 + e/n*(alp*at+(1-alp)*et)*x1; 
    x2=x2/sum(x2); %normalisation
    error = sum(abs(x1-x2));
    x1=x2;
end    
x1