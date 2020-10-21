function plate=plate_generator(direc2direc,DIRECTION)
for j=1:direc2direc
    INITIAL = randi([65,90]); %ASCII  A to Z
    PLATE = randi([1,36],1,5); % 0 to 9 , A to Z
    for i = 1 : 5 
        if PLATE(i)<=10
            PLATE(i)=PLATE(i)+47;
        else 
            PLATE(i)=PLATE(i)+54;
        end
    end
    plate(j)=string(char([INITIAL,32,PLATE]));
end
end