function Spreadfigures(varargin)
% Author: Stijn Goossens 22/04/2014
% spread plotted figures over entire screen and link all x-axes
% varargin: give figure handles of figures that need to be linked and
% spreaded. e.g. Spreadfigures([f1;f2])  (function UseFig can be useful for this)
% if no input is given to the function: spread all figures over screen and
% link all x-axes

set(0,'Units','pixels');
scnsize = get(0,'ScreenSize');
width=0.95*scnsize(3);
height=0.9*scnsize(4);

if nargin==0
    figs = get(0, 'children') ;
else
    figs=varargin{:};
end


% define number of rows
FiguresNextToEachOther=3;

NumberOfRows=ceil(size(figs,1)/FiguresNextToEachOther);
FigureHeight=height/NumberOfRows;
FigureWidth=width/FiguresNextToEachOther;

i=1;
for j=1:NumberOfRows   
    for k=1:FiguresNextToEachOther%size(figs,1)

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
ax = findall(figs, 'type', 'axes');
linkaxes(ax,'x')

end
