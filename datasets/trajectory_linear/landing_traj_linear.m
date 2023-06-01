%%
%straight line
fileID = fopen('train.txt','w');
%fileID = fopen('val.txt','w');

mvx = 25; %max horizontal speed
mvy = 25; %max horizontal speed
mvz = 9;  %max descend speed

for i = 0 : 239 %trajectory number
    if mod(i,8) == 0
    state = [400 + 200*(rand()-0.5) , 400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8) == 1
    state = [-400 + 200*(rand()-0.5) , 400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8) == 2
    state = [400 + 200*(rand()-0.5) , -400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8)== 3
    state = [200*(rand()-0.5) , 400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8) == 4
    state = [400 + 200*(rand()-0.5) , 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8) == 5
    state = [200*(rand()-0.5) , -400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8) == 6
    state = [-400 + 200*(rand()-0.5) , 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    elseif mod(i,8) == 7
    state = [-400 + 200*(rand()-0.5) , -400 + 200*(rand()-0.5), 140 + 15*(rand()-0.5)];
    end
    destination = [0, 0, 0];
    first = 1;        
%     filename = sprintf('val/testgt%d.txt', i);
%     fileID = fopen(filename,'w');
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
        if first == 1
            h = 'new';
            first = 0;
        elseif t <= 10
            h = 'past';
        else
            h = 'future';
        end
        fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, state(1),state(2),state(3));
        
        historyx(t) = state(1);
        historyy(t) = state(2);
        historyz(t) = state(3);
    end
    %disrupt
    for d = 1:10
%         filename = sprintf('val/testdisrupt%d.txt', 10*i + d);
%         fileID = fopen(filename,'w');
        for t = 1:10
            if t == 1
                h = 'new';
            elseif t <= 10
                h = 'past';
            else
                h = 'future';
            end
           newhistoryx = historyx(t);
           newhistoryy = historyy(t);
           newhistoryz = historyz(t);
           dt = 0.2 * (rand() - 0.5);
           dx = 5*(rand()-0.5);
           dy = 5*(rand()-0.5);
           dz = 0.5*(rand()-0.5);
           newhistoryx = newhistoryx + dx;
           newhistoryy = newhistoryy + dy;
           newhistoryz = newhistoryz + dz;
           fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, newhistoryx,newhistoryy,newhistoryz);
        end
        for t = 11:20
            if t == 1
                h = 'new';
            elseif t <= 10
                h = 'past';
            else
                h = 'future';
            end
           fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, historyx(t),historyy(t),historyz(t));
        end
    end

    %disruption with variable musk
for d = 1:10
%         filename = sprintf('val/testmusk%d.txt', 10*i + d);
%         fileID = fopen(filename,'w');
        for t = 1:10
            if t == 1
                h = 'new';
            elseif t <= 10
                h = 'past';
            else
                h = 'future';
            end
           newhistoryx = historyx(t);
           newhistoryy = historyy(t);
           newhistoryz = historyz(t);
           dt = 0.2 * (rand() - 0.5);
           dx = 5*(rand()-0.5);
           dy = 5*(rand()-0.5);
           dz = 0.5*(rand()-0.5);
           newhistoryx = newhistoryx + dx;
           if rand()< 0.1
               newhistoryx = newhistoryx + 10*dx;
           end
           newhistoryy = newhistoryy + dy;
           if rand()< 0.1
               newhistoryy = newhistoryy + 10*dy;
           end
           newhistoryz = newhistoryz + dz;
           if rand()< 0.1
               newhistoryz = newhistoryz + 10*dz;
           end
           
           fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, newhistoryx,newhistoryy,newhistoryz);
        end
        for t = 11:20
            if t == 1
                h = 'new';
            elseif t <= 10
                h = 'past';
            else
                h = 'future';
            end
           fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, historyx(t),historyy(t),historyz(t));
        end
    end
    %disruption with point missed
    for d = 1:10
%         filename = sprintf('val/testpointmusk%d.txt', 10*i + d);
%         fileID = fopen(filename,'w');
        for t = 1:10
            if t == 1
                h = 'new';
            elseif t <= 10
                h = 'past';
            else
                h = 'future';
            end
           newhistoryx = historyx(t);
           newhistoryy = historyy(t);
           newhistoryz = historyz(t);
           dt = 0.2 * (rand() - 0.5);
           dx = 5*(rand()-0.5);
           dy = 5*(rand()-0.5);
           dz = 0.5*(rand()-0.5);
           newhistoryx = newhistoryx + dx;
           if rand()< 0.1
               newhistoryx = newhistoryx + 10*dx;
           end
           newhistoryy = newhistoryy + dy;
           if rand()< 0.1
               newhistoryy = newhistoryy + 10*dy;
           end
           newhistoryz = newhistoryz + dz;
           if rand()< 0.1
               newhistoryz = newhistoryz + 10*dz;
           end
           if rand()> 0.15 || t == 1
                fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, newhistoryx,newhistoryy,newhistoryz);
           else
               fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h,newhistoryx+10*dx,newhistoryy+10*dy,newhistoryz+10*dz);
           end
        end
        for t = 11:20
            if t == 1
                h = 'new';
            elseif t <= 10
                h = 'past';
            else
                h = 'future';
            end
           fprintf(fileID,'%s\t%4.2f\t%4.2f\t%4.2f\n',h, historyx(t),historyy(t),historyz(t));
        end
    end
    figure(1)
    scatter3(historyx, historyy, historyz)
    plot3(historyx, historyy, historyz, 'o-')
    title('linear landing', 'FontSize', 14)
    xlabel('x', 'FontSize', 14)
    ylabel('y', 'FontSize', 14)
    zlabel('z', 'FontSize', 14)
    hold on
end
%str = sprintf('linear%d.png', i);
%print(gcf,str,'-dpng','-r900'); 
fclose(fileID);
points = [transpose(historyx), transpose(historyy), transpose(historyz)];
% Compute the convex hull using the convhulln function
K = convhulln(points);

% Generate a mesh using the vertices and faces of the convex hull
vertices = points;
faces = K;
trisurf(faces, vertices(:,1), vertices(:,2), vertices(:,3));
