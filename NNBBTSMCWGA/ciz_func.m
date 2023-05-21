function [link1rms,link2rms] = ciz_func(y,tol1,tol2)
figure(1); 
subplot(211); 
plot(y.time,y.data(:,1),'k',y.time,y.data(:,7),'r:','linewidth',2); 
%figure(1), hold on, plot(y.time,y.data(:,7),'r--','linewidth',1); 
xlabel('time(s)');ylabel('Link 1 trajectory'); grid;
legend('Reference Trajectory','NNABTSMCWGA Solution'); 
subplot(212); 
plot(y.time,y.data(:,4),'k',y.time,y.data(:,9),'r:','linewidth',2); 
xlabel('time(s)'); ylabel('Link 2 Trajectory'); grid;
legend('Reference Trajectory','NNABTSMCWGA Solution'); 

figure(3); 
subplot(211); 
plot(tol1.time,tol1.data(:,1),'r','linewidth',2); 
xlabel('time(s)'); ylabel('1st joint torque'); grid; 
subplot(212); 
plot(tol2.time,tol2.data(:,1),'r','linewidth',2); 
xlabel('time(s)'); ylabel('2nd joint torque'); grid;

figure(4); 
plot(y.time,y.data(:,11),'k',y.time,y.data(:,12),'r:','linewidth',2); 
xlabel('time(s)');
ylabel('f and fn'); 
legend('Practical f(x)','Estimate f(x)');

figure(5); 
subplot(211); 
plot(y.time,(y.data(:,7)-y.data(:,1)),'k','linewidth',2); 
xlabel('time(s)');ylabel('Link 1 error'); grid;
%legend('Error');
subplot(212); 
plot(y.time,(y.data(:,9)-y.data(:,4)),'k','linewidth',2); 
xlabel('time(s)'); ylabel('Link 2 error'); grid;
%legend('Error'); 

figure(6); 
subplot(211); 
plot(y.time,y.data(:,2),'k',y.time,y.data(:,8),'r:','linewidth',2); 
xlabel('zaman(s)');ylabel('1. baðlantýnýn izlediði açýsal hýz'); 
legend('Ýzlenmesi Gereken Açýsal Hýz','Ýzlenen Açýsal Hýz'); 
subplot(212); 
plot(y.time,y.data(:,5),'k',y.time,y.data(:,10),'r:','linewidth',2); 
xlabel('zaman(s)');
ylabel('2. baðlantýnýn izlediði açýsal hýz'); 
legend('Ýzlenmesi Gereken Açýsal Hýz','Ýzlenen Açýsal Hýz');
figure, plot(y.data(:,1),y.data(:,4)), hold on, plot(y.data(:,7),y.data(:,9),'r');

link1rms = sqrt(sum((y.data(:,7)-y.data(:,1)).^2)/length(y.data(:,7)-y.data(:,1)))
link2rms = sqrt(sum((y.data(:,9)-y.data(:,4)).^2)/length(y.data(:,9)-y.data(:,4)))
end

