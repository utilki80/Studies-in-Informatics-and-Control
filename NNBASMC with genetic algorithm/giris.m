function [sys,x0,str,ts] = giris(t,x,u,flag) 
switch flag, 
case 0,     
    [sys,x0,str,ts]=mdlInitializeSizes; 
case 3,     
    sys=mdlOutputs(t,x,u); 
case {2,4,9}     
    sys=[]; 
otherwise
    error(['Unhandled flag = ',num2str(flag)]); 
end
function [sys,x0,str,ts]=mdlInitializeSizes 
sizes = simsizes; 
sizes.NumContStates  = 0; 
sizes.NumDiscStates  = 0; 
sizes.NumOutputs     = 6; 
sizes.NumInputs      = 0; 
sizes.DirFeedthrough = 0; 
sizes.NumSampleTimes = 1; 
sys = simsizes(sizes); 
x0  = []; 
str = []; 
ts  = [0 0]; 
function sys=mdlOutputs(t,x,u)
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
% qd1=(pi/2)*t;
% d_qd1=(pi/2); 
% dd_qd1=0;
% qd2=(pi/3)*t;
% d_qd2=(pi/3);
% dd_qd2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%reference(4)%%%%%%%
qd1=(pi/2);
d_qd1=0; 
dd_qd1=0;
qd2=(pi/3);
d_qd2=0;
dd_qd2=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
sys(1)=qd1; 
sys(2)=d_qd1; 
sys(3)=dd_qd1;
sys(4)=qd2;
sys(5)=d_qd2;
sys(6)=dd_qd2;