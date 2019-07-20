clc
clear variables
close all
currentdir=pwd;

dir='/media/stijn/f056d34d-ca3f-4f29-9e22-32e9a2a14265/backup/backup/e-books/BDL';
fileList = getAllFiles(dir)

for i=1:size(fileList,1)
str=['kdeconnect-cli --share ',char(39),fileList{i},char(39),' --name Huawei']
system(str)

end


