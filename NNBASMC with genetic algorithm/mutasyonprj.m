function [ arapop ] = mutasyonprj( arapop, pmutation, psize, delta )
%MUTASYONPRJ Summary of this function goes here
%   Detailed explanation goes here
rs=unifrnd(0,1,[psize,3]);%herbir gene rassal say� at�yoruz.
for i=1:psize
    for j=1:3
        if (rs(i,j)<pmutation)%rassal say�m�z belirledi�imiz mutasyon olas�l���ndan k���kse
            rs2=unifrnd(-1,1); %art�r�p azaltacakm�y�z bunu rassal olarak belirliyoruz - yada + olacak.
            arapop(i,j)=arapop(i,j)+rs2*delta*(100-0);                                                                                                                      
        end
    end
end
end

