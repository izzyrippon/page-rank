n=20;
[U,G] = surfer('https://www.udemy.com/',n);
c=full(sum(G))
k= find(c~=0);
D=sparse(k,k,1./c(k),n,n); %diagonal matrix
Ht = G * D; 
full(sum(Ht))
e = ones(n,1);
et = ones(1,n);
at = et - sum(Ht);

x1=ones(n,1);
x2=zeros(n,1);
epsilon = 0.00000001;
alp = 0.85;
error = abs(sum(x1-x2));
while error > epsilon
    x2=alp*Ht*x1 + e/n*(alp*at+(1-alp)*et)*x1; 
    x2=x2/sum(x2); %normalisation
    error = abs(sum(x1-x2));
    x1=x2;
end    
X = num2cell(x1)
Z = cell2table([U X]);
sortrows(Z, 'Var2', 'descend')
