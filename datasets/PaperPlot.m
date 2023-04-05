filename = sprintf('realdata2/flightdata%d.csv', 0);
T = readtable(filename);
T = table2array(T);
historyx = [];
historyy =[];
historyz =[];
figure(1)
i = 1;
for k = 1:size(T)
    r = rem( k , 100 )
    if r ~= 0
        continue
    else
        historyx(i) = T(k, 2);
        historyy(i) = T(k, 3);
        historyz(i) = T(k, 4);
         i = i + 1;
    end
end
hf = floor(length(historyx)/2);
hf = hf(1);
%scatter3(historyx, historyy, historyz)
plot3(historyx(1:hf), historyy(1:hf), historyz(1:hf), 'r-','DisplayName', 'Past Trajectory Ground Truth')
hold on
plot3(historyx(hf:length(historyx)), historyy(hf:length(historyx)), historyz(hf:length(historyx)), 'b-', 'DisplayName', 'Future Trajectory Ground Truth')
title("Future Trajectory", 'FontSize', 14)
xlabel('x', 'FontSize', 14)
ylabel('y', 'FontSize', 14)
zlabel('z', 'FontSize', 14)
grid on
xlim([-0.1 0.3])
ylim([-0 1.5])
zlim([-0.1 2])
historyx = [];
historyy =[];
historyz =[];
figure(1)
i = 1;
for k = 1:size(T)
    r = rem( k , 100 );
    if r ~= 0
        continue
    else
        historyx(i) = T(k, 2) + 0.1*(rand() - 0.5);
        historyy(i) = T(k, 3) + 0.1*(rand() - 0.5);
        historyz(i) = T(k, 4) + 0.1*(rand() - 0.5);
        i = i + 1;
    end
end
hf = floor(length(historyx)/2);
hf = hf(1);
%scatter3(historyx, historyy, historyz)
plot3(historyx(1:hf), historyy(1:hf), historyz(1:hf), 'or:','DisplayName', 'Past Trajectory Sensored')
% plot3(historyx(hf:length(historyx)), historyy(hf:length(historyx)), historyz(hf:length(historyx)), 'ob:', 'DisplayName', 'Future Trajectory Sensored')
legend('location', 'Best');
print(gcf,'Trajectory predicting2','-dpng','-r900');
%%
% Define the system's equations of motion
f = @(t,x) [x(2); -x(1) + x(2)^2; x(3)];

% Define the time horizon
T = 5;

% Define the range of initial conditions
x_range = [-1, 1];
y_range = [-1, 1];
z_range = [-1, 1];

% Define the number of grid points in each dimension
n = 20;

% Create a 3D grid of initial conditions
[x0, y0, z0] = meshgrid(linspace(x_range(1), x_range(2), n), ...
                        linspace(y_range(1), y_range(2), n), ...
                        linspace(z_range(1), z_range(2), n));
x0 = reshape(x0, [1, n^3]);
y0 = reshape(y0, [1, n^3]);
z0 = reshape(z0, [1, n^3]);

% Integrate the system for each initial condition
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
[t, x] = arrayfun(@(x0,y0,z0) ode45(f, [0, T], [x0;y0;z0], options), x0, y0, z0, 'UniformOutput', false);

% Extract the final positions of each trajectory
x_end = cellfun(@(x) x(end,1), x);
y_end = cellfun(@(x) x(end,2), x);
z_end = cellfun(@(x) x(end,3), x);

% Plot the reachable set
figure;
scatter3(x_end, y_end, z_end, '.', 'MarkerFaceColor', 'b')
title('3D Reachable Set')
xlabel('x')
ylabel('y')
zlabel('z')
%%
%ld = load("drivingLidarPoint.mat");
filename = sprintf('realdata2/flightdata%d.csv', 0);
T = readtable(filename);
T = table2array(T);
historyx = [];
historyy =[];
historyz =[];
figure(1)
i = 1;
for k = 1:size(T)
    r = rem( k , 100 )
    if r ~= 0
        continue
    else
        historyx(i) = T(k, 2);
        historyy(i) = T(k, 3);
        historyz(i) = T(k, 4);
         i = i + 1;
    end
end
hf = floor(length(historyx)/2);
hf = hf(1);
%scatter3(historyx, historyy, historyz)
title("Future Trajectory", 'FontSize', 14)
xlabel('x', 'FontSize', 14)
ylabel('y', 'FontSize', 14)
zlabel('z', 'FontSize', 14)
grid on
xlim([-0.1 0.3])
ylim([-0 1.5])
zlim([-0.1 2])
historyx = [];
historyy =[];
historyz =[];
figure(1)
i = 1;
for k = 1:size(T)
    r = rem( k , 100 );
    if r ~= 0
        continue
    else
        historyx(i) = T(k, 2) + 0.1*(rand() - 0.5);
        historyy(i) = T(k, 3) + 0.1*(rand() - 0.5);
        historyz(i) = T(k, 4) + 0.1*(rand() - 0.5);
        i = i + 1;
    end
end

%scatter3(historyx, historyy, historyz)
% plot3(historyx(hf:length(historyx)), historyy(hf:length(historyx)), historyz(hf:length(historyx)), 'ob:', 'DisplayName', 'Future Trajectory Sensored')
%legend('location', 'Best');
%print(gcf,'Trajectory predicting2','-dpng','-r900');
% Set up a set of 3D points
points = randn(100,3);
points = [transpose(historyx), transpose(historyy), transpose(historyz)];
% Compute the convex hull using the convhulln function
K = convhulln(points);

% Generate a mesh using the vertices and faces of the convex hull
vertices = points;
faces = K;
trisurf(faces, vertices(:,1), vertices(:,2), vertices(:,3));

