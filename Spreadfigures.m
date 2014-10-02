function Spreadfigures(varargin)
% Author: Stijn Goossens 22/04/2014
% spread plotted figures over entire screen 
% if no input is given to the function: spread all figures over screen and
% link all x-axes
% 
% optional arguments:
% Spreadfigures('tight','nolink',[fighandle1;fighandle2])
% * 'tight': remove unnecessary whitespace in borders 
% * 'nolink': don't link x-axes
% * '[fighandle1;fighandle2] (function UseFig https://github.com/goosst/matlabfunctions/ can be useful for this)
%
% Example:
% f1=figure(1)
% plot([0:10])
% xlabel('time(s)','Fontsize',15)
% ylabel('unit 1','Fontsize',15)
% title('test','Fontsize',16)
% grid on
% 
% f2=figure(2)
% plot([0:2:20])
% xlabel('time(s)','Fontsize',15)
% ylabel('unit 2','Fontsize',15)
% title('test2','Fontsize',16)
% grid on
% 
% % test out several options:
% % Spreadfigures
% % Spreadfigures('tight',[f1;f2])
% % Spreadfigures([f1;f2],'nolink','tight')



%default values
options.tight=0; %default: normal whitespace around figures is used
options.link=1; % default: all x-axes are linked with each other when zooming
figs = get(0, 'children') ; %default: use all figures

if ~exist('tightfig')
    addpath([pwd filesep 'tightfit'])
end

for i=1:nargin
    if isstr(varargin{i})
        if strcmp('tight',varargin{i})
            options.tight=1;
        elseif strcmp('nolink',varargin{i})
            options.link=0;
        else
            display('wrong string argument, will be neglected')
        end
    end    
end

%overwrite figs
for i=1:nargin
    if isnumeric(varargin{i})
        figs=varargin{i};
    end
end

set(0,'Units','pixels');
scnsize = get(0,'ScreenSize');
width=0.95*scnsize(3);
height=0.9*scnsize(4);



% define number of rows
FiguresNextToEachOther=3;

NumberOfRows=ceil(size(figs,1)/FiguresNextToEachOther);
FigureHeight=height/NumberOfRows;
FigureWidth=width/FiguresNextToEachOther;

i=1;
for j=1:NumberOfRows   
    for k=1:FiguresNextToEachOther%size(figs,1)

        if options.tight==1
            tightfig(figs(i));
        end
        % [left bottom width height]
        set(figs(i),'OuterPosition',[FigureWidth*(k-1)+0.05*width FigureHeight*(j-1)+0.1*height FigureWidth FigureHeight])
        
        %bring figure to foreground
        figure(figs(i))  
        
        i=i+1;
        if i>size(figs,1)
            break 
        end
    end
end

% link all axes with each other
if options.link==1
    ax = findall(figs, 'type', 'axes');
    linkaxes(ax,'x')
end

end
