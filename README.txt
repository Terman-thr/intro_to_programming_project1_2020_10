Haoran Tang    p1                           Please run the Road_Game.m (main script)

Bonus:
Difficulty

Polite notice:
1.car_num must be larger than 4 (I designed it) or it will have an error and car_num is recommended to 5~15 (if you computer is powerful enough,
enter the number as you like).
2.the red light time must be larger than 5.(designed: I set the other orange light's time as 5. So if red light is less than 5s, the car will never 
enter the crossing)
3. ALWAYS LOSE CONDITION PLEASE ENTER THE NUMBER IN SEQUENCE :[3,10,0,10,5,10]
4. ALWAYS WIN CONDITION PLEASE ENTER THE NUMBER IN SEQUENCE :[3,10,0,10,10,10]
5.Please maximize the window of figure for best watching experience.
=======================================================================================
Main structure:
The main script is devided into several sections with detailed comments, the main structure is:

Define (or generate )variables and input numbers.

while
i.Print the traffic lights.(with the loop of Red-->Green-->Orange-->Red-->Green ...)
ii.Spilt into two branch. One is cars that are non-stop(or run a red light). The other is cars stop at the crossing.
Afterwards,print the cars with their plate.(it may seems complex, because I have to make sure cars are at the middle of the lane,
and I add or minus some variables to adjust it). At last, disappear the cars at the end of the road.
iii.If cars have passed the crossing ,test whether they will crash with other cars(output : Sum_TEST=1) or all cars pass the crossing
safely (output : WIN_BOOL=1)
iv.break  out of loop if there is output in iii
end

Print the plate cars ran a red light.
========================================================================================
Bug section:
1.IF the time of green lights are sufficiently long, and car_num is sufficiently large.Maybe a row of cars will disappear suddenly when the first
car drives to the end while the last one haven't enter the crossing.(Just a Guess)
2.The program lacks branches to tell users that their input numbers are not appropriate.(unnecessary because of README)
3.The script is not very efficient. So computer with low operational capability could not run it smoothly.
4.IF I change the fps(refresh rate) to 0.2 from 0.1,cars will not stop at a red light.

========================================================================================
function introduction:
==========================20.10.10========================
the latest update:

Due to the ban on global variables , I copy all the code of my function and put them in my main funtion.
Then, I spilt them into several functions if their input variables are not so many.
New functions:
---------------------------------------------------------------------------------------------
Car_Num_Disributer: distribute car numbers on each lane (originally in Traffic.m)
---------------------------------------------------------------------------------------------
Road_Print: draw the shape of the road (originally the Road.m)
---------------------------------------------------------------------------------------------
plate_generator.m and test_crash are reserved.
---------------------------------------------------------------------------------------------
plate_generator.m
I use ASCII to generate numbers(48-57) and capital letters(65-90). For the first capital letter, I randomly
 generate a number lays between 65-90. For the other four, I use randi generate an array with four 
numbers from 1 to 36 (57+90-48-65=36).Then ,we can use if branch to clarrify 1 to 10 and 11 to 36
 add 47 and 54 respectively. After that , "char" function is used to turn the ASCII number into chars.
So, we can get the plate.
PS. between the first letter and the other four , I added an space(ASCII:32) to sparate them.
---------------------------------------------------------------------------------------------
test_crash.m
The function is much simplier than I thought. If cars are all the same, I just need to know the
cooridinate of the cars and use the geometry calculation, and I can know whether two rectanges
are overlap (crash).

========================================================================================

the fake code of Ex2
input elements and I
function Random_plate(n)
if n=0
	output string
else
	for j=1:length(input)
		a[n]=the j th elements in the set
		Random(n-1);
	end
end




