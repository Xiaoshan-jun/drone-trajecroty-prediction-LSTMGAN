%%
%straight line
%fileID = fopen('datasets/linear/train/train.txt','w');
%fileID = fopen('datasets/linear/val/val.txt','w');
%fileID = fopen('datasets/linear/vis/vis.txt','w');
fileID = fopen('plot.txt','w');
mvx = 22; %max horizontal speed
mvy = 22; %max horizontal speed
mvz = 9;  %max descend speed

for i = 1 : 4 %trajectory number
    if mod(i,4) == 0
    state = [400 + 200*(rand()-0.5) , 400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,4) == 1
    state = [-400 + 200*(rand()-0.5) , 400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,4) == 2
    state = [400 + 200*(rand()-0.5) , -400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,4)==3
    state = [-400 + 200*(rand()-0.5) , -400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    end
    destination = [0, 0, 0];
    for t = 1 : 20
        vb = (destination - state)/(21 - t);
        if mod(i,4) == 0
        xv = max(-mvx , vb(1) + 15 * (rand() - 0.5));
        yv = max(-mvy, vb(2) + 15*(rand() - 0.5));
        elseif mod(i,4) == 1
        xv = min(mvx , vb(1) + 15 * (rand() - 0.5));
        yv = max(-mvy, vb(2) + 15*(rand() - 0.5));
        elseif mod(i,4) == 2
        xv = max(-mvx , vb(1) + 15 * (rand() - 0.5));
        yv = min(mvy, vb(2) + 15*(rand() - 0.5));
        elseif mod(i,4)==3
        xv = min(mvx , vb(1) + 15 * (rand() - 0.5));
        yv = min(mvy, vb(2) + 15*(rand() - 0.5));
        end

        zv = max(-mvz, vb(3) + 15*(rand() - 0.5));

        state(1) = state(1) + xv;
        state(2) = state(2) + yv;
        state(3) = max(state(3) + zv,0); % bound z above zero

        
        fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t + 20*(i-1),i,state(1),state(2),state(3));
        historyx(t) =  state(1);
        historyy(t) =state(2);
        historyz(t) =state(3);
    end
    figure(i)
    str = sprintf("direction %i", i);
    scatter3(historyx, historyy, historyz)
    plot3(historyx, historyy, historyz, 'o-')
    title(str, 'FontSize', 14)
    xlabel('x', 'FontSize', 14)
    ylabel('y', 'FontSize', 14)
    zlabel('z', 'FontSize', 14)
    hold on
    str = sprintf('linear%d.png', i);
    print(gcf,str,'-dpng','-r900'); 
end
fclose(fileID);
