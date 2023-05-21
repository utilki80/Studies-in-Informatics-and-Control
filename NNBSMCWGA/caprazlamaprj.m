function [ arapop ] = caprazlamaprj( arapop, psize, pcross )
%CAPRAZLAMAPRJ Summary of this function goes here
%   Detailed explanation goes here
ciftler=randperm(psize);%çiftleri belirliyoruz.

for i=1:psize/2           %psize/2 kadar çaprazlama yapýlacak 50 kromozom varsa 25 tane çaprazlama
    parent1idx=ciftler(2*i-1);
    parent2idx=ciftler(2*i);
    parent1=arapop(parent1idx,:);
    parent2=arapop(parent2idx,:);
    rs=unifrnd(0,1);
    if (rs<pcross)  %rassal sayýmýz çaprazlama olasýlýðý paremetremizden küçük ise çaprazlama olasýlýðýný biz tanýmlýcaz.
        capnoktasi=unidrnd(3-1); %rastgele bir çaprazlama noktasý tanýmladýk. burada 3 dediðimiz d miz oluyor yani sütun sayýmýz.
        dummy=parent1(capnoktasi+1:end);
        parent1(capnoktasi+1:end)=parent2(capnoktasi+1:end);
        parent2(capnoktasi+1:end)=dummy;
        arapop(parent1idx,:)=parent1;
        arapop(parent2idx,:)=parent2;
    end
end
end

