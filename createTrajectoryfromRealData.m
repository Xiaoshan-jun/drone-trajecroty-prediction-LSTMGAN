%fileID = fopen('datasets/real/train/train.txt','w');
%fileID = fopen('datasets/real/val/val.txt','w');
fileID = fopen('datasets/real/vis/vis.txt','w');
agentcount = 0;
t = 0;
for i = 11:14
    filename = sprintf('realdata/automatic/flightdata%d.csv', i);
    T = readtable(filename);
    a = size(T);
    tn = a(1)/20;
    tn = floor(tn);
    for j = 1 : floor(tn/2)
            historyx = [];
            historyy =[];
            historyz =[];
        for k = 1:10
            x = table2array(T(floor(k*tn*1.7) + j, 2));
            y = table2array(T(floor(k*tn*1.7) + j, 3));
            z = table2array(T(floor(k*tn*1.7) + j, 4));
            fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t,agentcount,x,y,z);
            t = t + 1;
            historyx(k) =  x;
            historyy(k) =y;
            historyz(k) =z;
        end
        for k = 1:9
            x = table2array(T(floor(18.2*tn) + floor(0.08*  k*tn) + j, 2));
            y = table2array(T(floor(18.2*tn) + floor(0.08*  k*tn) + j, 3));
            z = table2array(T(floor(18.2*tn) + floor(0.08*  k*tn) + j, 4));
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
%             figure(agentcount)
%             scatter3(historyx, historyy, historyz)
%             plot3(historyx, historyy, historyz, 'o-')
    end
end
fclose(fileID);
%%
clc
clear all
filename = sprintf('realdata/automatic/flightdata%d.csv', 17);
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

