function output=test_crash(x0,y0,x1,y1)
    H_CAR_LENG = 2; %the size of the car(see from right to left)
    H_CAR_WID = 1;
    if (x0<x1+H_CAR_WID) && (y0<y1+H_CAR_LENG) && (x0+H_CAR_LENG>x1) && (y0+H_CAR_WID>y1)
        output = 1;
    else 
        output= 0;
    end
end