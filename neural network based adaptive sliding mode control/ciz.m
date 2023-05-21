close all;
 
figure(1); 
subplot(211); 
plot(y.time,y.data(:,1),'k',y.time,y.data(:,7),'r:','linewidth',2); 
xlabel('Time(s)');ylabel('Link 1 trajectory (rad)'); 
legend('Referans','NNBASMC')
subplot(212); 
plot(y.time,y.data(:,4),'k',y.time,y.data(:,9),'r:','linewidth',2); 
xlabel('Time(s)');ylabel('Link 2 trajectory (rad)');
legend('Referans','NNSMAC çözümü'); 

figure(3); 
subplot(211); 
plot(tol1.time,tol1.data(:,1),'r','linewidth',2); 
xlabel('Time(s)');ylabel('Control inputs for link 1 (N.m)');  
subplot(212); 
plot(tol2.time,tol2.data(:,1),'r','linewidth',2); 
xlabel('Time(s)');ylabel('Control inputs for link 2 (N.m)'); 

figure(4); 
plot(y.time,y.data(:,11),'k',y.time,y.data(:,12),'r:','linewidth',2); 
xlabel('time(s)');
ylabel('f and fn'); 
legend('Practical f(x)','Estimate f(x)');

figure(5); 
subplot(211); 
plot(y.time,(y.data(:,7)-y.data(:,1)),'k','linewidth',2); 
xlabel('Time(s)');ylabel('Trajectory tracking error for link 1');
legend('NNBASMC'); 
subplot(212); 
plot(y.time,(y.data(:,9)-y.data(:,4)),'k','linewidth',2); 
xlabel('Time(s)');ylabel('Trajectory tracking error for link 2'); 
legend('Hata'); 

figure(6); 
subplot(211); 
plot(y.time,y.data(:,2),'k',y.time,y.data(:,8),'r:','linewidth',2); 
xlabel('Time(s)');ylabel('Angular velocity tracking for link 1 (rad/s)'); 
legend('Ýzlenmesi Gereken Açýsal Hýz','Ýzlenen Açýsal Hýz'); 
subplot(212); 
plot(y.time,y.data(:,5),'k',y.time,y.data(:,10),'r:','linewidth',2); 
xlabel('Time(s)');ylabel('Angular velocity tracking for link 2 (rad/s)');
legend('Ýzlenmesi Gereken Açýsal Hýz','Ýzlenen Açýsal Hýz');

link1rms = sqrt(sum((y.data(:,7)-y.data(:,1)).^2)/length(y.data(:,7)-y.data(:,1)))
link2rms = sqrt(sum((y.data(:,9)-y.data(:,4)).^2)/length(y.data(:,9)-y.data(:,4)))