clear; close all; clc  % (三) 小球沿环形弹簧运动

% ---- 参数 ----
R  = 5;      % 基环半径
n  = 20;     % 弹簧绕环圈数
N  = n*20;   % 采样点数（每圈 20 个点）
dt = 0.1;    % 动画每帧暂停时间（秒）

% ---- 生成环形弹簧：平面弹簧绕 Y 轴旋转“卷”到环上 ----
t = linspace(0, 2*pi, N);
x = R + sin(n*t);   % 弹簧截面：小圆绕 (R,0) 打转
y = cos(n*t);
z = 0.0001*t;       % 微小上升量

[x1, y1, z1] = RotationAroundY(x, y, z, t, 0, 0, 0);

% ---- 绘图：基环 + 弹簧 ----
t0 = linspace(0, 2*pi);
plot3(R*sin(t0), zeros(size(t0)), R*cos(t0), 'k'); hold on
plot3(x1, y1, z1, 'k');
axis equal; view(39, 32)

% ---- 动画：小球沿弹簧运动（复用句柄更新数据，不反复 plot/delete）----
H = plot3(x1(1), y1(1), z1(1), 'ok', 'markerfacecolor', 'k');
for m = 1:3
    for i = 1:N
        set(H, 'XData', x1(i), 'YData', y1(i), 'ZData', z1(i));
        pause(dt)
    end
end

% clear all;close all;clc % (三) 小球沿环形弹簧运动
% t0=linspace(0,2*pi);R=5;
% x0=R*sin(t0); z0=R*cos(t0); y0=zeros(size(x0));
% plot3(x0,y0,z0,'k');hold on;view(50,60)
% M=20;N=M*20;
% t=linspace(0,2*pi,N);
% for i=1:length(t)
%     x(i)=1*sin(t(i)*20)+R;
%     y(i)=1*cos(t(i)*20);
%     z=t*0.0001;
%     [x1(i),y1(i),z1(i)]=RotationAroundY(x(i),y(i),z(i),t(i),0,0,0);
% end
% plot3(x1,y1,z1,'k');hold on;axis equal;view(39,32)
% H=[];
% for m=1:3
%     for i=1:length(t)
%         x0(i)=1*sin(t(i)*20)+R;
%         y0(i)=1*cos(t(i)*20);
%         z0=t*0.0001;
%         [x2(i),y2(i),z2(i)]=RotationAroundY(x0(i),y0(i),z0(i),t(i),0,0,0);
%         delete(H)
%         H=plot3(x2(i),y2(i),z2(i),'ok','markerfacecolor','k');pause(0.1)
%     end
% end
