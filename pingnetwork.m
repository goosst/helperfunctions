%sg: 21 dec 2018
% script in octave/matlab to find ip addresses on wireless network
% it's slow but seems at least much more reliable (compared to NMAP type commands)
clc
clear variables
close all
dbstop if error 

Npackages=2;


for i=0:255

str_ip=['[STATUS, OUTPUT] =system(',char(39),'ping 192.168.0.',num2str(i),' -c ',num2str(Npackages),char(39),');'];
eval(str_ip)

if ~isempty(strfind(OUTPUT,[num2str(Npackages),' received'])) || ~isempty(strfind(OUTPUT,[num2str(1),' received']))
  disp('*************')
  disp(['192.168.0.',num2str(i)])
endif




end