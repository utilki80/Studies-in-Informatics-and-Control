function [ eniyicozum eniyideger link1rms link2rms ] = genelkod( psize, pcross, pmutation, delta )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
tic;
cpop=unifrnd(0,100,[psize,11]);
theta = unifrnd(0.0001,0.9999,[psize,1]);
% a=unifrnd(0,50,[psize,1]);
% b=unifrnd(0,100,[psize,1]);
population=[cpop theta];

%find_system('name','neural_network_based_adaptive_sliding');
%open_system('neural_network_based_adaptive_sliding');

iteration=1;

eniyideger=1000000;

while (iteration<10)

obj=zeros(psize,1);

for i=1:psize
    c=population(i,1:12);
    a=mat2str(c);
    set_param('neural_network_based_adaptive_sliding/Constant','Value',a);
    sim('neural_network_based_adaptive_sliding',5)
    %set_param('neural_network_based_adaptive_sliding','StartTime','0','StopTime','20')
    %set_param('neural_network_based_adaptive_sliding','SimulationCommand','Start');
    while(1)
        aa=get_param('neural_network_based_adaptive_sliding','SimulationStatus')
        bb='stopped';
        if strcmp(bb,aa)
            break
        end
    end
    bbh=abs(y.data(:,7)-y.data(:,1));%birinci baðlantý error.
    ibh=abs(y.data(:,9)-y.data(:,4));%ikinci baðlantý error.
    z=[mean(bbh) mean(ibh)];
    obj(i)=mean(z);
    
end

%Find out who owns the best value.
if (min(obj)<eniyideger)
    eniyideger = min(obj);
    idx=find(obj==eniyideger);
    eniyicozum=population(idx,:);
end
%objit(iteration)=eniyideger; %her iterasyonun en iyi sonucunu bulacak

[ arapop ] = dogalsecilimprj( population, obj, psize );%doðal secilim
[ arapop ] = caprazlamaprj( arapop, psize, pcross );%çaprazlama
population = mutasyonprj( arapop, pmutation, psize, delta );
iteration=iteration+1;

end
c2=eniyicozum;
a=mat2str(c2);
set_param('neural_network_based_adaptive_sliding/Constant','Value',a);
sim('neural_network_based_adaptive_sliding',20)
while(1)
    aa=get_param('neural_network_based_adaptive_sliding','SimulationStatus');
    bb='stopped';
    if strcmp(bb,aa)
        break
    end
end
[link1rms,link2rms] = ciz_func(y,tol1,tol2);
toc;
end