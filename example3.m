clear; close all; clc  % 地球自转 + 月球公转（潮汐锁定）+ 星空背景

% ---- 读入贴图 ----
earthImg = imread('imgs/earth.jpg');       % 地球等距柱状地图（北在上）
moonImg  = imread('imgs/moon.jpg');        % 月球表面
bgImg    = imread('imgs/background.jpg');  % 背景图

% ---- 生成单位球面网格（第 1 行 = 北极 z=+1）----
n = 60;
lat = linspace( pi/2, -pi/2, n+1);     % 纬度：北 → 南
lon = linspace(0, 2*pi, n+1);          % 经度：0 → 2π
[LON, LAT] = meshgrid(lon, lat);
Sx = cos(LAT).*cos(LON);
Sy = cos(LAT).*sin(LON);
Sz = sin(LAT);

% ---- 尺寸 ----
Re = 1.5;   % 地球显示半径
Rm = 0.6;   % 月球显示半径
R  = 5;     % 地月距离（公转轨道半径）

% ---- 初始绘制（关光照使贴图清晰；hold on 防止后画覆盖前画）----
earth = surf(Sx*Re, Sy*Re, Sz*Re, ...
    'CData', earthImg, 'FaceColor', 'texturemap', 'EdgeColor', 'none', ...
    'FaceLighting', 'none');
hold on
moon = surf(Sx*Rm, Sy*Rm, Sz*Rm, ...
    'CData', moonImg, 'FaceColor', 'texturemap', 'EdgeColor', 'none', ...
    'FaceLighting', 'none');

axis equal; axis([-7 7 -7 7 -7 7]); view(30, 20);
grid off; xlabel('x'); ylabel('y'); zlabel('z');
title('地球自转 · 月球公转');

% ---- 背景：在视线后方放一张贴有 background.jpg 的大平面 ----
cam     = campos;                 % 相机位置
tgt     = camtarget;              % 相机目标（约在原点）
viewDir = tgt - cam;              % 视线方向（相机 → 目标）
viewDir = viewDir / norm(viewDir);

d_bg = 20;                        % 背景平面到目标的距离（放在目标后方）
bc   = tgt + viewDir * d_bg;      % 背景平面中心点

up = [0 0 1];                     % 参考“上”方向
if abs(dot(viewDir, up)) > 0.99, up = [1 0 0]; end
u = cross(viewDir, up);  u = u / norm(u);   % 平面横向基向量
v = cross(viewDir, u);   v = v / norm(v);   % 平面纵向基向量

L = 50;                           % 背景平面边长
[pu, pv] = meshgrid(linspace(-L/2, L/2, 2));
bx = bc(1) + u(1)*pu + v(1)*pv;
by = bc(2) + u(2)*pu + v(2)*pv;
bz = bc(3) + u(3)*pu + v(3)*pv;

bg = surf(bx, by, bz, 'CData', bgImg, 'FaceColor', 'texturemap', ...
    'EdgeColor', 'none', 'FaceLighting', 'none');
bg.Clipping = 'off';              % 背景不被坐标轴范围裁剪
hold off                          % 地月与背景都画完后，再关闭 hold

% ---- 预计算基准网格 ----
Ex0 = Sx*Re; Ey0 = Sy*Re; Ez0 = Sz*Re;   % 地球球面
Mx0 = Sx*Rm; My0 = Sy*Rm; Mz0 = Sz*Rm;   % 月球球面

% ---- 周期（秒/圈）----
Te  = 6;    % 地球自转周期
Tmo = 12;   % 月球公转周期（潮汐锁定：自转周期 = 公转周期）
we = 2*pi/Te;  wmo = 2*pi/Tmo;

% ---- 持续动画（关窗口自动退出）----
t0 = tic;
while isvalid(earth) && isvalid(moon)
    t = toc(t0);
    alpha = we*t;    % 地球自转角
    theta = wmo*t;   % 月球公转角（= 自转角，潮汐锁定）

    % 绕 Z 轴旋转公式：x' = x*cos - y*sin, y' = x*sin + y*cos, z 不变
    % 地球：绕 Z 轴自转（自转轴 = 南北极轴）
    ex = Ex0*cos(alpha) - Ey0*sin(alpha);
    ey = Ex0*sin(alpha) + Ey0*cos(alpha);
    ez = Ez0;

    % 月球：先绕自身轴自转（潮汐锁定，角度 = 公转角）
    mx = Mx0*cos(theta) - My0*sin(theta);
    my = Mx0*sin(theta) + My0*cos(theta);
    mz = Mz0;
    % 再绕地球公转：轨道中心 (R*cosθ, R*sinθ, 0)，平移过去（z 不变）
    mx = mx + R*cos(theta);
    my = my + R*sin(theta);

    set(earth, 'XData', ex, 'YData', ey, 'ZData', ez);
    set(moon,  'XData', mx, 'YData', my, 'ZData', mz);
    drawnow; pause(0.02);
end
