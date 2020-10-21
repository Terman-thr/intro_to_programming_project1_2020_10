%To draw the image of the road.
function Road_Print(LENG,n,LA_WID)
rectangle('Position',[0,0,LENG,LENG]);% LEFT DOWN
rectangle('Position',[2*n*LA_WID + LENG,2*n*LA_WID + LENG,LENG,LENG]);%RIGHT UP
rectangle('Position',[0,2*n*LA_WID + LENG,LENG,LENG]);%LEFT UP
rectangle('Position',[2*n*LA_WID + LENG,0,LENG,LENG]);%RIGHT DOWN
hold on
plot([0,LENG],[LENG + n*LA_WID,LENG + n*LA_WID],'k--');
plot([LENG + n*LA_WID,LENG + n*LA_WID],[LENG,0],'k--');
plot([LENG + 2*n*LA_WID,2*LENG + 2*n*LA_WID],[LENG + n*LA_WID,LENG + n*LA_WID],'k--');
plot([LENG + n*LA_WID,LENG + n*LA_WID],[2*LENG + 2*n*LA_WID,LENG + 2*n*LA_WID],'k--');
hold on
end