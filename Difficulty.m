function [LA_WID,car_num,p,g,o,r]=Difficulty(diff,o_24)
switch diff
    case "Dies without regrets"
        LA_WID=5;car_num=20;p=0.7;g=2;o=1;r=6;
        disp('Please wait for a while.')
    case "Hard"
        LA_WID=4;car_num=15;p=0.5;g=3;o=2;r=7;
    case "Normal"
        LA_WID=3;car_num=10;p=0.3;g=5;o=5;r=7;
    case "Easy"
        LA_WID=2;car_num=5;p=0.1;g=6;o=10;r=7;
    otherwise
        disp('Not a vaild number,please input the number by yourself.')
        LA_WID = input('Please input the width of one lane.(Width of cars are 1)');
        car_num = input('Please input the total number of cars(must be larger than 4):');
        fprintf("Please input the probability that a car doesn't stop when traffic lights are red:\n")
        p=input('range from 0.000 to 1.000 (e.g. 0.875 0.100):');
        disp("The traffic lights you control are on the right up and left down.");
        fprintf("The duration of the red light should be longer than %d seconds.\n",o_24);
        g = input('Please set the seconds traffic light is green.');
        o = input('Please set the seconds traffic light is orange.');
        r = input('Please set the seconds traffic light is red.(must be larger than 5)'); 
end