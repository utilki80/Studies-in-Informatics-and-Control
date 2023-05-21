function [ arapop ] = caprazlamaprj( arapop, psize, pcross )
%CAPRAZLAMAPRJ Summary of this function goes here
%   Detailed explanation goes here
ciftler=randperm(psize);%�iftleri belirliyoruz.

for i=1:psize/2           %psize/2 kadar �aprazlama yap�lacak 50 kromozom varsa 25 tane �aprazlama
    parent1idx=ciftler(2*i-1);
    parent2idx=ciftler(2*i);
    parent1=arapop(parent1idx,:);
    parent2=arapop(parent2idx,:);
    rs=unifrnd(0,1);
    if (rs<pcross)  %rassal say�m�z �aprazlama olas�l��� paremetremizden k���k ise �aprazlama olas�l���n� biz tan�ml�caz.
        capnoktasi=unidrnd(3-1); %rastgele bir �aprazlama noktas� tan�mlad�k. burada 3 dedi�imiz d miz oluyor yani s�tun say�m�z.
        dummy=parent1(capnoktasi+1:end);
        parent1(capnoktasi+1:end)=parent2(capnoktasi+1:end);
        parent2(capnoktasi+1:end)=dummy;
        arapop(parent1idx,:)=parent1;
        arapop(parent2idx,:)=parent2;
    end
end
end

