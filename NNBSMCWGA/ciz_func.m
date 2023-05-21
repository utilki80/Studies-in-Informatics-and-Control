function [link1rms,link2rms] = ciz_func(y,tol1,tol2)
%save y
figure(1); 
subplot(211); 
plot(y.time,y.data(:,1),'k',y.time,y.data(:,7),'r:','linewidth',1); 
xlabel('zaman(s)');ylabel('1. ba�lant�n�n izledi�i y�r�nge'); 
legend('�zlenmesi Gereken Y�r�nge','�zlenen Y�r�nge'); 
subplot(212); 
plot(y.time,y.data(:,4),'k',y.time,y.data(:,9),'r:','linewidth',1); 
xlabel('zaman(s)');
ylabel('2. ba�lant�n�n izledi�i y�r�nge'); 
legend('�zlenmesi Gereken Y�r�nge','�zlenen Y�r�nge'); 

figure(3); 
subplot(211); 
plot(tol1.time,tol1.data(:,1),'r','linewidth',2); 
xlabel('zaman(s)');
ylabel('1. ba�lant�ya uygulanan tork');  
subplot(212); 
plot(tol2.time,tol2.data(:,1),'r','linewidth',2); 
xlabel('zaman(s)');
ylabel('2. ba�lant�ya uygulanan tork'); 

figure(4); 
plot(y.time,y.data(:,11),'k',y.time,y.data(:,12),'r:','linewidth',2); 
xlabel('time(s)');
ylabel('f and fn'); 
legend('Practical f(x)','Estimate f(x)');

figure(5); 
subplot(211); 
plot(y.time,(y.data(:,7)-y.data(:,1)),'k','linewidth',2); 
xlabel('zaman(s)');ylabel('1. ba�lant� error');
legend('Error'); 
subplot(212); 
plot(y.time,(y.data(:,9)-y.data(:,4)),'k','linewidth',2); 
xlabel('zaman(s)');
ylabel('2. ba�lant� error'); 
legend('Error'); 

figure(6); 
subplot(211); 
plot(y.time,y.data(:,2),'k',y.time,y.data(:,8),'r:','linewidth',2); 
xlabel('zaman(s)');ylabel('1. ba�lant�n�n izledi�i a��sal h�z'); 
legend('�zlenmesi Gereken A��sal H�z','�zlenen A��sal H�z'); 
subplot(212); 
plot(y.time,y.data(:,5),'k',y.time,y.data(:,10),'r:','linewidth',2); 
xlabel('zaman(s)');
ylabel('2. ba�lant�n�n izledi�i a��sal h�z'); 
legend('�zlenmesi Gereken A��sal H�z','�zlenen A��sal H�z');

link1rms = sqrt(sum((y.data(:,7)-y.data(:,1)).^2)/length(y.data(:,7)-y.data(:,1)))
link2rms = sqrt(sum((y.data(:,9)-y.data(:,4)).^2)/length(y.data(:,9)-y.data(:,4)))
end

