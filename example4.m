clear;close all;clc%正交圆柱及交线
r=1;
[Theta, Z]=meshgrid(linspace(0, 2*pi, 1000), linspace(-5, 5, 1000));
X=r*cos(Theta);Y=r*sin(Theta);
X(X.^2+Z.^2<=r^2)=NaN;Y(X.^2+Z.^2<=r^2)=NaN;Z(X.^2+Z.^2<=r^2)=NaN;
surf(X, Y, Z);hold on
surf(X, Z, Y);hold on
axis equal;shading interp;colormap(copper);light('position',[-1 -2 0]);
t=linspace(0,2*pi);
x=r*cos(t);y=r*sin(t);
z=sqrt(r^2-x.^2);
plot3(x,y,z,'g')
plot3(x,y,-z,'g')