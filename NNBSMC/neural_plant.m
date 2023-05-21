function [sys,x0,str,ts]=neural_plant(t,x,u,flag) 
switch flag, 
case 0,     
    [sys,x0,str,ts]=mdlInitializeSizes; 
case 1,     
    sys=mdlDerivatives(t,x,u); 
case 3,     
    sys=mdlOutputs(t,x,u); 
case {2, 4, 9 }     
    sys = []; 
otherwise
    error(['Unhandled flag = ',num2str(flag)]); 
end
function [sys,x0,str,ts]=mdlInitializeSizes 
global g a1 a2 T
sizes = simsizes; 
sizes.NumContStates  = 4; 
sizes.NumDiscStates  = 0; 
sizes.NumOutputs     = 5; 
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 0; 
sizes.NumSampleTimes = 0; 
sys=simsizes(sizes); 
x0=[0 0 0 0]; 
str=[]; 
ts=[];
g=9.8;
%m1=1; 
%m2=1; 
a1=1; 
a2=1;
T=2;
function sys=mdlDerivatives(t,x,u) 
global g a1 a2
q1=x(1); dq1=x(2);
q2=x(3); dq2=x(4);

if t<2
    m1=1.5;
    m2=1.2;
elseif t>=2 & t<5
    m1=1;
    m2=0.8;
elseif t>=5 & t<12
    m1=0.5;
    m2=0.4;
elseif t>=12 & t<15
    m1=1.5;
    m2=1.2;
else
    m1=1;
    m2=0.8;
end

M11=((m1+m2)*(a1^2))+(m2*(a2^2))+(2*m2*a1*a2*cos(q2));
M12=(m2*(a2^2))+(m2*a1*a2*cos(q2)); %M21 ayný çünkü M matrisi simetriktir.
M22=(m2*((a2)^2));
N1=(-m2*a1*a2*((2*dq1*dq2)+(dq2^2))*sin(q2))+(((m1+m2)*g*a1*cos(q1))+(m2*g*a2*cos(q1+q2)));
N2=(m2*a1*a2*(dq1^2)*sin(q2))+(m2*g*a2*cos(q1+q2));
M=[M11 M12 ; M12 M22];
N=[N1 ; N2];
dq=[dq1;dq2];
% F=0.5*sign(dq);
F=dq+2*sign(dq);
% told=[0.5*sin(pi*t);0.5*sin(pi*t)];
told = [u(4);u(4)];

tol=u(1:2);

S=inv(M)*(tol-N-F-told);

sys(1)=x(2);
sys(2)=S(1);
sys(3)=x(4);
sys(4)=S(2);
function sys=mdlOutputs(t,x,u)
global g a1 a2
q1=x(1); dq1=x(2);
q2=x(3); dq2=x(4);

if t<2
    m1=1.5;
    m2=1.2;
elseif t>=2 & t<5
    m1=1;
    m2=0.8;
elseif t>=5 & t<12
    m1=0.5;
    m2=0.4;
elseif t>=12 & t<15
    m1=1.5;
    m2=1.2;
else
    m1=1;
    m2=0.8;
end

M11=((m1+m2)*(a1^2))+(m2*(a2^2))+(2*m2*a1*a2*cos(q2));
M12=(m2*(a2^2))+(m2*a1*a2*cos(q2)); %M21 ayný çünkü M matrisi simetriktir.
M22=(m2*((a2)^2));
N11=(-m2*a1*a2*dq2*sin(q2));
N12=(-m2*a1*a2*(dq1+dq2)*sin(q2));
N21=(m2*a1*a2*(dq1)*sin(q2));
N22=0;
G1=(((m1+m2)*g*a1*cos(q1))+(m2*g*a2*cos(q1+q2)));
G2=(m2*g*a2*cos(q1+q2));
M=[M11 M12 ; M12 M22];
Vm=[N11 N12 ; N21 N22];
G=[G1 ; G2];
dq=[dq1;dq2];
F=dq+2*sign(dq);

%%%%%%%reference(1)%%%%%%%
% T=2;
% qd1=0.1*sin(2*pi*t/T);
% d_qd1=0.1*(2*pi/T)*cos(2*pi*t/T);
% dd_qd1=-0.1*((2*pi/T)^2)*sin(2*pi*t/T);
% qd2=0.1*cos(2*pi*t/T);
% d_qd2=-0.1*(2*pi/T)*sin(2*pi*t/T);
% dd_qd2=-0.1*((2*pi/T)^2)*cos(2*pi*t/T);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%reference(2)%%%%%%%
% qd1=(pi/2)-(pi/4)*cos(0.5*t);
% d_qd1=0.5*(pi/4)*sin(0.5*t);
% dd_qd1=0.25*(pi/4)*cos(0.5*t);
% qd2=(pi/3)*sin(0.5*t);
% d_qd2=0.5*(pi/3)*cos(0.5*t);
% dd_qd2=-0.25*(pi/3)*sin(0.5*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%reference(3)%%%%%%%
qd1=(pi/2)*t;
d_qd1=(pi/2); 
dd_qd1=0;
qd2=(pi/3)*t;
d_qd2=(pi/3);
dd_qd2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%reference(4)%%%%%%%
qd1=(pi/2);
d_qd1=0; 
dd_qd1=0;
qd2=(pi/3);
d_qd2=0;
dd_qd2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e1=qd1-q1;
e2=qd2-q2;
de1=d_qd1-dq1;
de2=d_qd2-dq2;
e=[e1;e2]; 
de=[de1;de2]; 
Fai=35*eye(2); 
dqd=[d_qd1;d_qd2];
dqr=dqd+Fai*e;
ddqd=[dd_qd1;dd_qd2];
ddqr=ddqd+Fai*de;
f=M*ddqr+Vm*dqr+G+F;%rbf in yaklaþtýðý asýl deðer.
f_norm=norm(f);
sys(1)=x(1); 
sys(2)=x(2); 
sys(3)=x(3); 
sys(4)=x(4); 
sys(5)=f_norm;