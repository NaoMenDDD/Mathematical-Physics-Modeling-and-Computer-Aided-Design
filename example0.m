clear;close all;clc

z=0:pi/50:10*pi;
x=cos(z);
y=sin(z);z=z*0.1;
H=[]

for n=1:3
    for m=[linspace(1,0,10),linspace(0,1,10)]
        delete(H)
        H=plot3(x,y,z*m,'k');hold on
        axis([-1 1 -1 1 0 pi])
        pause(0.1)
        xlabel('x');ylabel('y');zlabel('z');
        axis equal
    end
end