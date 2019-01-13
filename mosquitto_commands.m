% mosquitto commands for sonoff devices using tasmota firmware

clc
clear variables
close all

devicename='sonoff1';

%% change status
% toggle relay S20
str_toggle='mosquitto_pub -h localhost -t "cmnd/sonoff1/power" -m toggle';
str_on='mosquitto_pub -h localhost -t "cmnd/sonoff1/power" -m on';

str_subscribe='mosquitto_sub -h localhost -t "stat/sonoff1/#"'
str_askstatus='mosquitto_pub -h localhost -t cmnd/sonoff1/status -m 0'


%% listen to status 
str_powerstat=''


[STATUS, OUTPUT] =system(str_powerstat);