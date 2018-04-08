%load data

behav_analyzer;

% Data to be plotted as a bar graph
p1_means = [p1_t_Aratio p1_t_Bratio; p1_i_Aratio p1_i_Bratio];
p1_stds = [p1_t_Aratio_std p1_t_Bratio_std; p1_i_Aratio_std p1_i_Bratio_std];

% Creating axes and the bar graph
ax = axes;
h = bar(p1_means,'BarWidth',1);

% Set color for each bar face
h(1).FaceColor = 'blue';
h(2).FaceColor = 'yellow';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Experimental Group');
ylabel('Mean Accuracy');

% Creating a legend and placing it outside the bar plot
lg = legend('No Block','Block','AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(p1_means, 1);
nbars = size(p1_means, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, p1_means(:,i), p1_stds(:,i), 'k', 'linestyle', 'none');
end
