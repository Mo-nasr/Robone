clc;
clear all;
delete(instrfindall)
%Customize graph
figure('units','normalized','outerposition',[0 0 1 1]);
whitebg('black');
%Draw Scale Data
th = linspace(0,pi,1000);
R = 10:10:200;  
for i=1:length(R)
x = R(i)*cos(th);
y = R(i)*sin(th);
plot(x,y,'Color', [0.603922 , 0.803922 , 0.196078] ,'LineWidth',1);
hold on;
end
% Draw Axis data
x0 = [0 200 0 0 0 0 ];  x1 = [0 200 173.2 100 -100 -173.2]; y0 = [0 0 0 0 0 0]; y1 = [200 0 100 173.2 173.2 100];
for i=1:length(x0)
hold on;
plot([x0(i),x1(i)],[y0(i),y1(i)] ,'Color', [0.603922 , 0.803922 , 0.196078],'LineWidth',2);
end
% %Draw Sonar default data
for i=1:180 
hold on;
[x, y] = pol2cart(i*0.0174532925, 200); %convert degrees to rads
h(i) = plot([0,x],[0,y],'g','LineWidth',1);
end
%define serial port
s1 = serial('COM5');             
s1.BaudRate=9600;                               
fopen(s1);
%Draw Sonar Data
while(1)
data = fscanf(s1);
[th, r] = strtok(data);
th = real(str2num(th));
r = str2num(r);
if (r >= 200)
    r=200;
end    
set(h(th),'color','r');
[x0, y0] = pol2cart(th*0.0174532925, 200);
[x, y] = pol2cart(th*0.0174532925, r);
set(h(th),'XData',[x0,x]);
set(h(th),'YData',[y0,y]);
m = plot([0,x0],[0,y0],'r','LineWidth',3);
drawnow
delete(m);
end
fclose(s1);


