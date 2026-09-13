function [x, y, z] = RotationAroundY(X, Y, Z, Beta, x0, ~, z0)
% 将点 (X,Y,Z) 绕 Y 轴旋转 Beta 弧度（旋转中心为 (x0,y0,z0)）。
% 支持标量或向量输入，向量化实现。绕 Y 轴时 Y 坐标不变，故 y0 用 ~ 忽略。
c = cos(Beta);
s = sin(Beta);
% 先平移到旋转中心，旋转后再平移回来；绕 Y 轴时 Y 坐标不变
x = (X - x0).*c + (Z - z0).*s + x0;
y = Y;
z = -(X - x0).*s + (Z - z0).*c + z0;
end