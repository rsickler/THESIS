% COMPARES P1, P2, P3, P4 ORIGINAL ACCURACIES ACROSS ALL 3 GROUPS

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p2_means = 100*[p1_t_O_RATIO p1_i_O_RATIO p1_d_O_RATIO; ...
                p2_t_O_RATIO p2_i_O_RATIO p2_d_O_RATIO; ...
                p3_t_O_RATIO 0 0; ...
                p4_t_O_RATIO p4_i_O_RATIO p4_d_O_RATIO];
        
p2_stds = 100*[p1_t_O_RATIO_STD p1_i_O_RATIO_STD p1_d_O_RATIO_STD; ...
               p2_t_O_RATIO_STD p2_i_O_RATIO_STD p2_d_O_RATIO_STD; ...
               p3_t_O_RATIO_STD 0  0; ...
               p4_t_O_RATIO_STD p4_i_O_RATIO_STD p4_d_O_RATIO_STD];

% Creating axes and the bar graph
ax = axes;
h = bar(p2_means,'BarWidth',1);
xt={'P1' ; 'P2' ; 'P3' ; 'P4'}; 
set(gca,'xtick',1:4); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'green';
h(2).FaceColor = 'blue';
h(3).FaceColor = 'red';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Experimental Phase');
ylabel('Mean Originals Accuracy (%)');
set(gca,'FontSize',18)

% Creating a legend and placing it outside the bar plot
lg = legend('Continued Training','Mental Practice', 'Irrelevant Task', 'AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(p2_means, 1);
nbars = size(p2_means, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, p2_means(:,i), p2_stds(:,i), 'k', 'linestyle', 'none');
end
