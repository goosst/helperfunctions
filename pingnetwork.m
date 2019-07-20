#!/usr/bin/octave 
%sg: 21 dec 2018
% script in octave/matlab to find ip addresses on wireless network
% it's slow but seems at least much more reliable (compared to NMAP type commands)
clc
clear variables
close all
dbstop if error 
macaddress1='7c:7d:3d:ba:ef:be';
macaddress_found=false;

Npackages=2;

tic
for i=255:-1:1
  %ping ip address 
  str_ip=['[STATUS, OUTPUT] =system(',char(39),'ping 192.168.0.',num2str(i),' -c ',num2str(Npackages),' -W 4',char(39),');'];
  eval(str_ip)

  %was pinging successful?
  if ~isempty(strfind(OUTPUT,[num2str(Npackages),' received'])) || ~isempty(strfind(OUTPUT,[num2str(1),' received']))
    disp('*************')
    disp(['192.168.0.',num2str(i)])
    ipaddress=['192.168.0.',num2str(i)];
    
    % check mac address 
    clear OUTPUT STATUS 
    temp_str=['[STATUS, OUTPUT] =system(',char(39),'arp -a | grep ',ipaddress,char(39),');'];
    eval(temp_str);
    
    if ~isempty(OUTPUT)
      if ~isempty(strfind(OUTPUT,macaddress1))
        disp('---------------')
         display('macaddress1 found')
         disp('---------------')
         macaddress_found=true;
         %break;
      end
    end
    
  endif

end

toc
