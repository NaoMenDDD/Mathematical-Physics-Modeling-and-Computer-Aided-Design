clear; close all; clc  % 三维旋转爱心（实心体表面）

% ---- 爱心隐式方程 + 等值面 ----
[x, y, z] = meshgrid(linspace(-1.5, 1.5, 60));
val = (x.^2 + 9/4*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - 9/80*y.^2.*z.^3;
[f, v] = isosurface(x, y, z, val, 0);

% ---- 绘制实心体表面 ----
p = patch('Faces', f, 'Vertices', v);
isonormals(x, y, z, val, p);            % 计算法线，光照才平滑
p.FaceColor = [0.85 0.15 0.25];         % 爱心红
p.EdgeColor = 'none';

axis equal; axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]); view(30, 10);
camlight; lighting gouraud; material shiny;

% ---- 用 hgtransform 绕 Z 轴持续旋转：5 秒一圈 ----
tr = hgtransform;
p.Parent = tr;                          % 把爱心挂到变换节点上
T = 5;                                  % 周期（秒/圈）
omega = 2*pi/T;
t0 = tic;
while isvalid(p)                        % 关闭图形窗口后自动退出
    tr.Matrix = makehgtform('zrotate', toc(t0)*omega);
    drawnow; pause(0.01);
end

% clear all;close all;clc %三维旋转爱心
% [x, y, z]=meshgrid(linspace(-1.5, 1.5, 30));
% val=(x.^2+9/4*y.^2+z.^2-1).^3-x.^2.*z.^3-9/80*y.^2.*z.^3;
% [f, v]=isosurface(x, y, z, val, 0);
% plot3(v(:,1), v(:,2), v(:,3), 'or', 'markerfacecolor', 'r')
% H=[]
% for t=linspace(0, 20*pi, 200)
%     X=v(:,1)*cos(t)-v(:,2)*sin(t);
%     Y=v(:,1)*sin(t)+v(:,2)*cos(t);
%     Z=v(:,3);
%     delete(H)
%     H=plot3(X, Y, Z, 'or', 'markerfacecolor', 'r');axis equal
%     axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
%     view(30, 10)
%     pause(0.01)
% end
