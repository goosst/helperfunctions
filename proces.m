% 25 march 2019: 
% this script processes fuel data, exported from ING bankaccount

clc
clear variables
close all
%dbstop if error
pkg load io

cd('/home/stijn/Documents/ing')

filename='377-0792019-51 LA (EUR) 20180101 - 20190322.csv';
keywords={'tank','diesel'};
data=csv2cell(filename,';');
descript_cell=9;

counter=0;
for i=1:size(data,1)

  %ata{i,descript_cell}
  %keyboard
  for j=1:size(keywords,2) 
    if strfind(data{i,descript_cell},keywords{j})

      counter=counter+1;
      fuel(counter).date=data{i,5};
      temp=str2num(data{i,7});
      fuel(counter).cost=abs(temp(1))+0.01*abs(temp(2));
      fuel(counter).descr=data{i,descript_cell};
      break 
      
    end
  end
end


%octave is weird 
for i=1:size(fuel,2)
  timestamp(i)=datenum(fuel(i).date,'dd/mm/yyyy');
  costs(i)=fuel(i).cost;
  
  %find amount of liter in description 
  descr_str=fuel(i).descr;
  [str_start1]=regexp(descr_str,'\d*,\d*\sliter');
  [str_start2]=regexp(descr_str,'\sliter');
  
  if ~isempty(str_start1) 
  liter=str2num(descr_str(str_start1:str_start2));
  liter=liter(1)+liter(2)*0.01;
   liters(i)=liter;
  else %not clean, but whatever
  liters(i)=0;
  descr_str
  end
  
end


figure
plot(timestamp,costs,'linewidth',2)
legend(['total fuel cost ',num2str(sum(costs)),' euro'])
xlabel('time')
ylabel('euro')
datetick ("x", "mm-YYYY");
title('fuel cost')
grid minor


figure
plot(timestamp,liters,'linewidth',2)
legend(['total fuel cost ',num2str(sum(liters)),' liter'])
xlabel('time')
ylabel('liter')
datetick ("x", "mm-YYYY");
title('fuel liter')
grid minor

