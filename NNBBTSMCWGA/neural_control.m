function [sys,x0,str,ts] = neural_control(t,x,u,flag) 
switch flag, 
case 0,     
    [sys,x0,str,ts]=mdlInitializeSizes; 
case 1,     
    sys=mdlDerivatives(t,x,u);
case 3,     
    sys=mdlOutputs(t,x,u); 
case {2,4,9}     
    sys=[]; 
otherwise
    error(['Unhandled flag = ',num2str(flag)]); 
end
function [sys,x0,str,ts]=mdlInitializeSizes 
global node % Fai c ve b eklenecek...
node=7; 
%c=0.1*[-1.5 -1 -0.5 0 0.5 1 1.5;-1.5 -1 -0.5 0 0.5 1 1.5;-1.5 -1 -0.5 0
%0.5 1 1.5;-1.5 -1 -0.5 0 0.5 1 1.5;-1.5 -1 -0.5 0 0.5 1 1.5]; normally
%used
%b=10; 
%Fai=35*eye(2);
sizes = simsizes; 
sizes.NumContStates  = 2*node; 
sizes.NumDiscStates  = 0; 
sizes.NumOutputs     = 3; 
sizes.NumInputs      = 24; %en son c katsayýsý denemesi
sizes.DirFeedthrough = 1; 
sizes.NumSampleTimes = 0; 
sys = simsizes(sizes); 
x0  = 0.1*ones(1,2*node); 
str = []; 
ts  = [];
function sys=mdlDerivatives(t,x,u) 
global node %Fai c ve b eklenecek
cm = [u(12) u(13) u(14) u(15) u(16) u(17) u(18)];
b = u(19);
Fw1 = u(20);
Fai_k = 1/u(22);
Fai = Fai_k*eye(2);
Fai2 = u(24)*eye(2);
c=[cm;cm;cm;cm;cm];
qd1=u(1); 
d_qd1=u(2); 
dd_qd1=u(3); 
qd2=u(4); 
d_qd2=u(5); 
dd_qd2=u(6); 
 
q1=u(7); 
d_q1=u(8); 
q2=u(9); 
d_q2=u(10); 
 
q=[q1;q2]; 
 
e1=qd1-q1; 
e2=qd2-q2; 
de1=d_qd1-d_q1;
de2=d_qd2-d_q2;
e=[e1;e2]; 
de=[de1;de2]; 
S=de+(Fai*(abs(e).^u(23)))+(Fai2*e); 
 
qd=[qd1;qd2]; 
dqd=[d_qd1;d_qd2]; 
dqr=dqd+Fai*e; 
ddqd=[dd_qd1;dd_qd2]; 
ddqr=ddqd+Fai*de; 
 
z1=[e(1);de(1);qd(1);dqd(1);ddqd(1)]; 
z2=[e(2);de(2);qd(2);dqd(2);ddqd(2)]; 
for j=1:1:node     
    h1(j)=exp(-norm(z1-c(:,j))^2/(b*b));     
    h2(j)=exp(-norm(z2-c(:,j))^2/(b*b)); 
end
Fw=15*eye(node); 
for i=1:1:node     
    sys(i)=Fw1*h1(i)*S(1);     
    sys(i+node)=Fw1*h2(i)*S(2); 
end
function sys=mdlOutputs(t,x,u) 
global node %Fai c ve b eklenecek
cm=[u(12) u(13) u(14) u(15) u(16) u(17) u(18)];
b = u(19);
Fai_k = 1/u(22);
Fai = Fai_k*eye(2);
Fai2 = u(24)*eye(2);
c=[cm;cm;cm;cm;cm];
qd1=u(1); 
d_qd1=u(2); 
dd_qd1=u(3); 
qd2=u(4); 
d_qd2=u(5); 
dd_qd2=u(6); 
 
q1=u(7); 
d_q1=u(8); 
q2=u(9); 
d_q2=u(10); 
 
q=[q1;q2]; 
 
e1=qd1-q1; 
e2=qd2-q2; 
de1=d_qd1-d_q1; 
de2=d_qd2-d_q2; 
e=[e1;e2]; 
de=[de1;de2]; 
S=de+(Fai*(abs(e).^u(23)))+(Fai2*e); 
 
qd=[qd1;qd2]; 
dqd=[d_qd1;d_qd2]; 
ddqd=[dd_qd1;dd_qd2]; 
 
W_f1=[x(1:node)]'; %W_f1 matrisleri normalde sütun vektörü satýra dönüþtürülüyor.
W_f2=[x(node+1:node*2)]'; %W_f2 matrisleri normalde sütun vektörü satýra dönüþtürülüyor.
 
z1=[e(1);de(1);qd(1);dqd(1);ddqd(1)]; %burada hata yerine açý ve açýný türevi alýnabilir dene.
z2=[e(2);de(2);qd(2);dqd(2);ddqd(2)]; 
for j=1:1:node     
    h1(j)=exp(-norm(z1-c(:,j))^2/(b*b));     
    h2(j)=exp(-norm(z2-c(:,j))^2/(b*b)); 
end 
 
fn=[W_f1*h1';W_f2*h2']; 
%Kv=30*eye(2); 
Kv = u(21)*eye(2);

epN=0.20;
bd=0.1; 
% v=-(epN+bd)*sign(S);
M1=1;
if M1==1
    v=-(epN+bd)*sign(S);
elseif M1==2 %Saturated function
    delta=0.05;
    kk=1/delta;
    if abs(S)>delta
        sats=sign(S);
    else
        sats=kk*S;
    end
    v=-(epN+bd)*sats;
end
tol=fn+Kv*S+v;     

fn_norm=norm(fn); 
sys(1)=tol(1); 
sys(2)=tol(2); 
sys(3)=fn_norm;