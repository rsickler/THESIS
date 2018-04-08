% COMPARES P2 ORIGINAL AND VARIANT ACCURACIES ACROSS ALL 3 GROUPS

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p4_means = 100*[p4_t_O_RATIO p4_t_V_RATIO; p4_i_O_RATIO p4_i_V_RATIO; p4_d_O_RATIO p4_d_V_RATIO ];
        
p4_stds = 100*[p4_t_O_RATIO_STD p4_t_V_RATIO_STD; p4_i_O_RATIO_STD p4_i_V_RATIO_STD; p4_d_O_RATIO_STD p4_d_V_RATIO_STD]; 
       
% Creating axes and the bar graph
ax = axes;
h = bar(p4_means,'BarWidth',1);
xt={'Continued Training' ; 'Mental Practice' ; 'Irrelevant Task'} ; 
set(gca,'xtick',1:3); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'blue';
h(2).FaceColor = 'yellow';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Experimental Group');
ylabel('Mean Percent Accuracy');

% Creating a legend and placing it outside the bar plot
lg = legend('Originals','Variants','AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(p4_means, 1);
nbars = size(p4_means, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, p4_means(:,i), p4_stds(:,i), 'k', 'linestyle', 'none');
end
