% COMPARES MEAN GO GO ACCURACIES FOR ALL 3 MASKS
class_analyzer; 
set(findall(gcf,'-property','FontSize'),'FontSize',18)


% Data to be plotted as a bar graph
go_go_means = 100*[go_go_PM; ...
                go_go_PS; ...
                go_go_SM; ...
                go_go_MP; ...
                go_go_MI; ...
                go_go_WB; ...
                go_go_AM];
        
% Creating axes and the bar graph
ax = axes;
h = bar(go_go_means,'BarWidth',1);
xt={'PM';'PS';'SM';'MP';'MI';'WB';'AM'}; 
set(gca,'xtick',1:7); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'red';
h(2).FaceColor = 'green';
h(3).FaceColor = 'blue';
h(4).FaceColor = 'yellow';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Applied Mask');
ylabel('Classifier Mean Percent Accuracy');

% Creating a legend and placing it outside the bar plot
lg = legend('S1','S2', 'S3','S4', 'AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(go_go_means, 1);
nbars = size(go_go_means, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
end

% add chance classification line
x2 = [0 8];
y2 = [100/3 100/3];
line(x2,y2,'Color','red','LineStyle','--')
