%%
%straight line
%fileID = fopen('train.txt','w');
%fileID = fopen('val.txt','w');
fileID = fopen('vis.txt','w');
mvx = 22;
mvy = 22;
mvz = 9;

for i = 1 : 50 %trajectory number
    if mod(i,4) == 0
    state = [400 + 40*(rand()-0.5) , 400 + 40*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,4) == 1
    state = [-400 + 40*(rand()-0.5) , 400 + 40*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,4) == 2
    state = [400 + 40*(rand()-0.5) , -400 + 40*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,4)==3
    state = [-400 + 40*(rand()-0.5) , -400 + 40*(rand()-0.5), 140 + 15*(rand()-0.5)];
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
        state(3) = state(3) + zv;
        
        fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t + 20*i,i,state(1),state(2),state(3));
        %historyx(t) =  state(1);
        %historyy(t) =state(2);
        %historyz(t) =state(3);
    end
    %figure(i)
    %scatter3(historyx, historyy, historyz)
end
fclose(fileID);
%%
%land vertical
fileID = fopen('train.txt','w');
%fileID = fopen('val.txt','w');
%fileID = fopen('vis.txt','w');
destination = [0, 0, 0];
mvx = 22;
mvy = 22;
mvz = 9;

for i = 1 : 8 %trajectory number
    if mod(i,4) == 0
    state = [200 + 20*(rand()-0.5) , 200 + 20*(rand()-0.5), 75 + 7*(rand()-0.5)];
    elseif mod(i,4) == 1
    state = [-200 + 20*(rand()-0.5) , 200 + 20*(rand()-0.5), 75 + 7*(rand()-0.5)];
    elseif mod(i,4) == 2
    state = [200 + 20*(rand()-0.5) , -200 + 20*(rand()-0.5), 75 + 7*(rand()-0.5)];
    elseif mod(i,4)==3
    state = [-200 + 20*(rand()-0.5) , -200 + 20*(rand()-0.5), 75 + 7*(rand()-0.5)]; 
    end
    destination = [0, 0, state(3)];
    for t = 1 : 10
        vb = (destination - state)/(11 - t);
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
        state(3) = state(3) + zv;
        
        fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t + 20*i,i,state(1),state(2),state(3));
        historyx(t) =  state(1);
        historyy(t) =state(2);
        historyz(t) =state(3);
    end
    destination = [0, 0, 0];
    for t = 11 : 20
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
        state(3) = state(3) + zv;
        
        fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t + 20*i,i,state(1),state(2),state(3));
        historyx(t) =  state(1);
        historyy(t) =state(2);
        historyz(t) =state(3);
    end
    figure(i)
    scatter3(historyx, historyy, historyz)
end
fclose(fileID);

