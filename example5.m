clear;close all;clc %马鞍曲面与平面的交线
[x, y]=meshgrid(-10:0.2:10, -10:0.2:10);z1=x.^2-2*y.^2;mesh(x, y, z1);hold on
H=[];H1=[];H2=[];
for a=50:-2:-100
    if a>0
        y0=linspace(-10, 10);x0=sqrt(a+2*y0.^2);z0=a*ones(size(y0));
        x0(abs(x0)>10)=NaN;y0(abs(x0)>10)=NaN;z0(abs(x0)>10)=NaN;
        delete(H1);delete(H2);
        H1=plot3(x0, y0, z0, 'r');hold on
        H2=plot3(-x0, y0, z0, 'r');
    else
        x0=linspace(-10, 10);y0=sqrt((x0.^2-a)/2);z0=a*ones(size(y0));
        x0(abs(y0)>10)=NaN;y0(abs(y0)>10)=NaN;z0(abs(y0)>10)=NaN;
        delete(H1);delete(H2);
        H1=plot3(x0, y0, z0, 'r');hold on
        H2=plot3(x0, -y0, z0, 'r');
    end
    z2=a*ones(size(x));delete(H);H=mesh(x, y, z2);
    xlabel('x');ylabel('y');zlabel('z');
    pause(0.1)
end