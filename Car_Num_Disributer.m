function [UP2DO,DO2UP,LE2RI,RI2LE] = Car_Num_Disributer(car_num)
    UP_DO = randi([2,car_num-2]);
    LE_RI = car_num - UP_DO;
    UP2DO = randi([1,UP_DO-1]); %Cars from up to down
    DO2UP = UP_DO-UP2DO; %Cars from down to up
    LE2RI = randi([1,LE_RI-1]); %LEFT and RIGHT street cars
    RI2LE = LE_RI-LE2RI; %LEFT and RIGHT street cars
end