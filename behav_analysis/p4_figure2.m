% COMPARES P2 A, B, A',B' ACCURACIES ACROSS ALL 3 GROUPS

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p4_means = 100*[p4_t_Ao_ratio p4_i_Ao_ratio p4_d_Ao_ratio; ...
                p4_t_Bo_ratio p4_i_Bo_ratio p4_d_Bo_ratio; ...
                p4_t_Av_ratio p4_i_Av_ratio p4_d_Av_ratio; ...
                p4_t_Bv_ratio p4_i_Bv_ratio p4_d_Bv_ratio];
        
p4_stds = 100*[p4_t_Ao_ratio_std p4_i_Ao_ratio_std p4_d_Ao_ratio_std; ...
               p4_t_Bo_ratio_std p4_i_Bo_ratio_std p4_d_Bo_ratio_std; ...
               p4_t_Av_ratio_std p4_i_Av_ratio_std p4_d_Av_ratio_std; 
               p4_t_Bv_ratio_std p4_i_Bv_ratio_std p4_d_Bv_ratio_std];

% Creating axes and the bar graph
ax = axes;
h = bar(p4_means,'BarWidth',1);
xt={'NB' ; 'B' ; 'B`' ; 'NB`'}; 
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
xlabel('Specific Scenario');
ylabel('Mean Percent Accuracy');

% Creating a legend and placing it outside the bar plot
lg = legend('Continued Training','Mental Practice', 'Irrelevant Task', 'AutoUpdate','off');
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
