%fileID = fopen('datasets/real/train/train.txt','w');
%fileID = fopen('datasets/real/val/val.txt','w');
%fileID = fopen('datasets/real/vis/vis.txt','w');
%fileID = fopen('plot.txt','w');
agentcount = 0;
t = 0;
aa = 17.2;
b = 0.1;
for i = 1:1
    filename = sprintf('realdata2/flightdata%d.csv', i);
    filename2 = sprintf('real2/train/train%i.txt', i);
    fileID = fopen(filename2,'w');
    %fileID = fopen('plot.txt','w');
    T = readtable(filename);
    a = size(T);
    tn = a(1)/20;
    tn = floor(tn);
    for j = 1 : tn
            historyx = [];
            historyy =[];
            historyz =[];
        for k = 1:20
            p = (k-1)*tn + j;
            x = table2array(T(floor(p), 2));
            y = table2array(T(floor(p), 3));
            z = table2array(T(floor(p), 4));
            fprintf(fileID,'%i\t%4.4f\t%4.4f\t%4.4f\n',t,x,y,z);
            t = t + 1;
            historyx(k) =  x;
            historyy(k) =y;
            historyz(k) =z;
        end
            figure(1)
            scatter3(historyx, historyy, historyz)
            plot3(historyx, historyy, historyz, 'o-')
            title("real landing", 'FontSize', 14)
            xlabel('x', 'FontSize', 14)
            ylabel('y', 'FontSize', 14)
            zlabel('z', 'FontSize', 14)
    end
end

% str = sprintf('real20.png');
% print(gcf,str,'-dpng','-r900'); 
fclose(fileID);
%%
clc
clear all
%filename = sprintf('realdata/automatic/flightdata%d.csv', 17);
filename = sprintf('realdata/flightdata%d.csv', 61);
T = readtable('realdata/flightdata0.csv');
a = size(T);

for i = 1:a
    x = table2array(T(i, 2));
    y = table2array(T(i, 3));
    z = table2array(T(i, 4));
    historyx(i) =  x;
    historyy(i) =y;
    historyz(i) =z;
end
figure(1)
scatter3(historyx, historyy, historyz)
plot3(historyx, historyy, historyz, 'o-')

