clc
clear variables
close all


start=10000;
interests=[1.02:0.02:1.08];

str_legend='legend(';

for i=1:length(interests)
interest=interests(i);
year=[0:35];

figure(1)
hold on
plot(year,start*interest.^year)
str_legend=[str_legend,char(39),'jaarlijkse interest ',num2str(interest),char(39),','];

end

xlabel('jaar')
ylabel('euro')
grid minor

str_legend=[str_legend(1:end-1),')'];
eval(str_legend)