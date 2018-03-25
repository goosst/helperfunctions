function [coordinates,timeStamp]=loadGPX(filename)
%25 march 2018, read in gpx file (tested on gpx files downloaded from
%strava), does not make use of slow xml converters and readers
% coordinates=[lat,lon,alt]
% timeStamp = datenum format matlab
%
% for some files the timeconsuming for loop to calculate the coordinates can be removed, in other files it throws
% errors, have not spent time trying to get around

fid = fopen(filename);
data = textscan(fid,'%s');
fclose(fid);

string = data{:};
string = cat(2,string{:});
start = regexp(string,'<trkseg>');
finish = regexp(string,'</trkseg>');
string = string(start(1):finish(end));

lat=regexp(string,'lat="(\d*.\d*)"','tokens'); % lat
lon=regexp(string,'lon="(\d*.\d*)"','tokens'); % lon
alt=regexp(string,'<ele>(\d*.\d*)</ele>','tokens'); % alt

for i=1:size(lat,2)
    coordinates(i,1)=str2double(lat{i});
    coordinates(i,2) =str2double(lon{i});
    coordinates(i,3) = str2double(alt{i});
end

timeStamp = regexp(string,'<time>(\d*-\d*-\d*T\d*:\d*:\d*Z)</time>','tokens');
%matlab is stupid, convert each element to strings
for i=1:size(timeStamp,2)
    timeStamp{i}=char(timeStamp{i});
end

timeStamp=datenum(timeStamp,'yyyy-mm-ddTHH:MM:SSZ');

