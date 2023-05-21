function [ arapop ] = dogalsecilimprj( population, obj, psize )
%DOGALSEC�L�MPRJ Summary of this function goes here
%   Detailed explanation goes here

obj=1./obj;          %biz burada ama� fonksiyonu objelerini minimize etmeye �al��acaz.
sumobj=sum(obj);     %yani ama� fonksiyonlar�n�n bir b�l�l� hallerini maksimize
probs=obj./sumobj;   %edicez.
cprobs=probs;        %probs bizim olas�l�k de�erleri

for i=2:psize
    cprobs(i)=cprobs(i-1)+probs(i); %cprobs bizim birikimli olas�l�k de�erleri. 
end

rs=unifrnd(0,1,[psize,1]);
arapop=population;

for i=1:psize
    idx=find(rs(i)<cprobs,1);% k���k oldu�u ilk index o y�zden 1 yazd�k
    arapop(i,:)=population(idx,:); %se�ilim yap�l�yor.(FOR D�NG�S� SE��L�M� SA�LIYOR!!)
end

end

