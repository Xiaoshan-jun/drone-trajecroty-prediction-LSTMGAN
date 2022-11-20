%fileID = fopen('train.txt','w');
%fileID = fopen('val.txt','w');
fileID = fopen('vis.txt','w');
for i = 1 : 50
    state = [0 , 0, 0];
    for t = 1 : 15
        xv = 10/15 + rand() - 0.5;
        yv = 10/15 + rand() - 0.5;
        zv = 10/15 + rand() - 0.5;
        state(1) = state(1) + xv;
        state(2) = state(2) + yv;
        state(3) = state(3) + zv;
        fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',t + 16*i,i,state(1),state(2),state(3));
    end
    fprintf(fileID,'%4.2f\t%i\t%4.4f\t%4.4f\t%4.4f\n',16 + 16*i,i,10,10,10);
end
    
fclose(fileID);
%%

