%fileID = fopen('datasets/real/train/train.txt','w');
%fileID = fopen('datasets/real/val/val.txt','w');
%fileID = fopen('datasets/real/vis/vis.txt','w');
%fileID = fopen('plot.txt','w');
agentcount = 0;
t = 0;
aa = 18.9;
b = 0.1;
for i = 11:11
    filename = sprintf('realdata/automatic/flightdata%d.csv', i);
    filename2 = sprintf('datasets/real/train/train%i.txt', i);
    fileID = fopen(filename2,'w');
    T = readtable(filename);
    a = size(T);
    tn = a(1)/20;
    tn = floor(tn);
    for j = 1 : 40
            historyx = [];
            historyy =[];
            historyz =[];
        for k = 1:10
            p = max(1, floor(j + (rand() - 0.5)*20));
            x = table2array(T(floor(k*tn*1.5) + p, 2));
            y = table2array(T(floor(k*tn*1.5) + p, 3));
            z = table2array(T(floor(k*tn*1.5) + p, 4));
            fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t,agentcount,x,y,z);
            t = t + 1;
            historyx(k) =  x;
            historyy(k) =y;
            historyz(k) =z;
        end
        for k = 1:9
            p = max(1, floor(j + (rand() - 0.5)*20));
            x = table2array(T(floor(aa*tn) + floor(b*  k*tn) + p, 2));
            y = table2array(T(floor(aa*tn) + floor(b*  k*tn) + p, 3));
            z = table2array(T(floor(aa*tn) + floor(b*  k*tn) + p, 4));
            fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t,agentcount,x,y,z);
            t = t + 1;
            historyx(k + 10) =  x;
            historyy(k + 10) =y;
            historyz(k + 10) =z;
        end
            x = table2array(T(a(1), 2));
            y = table2array(T(a(1), 3));
            z = table2array(T(a(1), 4));
            fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t,agentcount,x,y,z);
            t = t + 1;
            agentcount = agentcount + 1;
            historyx(20) =  x;
            historyy(20) =y;
            historyz(20) =z;
            figure(1)
            scatter3(historyx, historyy, historyz)
            plot3(historyx, historyy, historyz, 'o-')
            title("real trajectory example 4", 'FontSize', 14)
            xlabel('x', 'FontSize', 14)
            ylabel('y', 'FontSize', 14)
            zlabel('z', 'FontSize', 14)
            str = sprintf('real4.png', i);
            if j == 35
                print(gcf,str,'-dpng','-r900'); 
            end
    end
end
fclose(fileID);
%%
clc
clear all
%filename = sprintf('realdata/automatic/flightdata%d.csv', 17);
filename = sprintf('realdata/manual/flightdata%d.csv', 2);
T = readtable(filename);
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

