clc
clear variables
close all

dbstop if error

folders=dir(pwd);


f1=figure(1)
plot([0:10])
xlabel('time(s)','Fontsize',15)
ylabel('unit 1','Fontsize',15)
title('test','Fontsize',16)
grid on

f2=figure(2)
plot([0:2:20])
xlabel('time(s)','Fontsize',15)
ylabel('unit 2','Fontsize',15)
title('test2','Fontsize',16)
grid on

% Spreadfigures

Spreadfigures('tight',[f1;f2])

% Spreadfigures([f1;f2],'nolink','tight')

