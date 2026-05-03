function [prvector] = pwpr(pa,n,v)
   c=full(sum(pa));
   k= find(c~=0);
   D=sparse(k,k,1./c(k),n,n); %diagonal matrix
   Ht = pa * D; 
   alp=0.85;
   x1=ones(n,1)/n;
   x2=zeros(n,1);
   error = sum(abs(x1-x2));
   epsilon = 0.000000001;
   while error > epsilon
       x2=alp*Ht*x1 +(1-alp)*v; 
       error = sum(abs(x1-x2));
       x1=x2;
   end
   prvector = x1;