function [ arapop ] = dogalsecilimprj( population, obj, psize )
%DOGALSECÝLÝMPRJ Summary of this function goes here
%   Detailed explanation goes here

obj=1./obj;          %biz burada amaç fonksiyonu objelerini minimize etmeye çalýþacaz.
sumobj=sum(obj);     %yani amaç fonksiyonlarýnýn bir bölülü hallerini maksimize
probs=obj./sumobj;   %edicez.
cprobs=probs;        %probs bizim olasýlýk deðerleri

for i=2:psize
    cprobs(i)=cprobs(i-1)+probs(i); %cprobs bizim birikimli olasýlýk deðerleri. 
end

rs=unifrnd(0,1,[psize,1]);
arapop=population;

for i=1:psize
    idx=find(rs(i)<cprobs,1);% küçük olduðu ilk index o yüzden 1 yazdýk
    arapop(i,:)=population(idx,:); %seçilim yapýlýyor.(FOR DÖNGÜSÜ SEÇÝLÝMÝ SAÐLIYOR!!)
end

end

