% 30 march 2019, little home automation sequence
clc
clear variables
close all

current_time=clock;
time_hhmmss=[num2str(current_time(4),"%0.2d"),':',num2str(current_time(5),"%0.2d"),':',num2str(current_time(6),"%0.2d")];

set_time_thermostat=['ebusctl write -c f37 Time ',time_hhmmss]
eval(set_time_thermostat)
