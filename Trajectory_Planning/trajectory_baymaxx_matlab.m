clear; clc; close all;

%% =========================================================
%% PARAMETER ROBOT
%% =========================================================
m = 2.4;
r = 0.035;
L = 0.25;
CPR = 500;
Ts = 0.01;
g = 9.81;

Jz = (1/12)*m*(L^2 + 0.30^2);
ee_offset = 0.12;

%% =========================================================
%% PARAMETER KOMPETISI
%% =========================================================
We = 100;
Wt = 1;

%% =========================================================
%% PARAMETER TRACK
%% =========================================================
d1 = 0.50;
d2 = 0.75;
dup = 1.00;

alpha_peak_deg = 150;
beta_deg = (180 - alpha_peak_deg)/2;
beta = deg2rad(beta_deg);

%% =========================================================
%% FINISHING LINE
%% =========================================================
finish_y = d2 + dup*cos(beta) + 0.5*cos(beta);
finish_z = dup*sin(beta) - 0.5*sin(beta);

y_robot_target = finish_y - ee_offset;
ddown_robot = (y_robot_target - (d2 + dup*cos(beta))) / cos(beta);

if ddown_robot < 0
    error('Hasil target turunan negatif. Cek ee_offset atau geometri lintasan.');
end
if ddown_robot > 1.0
    error('Robot harus turun lebih dari 100 cm. Cek finishing line atau ee_offset.');
end

%% =========================================================
%% PARAMETER AGRESIVITAS
%% =========================================================
turn_aggr  = 2.20;
slope_aggr = 2.00;

d_preturn  = 0.10;
d_preslope = 0.18;

if d_preslope >= d2
    error('d_preslope harus lebih kecil dari d2');
end

d2_remain = d2 - d_preslope;

%% =========================================================
%% DURASI TIAP SEGMEN
%% =========================================================
T1  = 1.60;
T2a = 0.30;
T2b = 1.60 / turn_aggr;
T3  = 0.60;
T4a = 0.30;
T4b = 1.30 / slope_aggr;
T5  = 1.10;

%% =========================================================
%% FUNGSI QUINTIC
%% =========================================================
q   = @(tau) 10*tau.^3 - 15*tau.^4 + 6*tau.^5;
dq  = @(tau) 30*tau.^2 - 60*tau.^3 + 30*tau.^4;
ddq = @(tau) 60*tau - 180*tau.^2 + 120*tau.^3;

%% =========================================================
%% SEGMENT 1: MAJU LURUS AWAL
%% =========================================================
t1 = 0:Ts:T1; tau1 = t1/T1;
x1 = q(tau1) * d1;
y1 = zeros(size(t1));
z1 = zeros(size(t1));
theta1 = zeros(size(t1));
v1 = dq(tau1) * (d1/T1);
a1 = ddq(tau1) * (d1/T1^2);
omega1 = zeros(size(t1));
alpha1 = zeros(size(t1));

%% =========================================================
%% SEGMENT 2A: PRE-TURN APPROACH
%% =========================================================
t2a = 0:Ts:T2a; tau2a = t2a/T2a;
x2a = d1 + q(tau2a) * d_preturn;
y2a = zeros(size(t2a));
z2a = zeros(size(t2a));
theta2a = zeros(size(t2a));
v2a = dq(tau2a) * (d_preturn/T2a);
a2a = ddq(tau2a) * (d_preturn/T2a^2);
omega2a = zeros(size(t2a));
alpha2a = zeros(size(t2a));

%% =========================================================
%% SEGMENT 2B: BELOK KIRI 90 DEG
%% =========================================================
t2b = 0:Ts:T2b; tau2b = t2b/T2b;
x2b = ones(size(t2b)) * (d1 + d_preturn);
y2b = zeros(size(t2b));
z2b = zeros(size(t2b));
theta2b = q(tau2b) * (pi/2);
v2b = zeros(size(t2b));
a2b = zeros(size(t2b));
omega2b = dq(tau2b) * ((pi/2)/T2b);
alpha2b = ddq(tau2b) * ((pi/2)/T2b^2);

%% =========================================================
%% SEGMENT 3: MAJU SETELAH BELOK
%% =========================================================
t3 = 0:Ts:T3; tau3 = t3/T3;
x3 = ones(size(t3)) * (d1 + d_preturn);
y3 = q(tau3) * d2_remain;
z3 = zeros(size(t3));
theta3 = ones(size(t3)) * (pi/2);
v3 = dq(tau3) * (d2_remain/T3);
a3 = ddq(tau3) * (d2_remain/T3^2);
omega3 = zeros(size(t3));
alpha3 = zeros(size(t3));

%% =========================================================
%% SEGMENT 4A: PRE-SLOPE BOOST
%% =========================================================
t4a = 0:Ts:T4a; tau4a = t4a/T4a;
x4a = ones(size(t4a)) * (d1 + d_preturn);
y4a = d2_remain + q(tau4a) * d_preslope;
z4a = zeros(size(t4a));
theta4a = ones(size(t4a)) * (pi/2);
v4a = dq(tau4a) * (d_preslope/T4a);
a4a = ddq(tau4a) * (d_preslope/T4a^2);
omega4a = zeros(size(t4a));
alpha4a = zeros(size(t4a));

%% =========================================================
%% SEGMENT 4B: TANJAKAN
%% =========================================================
t4b = 0:Ts:T4b; tau4b = t4b/T4b;
s4b = q(tau4b) * dup;

x4b = ones(size(t4b)) * (d1 + d_preturn);
y4b = d2 + s4b*cos(beta);
z4b = s4b*sin(beta);
theta4b = ones(size(t4b)) * (pi/2);
v4b = dq(tau4b) * (dup/T4b);
a4b = ddq(tau4b) * (dup/T4b^2);
omega4b = zeros(size(t4b));
alpha4b = zeros(size(t4b));

%% =========================================================
%% SEGMENT 5: TURUN OTOMATIS
%% =========================================================
t5 = 0:Ts:T5; tau5 = t5/T5;
s5 = q(tau5) * ddown_robot;

x5 = ones(size(t5)) * (d1 + d_preturn);
y5 = d2 + dup*cos(beta) + s5*cos(beta);
z5 = dup*sin(beta) - s5*sin(beta);
theta5 = ones(size(t5)) * (pi/2);
v5 = dq(tau5) * (ddown_robot/T5);
a5 = ddq(tau5) * (ddown_robot/T5^2);
omega5 = zeros(size(t5));
alpha5 = zeros(size(t5));

%% =========================================================
%% GABUNG SEMUA SEGMEN
%% =========================================================
n1  = length(t1);
n2a = length(t2a) - 1;
n2b = length(t2b) - 1;
n3  = length(t3)  - 1;
n4a = length(t4a) - 1;
n4b = length(t4b) - 1;
n5  = length(t5)  - 1;

idx_seg1_start  = 1;                       idx_seg1_end  = n1;
idx_seg2a_start = idx_seg1_end + 1;        idx_seg2a_end = idx_seg2a_start + n2a - 1;
idx_seg2b_start = idx_seg2a_end + 1;       idx_seg2b_end = idx_seg2b_start + n2b - 1;
idx_seg3_start  = idx_seg2b_end + 1;       idx_seg3_end  = idx_seg3_start  + n3  - 1;
idx_seg4a_start = idx_seg3_end + 1;        idx_seg4a_end = idx_seg4a_start + n4a - 1;
idx_seg4b_start = idx_seg4a_end + 1;       idx_seg4b_end = idx_seg4b_start + n4b - 1;
idx_seg5_start  = idx_seg4b_end + 1;       idx_seg5_end  = idx_seg5_start  + n5  - 1;

t2as = t2a(2:end) + t1(end);
t2bs = t2b(2:end) + t2as(end);
t3s  = t3(2:end)  + t2bs(end);
t4as = t4a(2:end) + t3s(end);
t4bs = t4b(2:end) + t4as(end);
t5s  = t5(2:end)  + t4bs(end);

t_all     = [t1, t2as, t2bs, t3s, t4as, t4bs, t5s];
x_all     = [x1, x2a(2:end), x2b(2:end), x3(2:end), x4a(2:end), x4b(2:end), x5(2:end)];
y_all     = [y1, y2a(2:end), y2b(2:end), y3(2:end), y4a(2:end), y4b(2:end), y5(2:end)];
z_all     = [z1, z2a(2:end), z2b(2:end), z3(2:end), z4a(2:end), z4b(2:end), z5(2:end)];
theta_all = [theta1, theta2a(2:end), theta2b(2:end), theta3(2:end), theta4a(2:end), theta4b(2:end), theta5(2:end)];
v_all     = [v1, v2a(2:end), v2b(2:end), v3(2:end), v4a(2:end), v4b(2:end), v5(2:end)];
a_all     = [a1, a2a(2:end), a2b(2:end), a3(2:end), a4a(2:end), a4b(2:end), a5(2:end)];
omega_all = [omega1, omega2a(2:end), omega2b(2:end), omega3(2:end), omega4a(2:end), omega4b(2:end), omega5(2:end)];
alpha_all = [alpha1, alpha2a(2:end), alpha2b(2:end), alpha3(2:end), alpha4a(2:end), alpha4b(2:end), alpha5(2:end)];

%% =========================================================
%% KONVERSI KE RODA
%% =========================================================
vL = v_all - (L/2)*omega_all;
vR = v_all + (L/2)*omega_all;

wL = vL / r;
wR = vR / r;

aL = a_all - (L/2)*alpha_all;
aR = a_all + (L/2)*alpha_all;

%% =========================================================
%% ESTIMASI GAYA, TORSI, POWER
%% =========================================================
grade_force = zeros(size(t_all));

idx_slope_up   = (t_all >= t4bs(1)) & (t_all <= t4bs(end));
idx_slope_down = (t_all >= t5s(1))  & (t_all <= t5s(end));

grade_force(idx_slope_up)   =  m*g*sin(beta);
grade_force(idx_slope_down) = -m*g*sin(beta);

F_total = m*a_all + grade_force;
F_wheel = F_total / 2;

tau_trans = F_wheel * r;
tau_yaw_each = (Jz * alpha_all / L) * r;

tauL = tau_trans - tau_yaw_each;
tauR = tau_trans + tau_yaw_each;

PL = tauL .* wL;
PR = tauR .* wR;

%% =========================================================
%% ENCODER REFERENCE
%% =========================================================
distL = vL * Ts;
distR = vR * Ts;

countIncL = distL/(2*pi*r) * CPR;
countIncR = distR/(2*pi*r) * CPR;

countRefL = cumsum(countIncL);
countRefR = cumsum(countIncR);

%% =========================================================
%% POSISI END EFFECTOR
%% =========================================================
x_ee = x_all + ee_offset .* cos(theta_all);
y_ee = y_all + ee_offset .* sin(theta_all);
z_ee = z_all;

%% =========================================================
%% HASIL AKHIR
%% =========================================================
x_final = x_all(end);
y_final = y_all(end);
z_final = z_all(end);

x_ee_final = x_ee(end);
y_ee_final = y_ee(end);
z_ee_final = z_ee(end);

tol_mm = 1.0;
error_m = abs(finish_y - y_ee_final);
error_mm = error_m * 1000;

if y_ee_final <= finish_y + tol_mm/1000
    status = "QUALIFIED";
else
    status = "DISQUALIFIED";
end

travel_time_s = t_all(end);
performance_index = (error_mm * We) + (travel_time_s * Wt);
h_peak = dup*sin(beta);

[max_v, idx_max_v] = max(v_all);
[max_omega, idx_max_omega] = max(abs(omega_all));
[max_tauL, idx_max_tauL] = max(abs(tauL));
[max_tauR, idx_max_tauR] = max(abs(tauR));
[max_PL, idx_max_PL] = max(abs(PL));
[max_PR, idx_max_PR] = max(abs(PR));

%% =========================================================
%% INFO HASIL
%% =========================================================
fprintf('====================================================\n');
fprintf('TRAJECTORY SUMMARY - CASE A\n');
fprintf('====================================================\n');
fprintf('Total samples / trajLength    = %d\n', length(t_all));
fprintf('Waktu total                   = %.2f s\n', travel_time_s);
fprintf('Sudut slope beta              = %.1f deg\n', beta_deg);
fprintf('Tinggi puncak                 = %.3f m\n', h_peak);
fprintf('----------------------------------------------------\n');
fprintf('Index Seg 1  lurus awal       = %d - %d\n', idx_seg1_start,  idx_seg1_end);
fprintf('Index Seg 2A pre-turn         = %d - %d\n', idx_seg2a_start, idx_seg2a_end);
fprintf('Index Seg 2B belok            = %d - %d\n', idx_seg2b_start, idx_seg2b_end);
fprintf('Index Seg 3  lurus stl turn   = %d - %d\n', idx_seg3_start,  idx_seg3_end);
fprintf('Index Seg 4A pre-slope        = %d - %d\n', idx_seg4a_start, idx_seg4a_end);
fprintf('Index Seg 4B tanjakan         = %d - %d\n', idx_seg4b_start, idx_seg4b_end);
fprintf('Index Seg 5  turunan          = %d - %d\n', idx_seg5_start,  idx_seg5_end);
fprintf('----------------------------------------------------\n');
fprintf('Final EE y                    = %.3f m\n', y_ee_final);
fprintf('Error akhir                   = %.3f mm\n', error_mm);
fprintf('Status run                    = %s\n', status);
fprintf('Performance Index             = %.2f\n', performance_index);
fprintf('Peak linear velocity          = %.3f m/s\n', max_v);
fprintf('Peak angular velocity         = %.3f rad/s\n', max_omega);
fprintf('Peak torque L / R             = %.4f / %.4f N.m\n', max_tauL, max_tauR);
fprintf('Peak power L / R              = %.4f / %.4f W\n', max_PL, max_PR);
fprintf('Encoder akhir L / R           = %.1f / %.1f count\n', countRefL(end), countRefR(end));
fprintf('====================================================\n');

%% =========================================================
%% PLOT 1: 3D TRAJECTORY
%% =========================================================
figure('Name','3D Trajectory','Color','w');
plot3(x_all, y_all, z_all, 'b-', 'LineWidth', 2.5); hold on;
plot3(x_ee, y_ee, z_ee, '--', 'Color', [0.85 0.33 0.10], 'LineWidth', 2.2);

grid on;
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
title('3D Trajectory','FontWeight','bold');
legend('Robot Path','End Effector Path','Location','best');
view(35,25);
axis equal;

%% =========================================================
%% PLOT 2: SIDE VIEW ELEVATION
%% =========================================================
figure('Name','Side View Trajectory','Color','w');
plot(y_all, z_all, 'b-', 'LineWidth', 2.5); hold on;
plot(y_ee, z_ee, '--', 'Color', [0.85 0.33 0.10], 'LineWidth', 2.2);
plot([finish_y finish_y], [0 0.30], 'r--', 'LineWidth', 2.5);

grid on;
xlabel('Forward Direction y (m)');
ylabel('Height z (m)');
title('Side View Trajectory (Elevation)','FontWeight','bold');
legend('Robot Path','End Effector Path','Finishing Line','Location','best');
xlim([0 finish_y+0.25]);
ylim([0 0.35]);

%% =========================================================
%% PLOT 3: TOP VIEW TRAJECTORY
%% =========================================================
figure('Name','Top View Trajectory','Color','w');
plot(x_all, y_all, 'b-', 'LineWidth', 2.5); hold on;
plot(x_ee, y_ee, '--', 'Color', [0.85 0.33 0.10], 'LineWidth', 2.2);
plot([min(x_all)-0.3, max(x_all)+0.3], [finish_y finish_y], 'r--', 'LineWidth', 2.5);

plot(x_final, y_final, 'ko', 'MarkerFaceColor','k', 'MarkerSize', 7);
plot(x_ee_final, y_ee_final, 'ro', 'MarkerFaceColor','r', 'MarkerSize', 7);

grid on;
axis equal;
xlabel('x (m)');
ylabel('y (m)');
title('Top View Trajectory with Auto-Adjusted Stop','FontWeight','bold');
legend('Robot Ref Point','End Effector Path','Finishing Line', ...
       'Final Robot Pos','Final EE Pos','Location','best');

%% =========================================================
%% PLOT 4: TRAJECTORY PROFILE 3 GRAFIK DALAM 1 GAMBAR
%% =========================================================
figure('Name','Trajectory Profile','Color','w');

subplot(3,1,1);
plot(t_all, y_all, 'k-', 'LineWidth', 2);
grid on;
ylabel('Position y (m)');
title('Trajectory Profile','FontWeight','bold');

subplot(3,1,2);
plot(t_all, v_all, 'k-', 'LineWidth', 2);
grid on;
ylabel('Velocity (m/s)');

subplot(3,1,3);
plot(t_all, a_all, 'k-', 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

%% =========================================================
%% PLOT 5: WHEEL VELOCITY REFERENCE
%% =========================================================
figure('Name','Wheel Velocity Reference','Color','w');
plot(t_all, vL, 'LineWidth', 1.5); hold on;
plot(t_all, vR, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Wheel Velocity (m/s)');
legend('v_L','v_R','Location','best');
title('Wheel Velocity Reference');

%% =========================================================
%% PLOT 6: ENCODER REFERENCE
%% =========================================================
figure('Name','Encoder Reference','Color','w');
plot(t_all, countRefL, 'LineWidth', 1.5); hold on;
plot(t_all, countRefR, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Encoder Counts');
legend('Left','Right','Location','best');
title('Encoder Reference');

%% =========================================================
%% EXPORT CSV
%% =========================================================
trajTable = table( ...
    t_all(:), x_all(:), y_all(:), z_all(:), ...
    x_ee(:), y_ee(:), z_ee(:), ...
    rad2deg(theta_all(:)), ...
    v_all(:), a_all(:), omega_all(:), alpha_all(:), ...
    vL(:), vR(:), wL(:), wR(:), ...
    tauL(:), tauR(:), PL(:), PR(:), ...
    countRefL(:), countRefR(:), ...
    'VariableNames', {'time_s','x_m','y_m','z_m', ...
                      'xEE_m','yEE_m','zEE_m','heading_deg', ...
                      'v_body_mps','a_body_mps2','omega_body_radps','alpha_body_radps2', ...
                      'vL_mps','vR_mps','wL_radps','wR_radps', ...
                      'tauL_Nm','tauR_Nm','PL_W','PR_W', ...
                      'countRefL','countRefR'});

writetable(trajTable, 'trajectory_caseA_fast.csv');

%% =========================================================
%% EXPORT trajectory_arrays.h UNTUK ARDUINO
%% =========================================================
fid = fopen('trajectory_arrays.h','w');

fprintf(fid, '// AUTO-GENERATED dari MATLAB. Jangan edit manual.\n');
fprintf(fid, '#ifndef TRAJECTORY_ARRAYS_H\n');
fprintf(fid, '#define TRAJECTORY_ARRAYS_H\n\n');
fprintf(fid, '#include <avr/pgmspace.h>\n\n');

fprintf(fid, 'const unsigned int Ts_ms     = %d;\n', round(Ts*1000));
fprintf(fid, 'const int trajLength = %d;\n\n', length(t_all));

fprintf(fid, '// Index batas segmen 0-based untuk Arduino\n');
fprintf(fid, 'const int IDX_SEG1_START  = %d;\n', idx_seg1_start  - 1);
fprintf(fid, 'const int IDX_SEG1_END    = %d;\n', idx_seg1_end    - 1);
fprintf(fid, 'const int IDX_SEG2A_START = %d;\n', idx_seg2a_start - 1);
fprintf(fid, 'const int IDX_SEG2A_END   = %d;\n', idx_seg2a_end   - 1);
fprintf(fid, 'const int IDX_SEG2B_START = %d;\n', idx_seg2b_start - 1);
fprintf(fid, 'const int IDX_SEG2B_END   = %d;\n', idx_seg2b_end   - 1);
fprintf(fid, 'const int IDX_SEG3_START  = %d;\n', idx_seg3_start  - 1);
fprintf(fid, 'const int IDX_SEG3_END    = %d;\n', idx_seg3_end    - 1);
fprintf(fid, 'const int IDX_SEG4A_START = %d;\n', idx_seg4a_start - 1);
fprintf(fid, 'const int IDX_SEG4A_END   = %d;\n', idx_seg4a_end   - 1);
fprintf(fid, 'const int IDX_SEG4B_START = %d;\n', idx_seg4b_start - 1);
fprintf(fid, 'const int IDX_SEG4B_END   = %d;\n', idx_seg4b_end   - 1);
fprintf(fid, 'const int IDX_SEG5_START  = %d;\n', idx_seg5_start  - 1);
fprintf(fid, 'const int IDX_SEG5_END    = %d;\n\n', idx_seg5_end  - 1);

fprintf(fid, 'const long countRefL[] PROGMEM = {\n');
for i = 1:length(countRefL)
    fprintf(fid, '%ld', round(countRefL(i)));
    if i < length(countRefL)
        fprintf(fid, ',');
    end
    if mod(i,10)==0
        fprintf(fid, '\n');
    end
end
fprintf(fid, '\n};\n\n');

fprintf(fid, 'const long countRefR[] PROGMEM = {\n');
for i = 1:length(countRefR)
    fprintf(fid, '%ld', round(countRefR(i)));
    if i < length(countRefR)
        fprintf(fid, ',');
    end
    if mod(i,10)==0
        fprintf(fid, '\n');
    end
end
fprintf(fid, '\n};\n\n');

fprintf(fid, '#endif\n');
fclose(fid);

disp('File trajectory_caseA_fast.csv dan trajectory_arrays.h berhasil disimpan.');