function FigHandle=UseFig(FigureName)
% author stijn goossens
% if figure with FigureName does not exist, create it
% if figure with FigureName exists, bring it forward

figs = get(0, 'children');

    if isempty(find(strcmp(get(figs,'Name'),FigureName)))
        figure('name',FigureName)
    else
        figure(figs(find(strcmp(get(figs,'Name'),FigureName))))       
    end
    
    figs = get(0, 'children');
    FigHandle=figs(find(strcmp(get(figs,'Name'),FigureName)));
    
end
