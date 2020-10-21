%For more info,please read the README.txt
%%
clear
%define variables
%you can fold it to make program more clear
%you can look up variables meanings here
for i=1:1
    %define constant variables
    R = '#FF0000'; %red
    G = '#00FF00'; %green
    O = '#FF7F27'; %orange
    H_CAR_LENG = 2; %the size of the car(see from right to left)
    H_CAR_WID = 1;
    H_half_LEN = 0.5*H_CAR_LENG;  %horrizon half length for car horizon
    H_half_WID = 0.5*H_CAR_WID;
    CAR_INTERVAL = 2;%the interval between cars
    SPEED = 1;       %car speed
    LENG = 30;  %the length of the road for one side
    n = 1;      %temporarily set lane num n as 1
    o_24 = 5;    %the orange set which can't be controlled by users(README)
    %%
    %difficulty choise
    fprintf("Please choose the difficulty level:\n Dies without regrets  (Choose with caution if your computer is not powerful enough)\n Hard\n Normal\n Easy\n");
    diff=input('(If you want to input by yourself, please enter 0):','s');
    switch diff
        case '0'
    %users input variables
    LA_WID = input('Please input the width of one lane.(Width of cars are 1)');
    car_num = input('Please input the total number of cars(must be larger than 4):');
    fprintf("Please input the probability that a car doesn't stop when traffic lights are red:\n")
    p=input('range from 0.000 to 1.000 (e.g. 0.875 0.100):');
    disp("The traffic lights you control are on the right up and left down.");
    fprintf("The duration of the red light should be longer than %d seconds.\n",o_24);
    % g stands for the time of green lights
    % r stands for the time of red lights
    % o stands for the time of orange lights
    g = input('Please set the seconds traffic light is green.');
    o = input('Please set the seconds traffic light is orange.');
    r = input('Please set the seconds traffic light is red.(must be larger than 5)');  %the interaztion interface with users
        otherwise
            [LA_WID,car_num,p,g,o,r]=Difficulty(diff,o_24);
    end
    %%
    %claim variables based on the number users input
    %claim concerned variables(time of the lights)
    g_1 = r-o_24;  %the right down and the left up (time for trafficc lights)
    r_1 = g + o;   %the right down and the left up
    o_1 = o_24;    %the right down and the left up
    o_2 = o;       %the right up and the left down
    g_2 = g;       %the right up and the left down
    r_2 = r;       %the right up and the left down
    fps = 0.1;     %the refresh rate of the animation
    
    car_y_UP = LENG + 1.5*LA_WID; %the y coordinate for up left to right
    car_y_DO = LENG + 0.5*LA_WID; %the y coordinate for down right to left
    car_x_LE = 0; %the start for cars LE to RI
    car_x_RI = 2*LENG + 2*n*LA_WID; %the start for cars RI to LE
    V_car_y_LE = 2*LENG + 2*n*LA_WID; %the y coordinate for left lane up to down
    V_car_y_RI = 0; %the y coordinate for right lane
    V_car_x_UP = LENG + 0.5*LA_WID; %the x start for cars DO to UP right lane
    V_car_x_DO = LENG + 1.5*LA_WID; %the x start for cars UP to DOWN left lane
    
    DIS_L2R = car_x_LE; %Distance from left to right if cars never stop
    DIS_R2L = car_x_RI;
    DIS_U2D = V_car_y_LE; %Distance from up to down if cars never stop
    DIS_D2U = V_car_y_RI;
    
    %distribute car numbers on each lane
    [UP2DO,DO2UP,LE2RI,RI2LE] = Car_Num_Disributer(car_num);
    
    %distribute the plates
    plate_L2R = plate_generator(LE2RI,1);
    plate_R2L = plate_generator(RI2LE,1);
    plate_U2D = plate_generator(UP2DO,0);
    plate_D2U = plate_generator(DO2UP,0);
    
    %the real distance cars drives (distribute space in advance)
    %Because cars should stop at the red lights. So their
    %real distance (DIS_xxx_pro) will be smaller
    DIS_L2R_pro = zeros(1,LE2RI);
    DIS_R2L_pro = zeros(1,RI2LE);
    DIS_U2D_pro = zeros(1,UP2DO);
    DIS_D2U_pro = zeros(1,DO2UP);
    %the real distance cars drives
    
    %distribute the real distance for each car
    DIS_L2R_pro(1:LE2RI) = DIS_L2R; %the real distance cars drives LEFT to RIGHT
    DIS_R2L_pro(1:RI2LE) = DIS_R2L;
    DIS_U2D_pro(1:UP2DO) = DIS_U2D;
    DIS_D2U_pro(1:DO2UP) = DIS_D2U;
    
    %generate the probability that each car run a red light
    p_L2R=rand(1,LE2RI);
    p_R2L=rand(1,RI2LE);
    p_U2D=rand(1,UP2DO);
    p_D2U=rand(1,DO2UP);
end
%%
if r > o_24                     %in order to make the program run
    axis equal
    while true
        t0 = clock;%record the time a loop start
        clf        %to start a new image
        axis equal
        %%
        %To draw the image of the road.
        Road_Print(LENG,n,LA_WID);
        %%
        %change the color of 24(Right Down and Left Up)
        if g_1 > 0 %change the color of 24
            scatter(LENG,LENG + 2*n*LA_WID,100,'MarkerFaceColor',G);%LEFT UP2
            scatter(LENG + 2*n*LA_WID,LENG,100,'MarkerFaceColor',G);%RIGHT DOWN4
            g_1 = g_1 - fps;
        elseif o_1 > 0
            scatter(LENG,LENG + 2*n*LA_WID,100,'MarkerFaceColor',O);%LEFT UP2
            scatter(LENG + 2*n*LA_WID,LENG,100,'MarkerFaceColor',O);%RIGHT DOWN4
            o_1 = o_1 - fps;
        elseif r_1 > 0
            scatter(LENG,LENG + 2*n*LA_WID,100,'MarkerFaceColor',R);%LEFT UP2
            scatter(LENG + 2*n*LA_WID,LENG,100,'MarkerFaceColor',R);%RIGHT DOWN4
            r_1 = r_1 - fps;
        end
        if r_1 <= 0 %reset three numbers
            g_1 = r-o_24;
            r_1 = g + o;
            o_1 = o_24;
        end      %control the right down and the left up
        %%
        %change the color of 13(Left Down and Right Up)
        if r_2 > 0
            scatter(LENG,LENG,100,'MarkerFaceColor',R);%LEFT down1
            scatter(LENG + 2*n*LA_WID,LENG + 2*n*LA_WID,100,'MarkerFaceColor',R);%RIGHT UP3
            r_2 = r_2 - fps;
        elseif g_2 > 0
            scatter(LENG,LENG,100,'MarkerFaceColor',G);%LEFT down1
            scatter(LENG + 2*n*LA_WID,LENG + 2*n*LA_WID,100,'MarkerFaceColor',G);%RIGHT UP3
            g_2 = g_2 - fps;
        elseif o_2 > 0
            scatter(LENG,LENG,100,'MarkerFaceColor',O);%LEFT down1
            scatter(LENG + 2*n*LA_WID,LENG + 2*n*LA_WID,100,'MarkerFaceColor',O);%RIGHT UP3
            o_2 = o_2 - fps;
        end
        if o_2 <= 0 %reset the time
            o_2 = o;
            g_2 = g;
            r_2 = r;
        end
        %%
        %12 the detailed explanation of the four loop are in the first loop
        for i = 0:(LE2RI-1) % LEFT to RIGHT draws cars
            
            %to judge whether cars should stop and draw stopped cars
            if  fix(10*(DIS_L2R_pro(i+1) -i*(CAR_INTERVAL+H_CAR_LENG))) == fix(10*LENG)...
                    && p_L2R(i+1) < p %just before the traffic light
            elseif fix(10*(DIS_L2R_pro(i+1) -i*(CAR_INTERVAL+H_CAR_LENG))) == fix(10*LENG) && (g_2 <=0 || r_2>0.05)
                %the light is red and cars don't run a red light
                for j = (i+1):LE2RI
                    rectangle('Position',[(DIS_L2R_pro(i+1) -H_CAR_LENG- (j-1)*(CAR_INTERVAL+H_CAR_LENG)),...
                        car_y_DO - H_half_WID,...
                        H_CAR_LENG,H_CAR_WID],'FaceColor','#ED008D');% LEFT to RIGHT
                    hold on
                    
                    %print cars' plate
                    text((DIS_L2R_pro(i+1) -H_CAR_LENG- (j-1)*(CAR_INTERVAL+H_CAR_LENG)),...
                        car_y_DO - 2*H_half_WID,plate_L2R(i+1),'FontSize',6);
                    hold on
                end
                DIS_L2R_pro(1,i+1:LE2RI) = DIS_L2R_pro(1,i+1:LE2RI) - fps*SPEED;
                break;
            end
            
            %to let cars diappear at the end of the road
            if DIS_L2R_pro(i+1) <=2*LENG+2*n*LA_WID  %disappear
                rectangle('Position',[(DIS_L2R_pro(i+1) -H_CAR_LENG- i*(CAR_INTERVAL+H_CAR_LENG)),...
                    car_y_DO - H_half_WID,...
                    H_CAR_LENG,H_CAR_WID],'FaceColor','#ED008D');% LEFT to RIGHT
                hold on
                text((DIS_L2R_pro(i+1) -H_CAR_LENG- i*(CAR_INTERVAL+H_CAR_LENG)),...
                    car_y_DO - 2*H_half_WID,plate_L2R(i+1),'FontSize',6);
            end
        end
        
        for i = 0:(RI2LE-1) % RIGHT to LEFT draw cars
            if  fix(10*(DIS_R2L_pro(i+1) +i*(CAR_INTERVAL+H_CAR_LENG))) ...
                    == fix(10*(LENG+2*n*LA_WID))...
                    && p_R2L(i+1) < p %just before the traffic light
                %         break;
                %continue;
            elseif fix(10*(DIS_R2L_pro(i+1) +i*(CAR_INTERVAL+H_CAR_LENG))) ...
                    == fix(10*(LENG+2*n*LA_WID)) && (g_2 <=0 || r_2>0.05)
                for j = (i+1):RI2LE
                    rectangle('Position',[(DIS_R2L_pro(i+1) + (j-1)*(CAR_INTERVAL+H_CAR_LENG)),...
                        car_y_UP - H_half_WID,...
                        H_CAR_LENG,H_CAR_WID],'FaceColor','#00ADEF');% LEFT to RIGHT
                    hold on
                    text((DIS_R2L_pro(i+1) + (j-1)*(CAR_INTERVAL+H_CAR_LENG)),...
                        car_y_UP +2* H_half_WID,plate_R2L(i+1),'FontSize',6);
                end
                DIS_R2L_pro(1,i+1:RI2LE) = DIS_R2L_pro(1,i+1:RI2LE) + fps*SPEED;
                break;
            end
            if DIS_R2L_pro(i+1) >=0  %disappear
                rectangle('Position',[DIS_R2L_pro(i+1) + i*(CAR_INTERVAL+H_CAR_LENG),...
                    car_y_UP - H_half_WID,...
                    H_CAR_LENG,H_CAR_WID],'FaceColor','#00ADEF');% LEFT to RIGHT
                hold on
                text(DIS_R2L_pro(i+1) + i*(CAR_INTERVAL+H_CAR_LENG),...
                    car_y_UP +2*H_half_WID,plate_R2L(i+1),'FontSize',6);
                hold on
            end
        end
        %%
        %34
        for i = 0:(DO2UP-1) % DOWN to UP draws cars
            if  fix(10*(DIS_D2U_pro(i+1) -i*(CAR_INTERVAL+H_CAR_LENG))) ...% for the parkong cars
                    == fix(10*LENG)...
                    && p_D2U(i+1) < p
                %         break;
                % continue;
            elseif fix(10*(DIS_D2U_pro(i+1) -i*(CAR_INTERVAL+H_CAR_LENG))) ...% for the parkong cars
                    == fix(10*LENG) && (g_1 <= 0.05)
                for j = (i+1):DO2UP
                    rectangle('Position',[V_car_x_DO - H_half_WID,...
                        (DIS_D2U_pro(i+1) +CAR_INTERVAL-(j)*(CAR_INTERVAL+H_CAR_LENG)),...
                        H_CAR_WID,H_CAR_LENG],'FaceColor','#FF8100');% DOWN to UP
                    hold on
                    text(V_car_x_DO - H_half_WID,...
                        (DIS_D2U_pro(i+1) +1.5*CAR_INTERVAL-(j)*(CAR_INTERVAL+H_CAR_LENG)),plate_D2U(i+1),...
                        'FontSize',6);
                end
                DIS_D2U_pro(1,i+1:DO2UP) = DIS_D2U_pro(1,i+1:DO2UP) - fps*SPEED;
                break;
            end
            if DIS_D2U_pro(i+1) <=2*LENG+2*n*LA_WID  %disappear
                rectangle('Position',[(V_car_x_DO - H_half_WID),...
                    (DIS_D2U_pro(i+1) -H_CAR_LENG- i*(CAR_INTERVAL+H_CAR_LENG)),...
                    H_CAR_WID,H_CAR_LENG],'FaceColor','#FF8100');
                hold on
                text((V_car_x_DO - H_half_WID),...
                    (DIS_D2U_pro(i+1) -0.25*H_CAR_LENG- i*(CAR_INTERVAL+H_CAR_LENG)),plate_D2U(i+1),'FontSize',6);
            end
        end
        
        for i = 0:(UP2DO-1) % UP to DOWN draw cars
            if  fix(10*(DIS_U2D_pro(i+1) +i*(CAR_INTERVAL+H_CAR_LENG))) ...% for the parkong cars
                    == fix(10*(LENG+2*n*LA_WID))...
                    && p_U2D(i+1) < p
                %         break;
                %continue;
            elseif fix(10*(DIS_U2D_pro(i+1) +i*(CAR_INTERVAL+H_CAR_LENG))) ...% for the parkong cars
                    == fix(10*(LENG+2*n*LA_WID)) && (g_1 <= 0.05)
                for j = (i+1):UP2DO
                    rectangle('Position',[V_car_x_UP - H_half_WID,...
                        (DIS_U2D_pro(i+1) +(j-1)*(CAR_INTERVAL+H_CAR_LENG)),...
                        H_CAR_WID,H_CAR_LENG],'FaceColor','#FFF100');% DOWN to UP
                    hold on
                    text(V_car_x_UP - H_half_WID,...
                        (DIS_U2D_pro(i+1)-0.5*CAR_INTERVAL +(j-1)*(CAR_INTERVAL+H_CAR_LENG)),plate_U2D(i+1),'FontSize',6);
                end
                DIS_U2D_pro(1,i+1:UP2DO) = DIS_U2D_pro(1,i+1:UP2DO) + fps*SPEED;
                break;
            end
            if DIS_U2D_pro(i+1) >=0  %disappear
                rectangle('Position',[(V_car_x_UP - H_half_WID),...
                    (DIS_U2D_pro(i+1) + i*(CAR_INTERVAL+H_CAR_LENG)),...
                    H_CAR_WID,H_CAR_LENG],'FaceColor','#FFF100');
                hold on
                text((V_car_x_UP - H_half_WID),...
                    (DIS_U2D_pro(i+1)-0.5*CAR_INTERVAL + i*(CAR_INTERVAL+H_CAR_LENG)),plate_U2D(i+1),'FontSize',6);
            end
        end
        
        %%
        %test crash
        Sum_TEST = 0;
        %first part LEFT to RIGHT and UP to DOWN
        for i=0:(LE2RI-1)
            for j=0:(UP2DO-1)
                TEST_1=test_crash((DIS_L2R_pro(i+1) -H_CAR_LENG- i*(CAR_INTERVAL+H_CAR_LENG)),...
                    car_y_DO - H_half_WID,...%LE to RI
                    (V_car_x_UP - H_half_WID),...
                    (DIS_U2D_pro(j+1) + j*(CAR_INTERVAL+H_CAR_LENG)));% UP to DOWN
                if TEST_1 == 1
                    Sum_TEST=Sum_TEST+1;
                end
            end
        end
        %second part LEFT to RIGHT and DOWN to UP
        for i=0:(LE2RI-1)
            for j=0:(DO2UP-1)
                TEST_2=test_crash((DIS_L2R_pro(i+1) -H_CAR_LENG- i*(CAR_INTERVAL+H_CAR_LENG)),...
                    car_y_DO - H_half_WID,...%LE to RI
                    (V_car_x_DO - H_half_WID),...
                    (DIS_D2U_pro(j+1) -H_CAR_LENG- j*(CAR_INTERVAL+H_CAR_LENG)));
                if TEST_2 == 1
                    Sum_TEST=Sum_TEST+1;
                end
            end
        end
        %third part RIGHT to LEFT and UP to DOWN
        for i=0:(RI2LE-1)
            for j=0:(UP2DO-1)
                TEST_3=test_crash(DIS_R2L_pro(i+1) + i*(CAR_INTERVAL+H_CAR_LENG),...
                    car_y_UP - H_half_WID,...%RI to LE
                    (V_car_x_UP - H_half_WID),...
                    (DIS_U2D_pro(j+1) + j*(CAR_INTERVAL+H_CAR_LENG)));
                if TEST_3 == 1
                    Sum_TEST=Sum_TEST+1;
                end
            end
        end
        %fourth part RIGHT to LEFT and DOWN to UP
        for i=0:(RI2LE-1)
            for j=1:(DO2UP-1)
                TEST_4=test_crash(DIS_R2L_pro(i+1) + i*(CAR_INTERVAL+H_CAR_LENG),...
                    car_y_UP - H_half_WID,...%RI to LE
                    (V_car_x_DO - H_half_WID),...
                    (DIS_D2U_pro(j+1) -H_CAR_LENG- j*(CAR_INTERVAL+H_CAR_LENG)));
                if TEST_4 == 1
                    Sum_TEST=Sum_TEST+1;
                end
            end
        end
        
        %test whether players win
        WIN_BOOL = 0;
        if (DIS_L2R_pro(LE2RI) -H_CAR_LENG- (LE2RI-1)*(CAR_INTERVAL+H_CAR_LENG))>= (LENG+2*n*LA_WID) &&...
                (DIS_R2L_pro(RI2LE) + (RI2LE-1)*(CAR_INTERVAL+H_CAR_LENG))<=LENG  &&...
                (DIS_D2U_pro(DO2UP) -H_CAR_LENG- (DO2UP-1)*(CAR_INTERVAL+H_CAR_LENG)) >= LENG + 2*n*LA_WID &&...
                (DIS_U2D_pro(UP2DO) + (UP2DO)*(CAR_INTERVAL+H_CAR_LENG)) <= LENG
            WIN_BOOL = 1;
        end
        
        %%
        %move the cars
        DIS_L2R = DIS_L2R + fps*SPEED;
        DIS_R2L = DIS_R2L - fps*SPEED;
        DIS_U2D = DIS_U2D - fps*SPEED;
        DIS_D2U = DIS_D2U + fps*SPEED;
        DIS_L2R_pro = DIS_L2R_pro + fps*SPEED;
        DIS_R2L_pro = DIS_R2L_pro - fps*SPEED;
        DIS_U2D_pro = DIS_U2D_pro - fps*SPEED;
        DIS_D2U_pro = DIS_D2U_pro + fps*SPEED;
        %%
        %if player lose or win exit the loop
        if (Sum_TEST > 0) || (WIN_BOOL == 1)
            break;
        end
        
        %to hold on the color and minus the time matlab using calulating
        pause(fps-etime(clock,t0));
        
        
    end
    close;
    %%
    %judge the player wins or not
    if Sum_TEST > 0
        disp("GAME OVER");
    elseif WIN_BOOL == 1
        disp('Congratulations!You win!');
    end
    
    %output cars tend to run a red light
    disp('Car(s) break traffic rules:')
    for i=1:length(p_L2R)
        if p_L2R(i)<p & (DIS_L2R_pro(i)-(i-1)*(CAR_INTERVAL+H_CAR_LENG)>=LENG)
            disp(plate_L2R(i));
        end
    end
    for i=1:length(p_R2L)
        if p_R2L(i)<p & (DIS_R2L_pro(i)+(i-1)*(CAR_INTERVAL+H_CAR_LENG) <= LENG+2*n*LA_WID)
            disp(plate_R2L(i));
        end
    end
    for i=1:length(p_D2U)
        if p_D2U(i)<p & (DIS_D2U_pro(i)-(i-1)*(CAR_INTERVAL+H_CAR_LENG)>= LENG)
            disp(plate_D2U(i));
        end
    end
    for i=1:length(p_U2D)
        if p_U2D(i)<p & (DIS_U2D_pro(i)+(i-1)*(CAR_INTERVAL+H_CAR_LENG) <= LENG+2*n*LA_WID)
            disp(plate_U2D(i));
        end
    end
    
else
    disp("Not a valid time for red lights.");
end