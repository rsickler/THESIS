% GIVES OVERALL P1 ORIGINAL TEAM ACCURACIES ACROSS THREE GROUPS

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p1_means = 100*[p1_t_O_RATIO; p1_i_O_RATIO; p1_d_O_RATIO ];
% convert to standard error (sqrt(16))
p1_stderror = 100*[p1_t_O_RATIO_STD; p1_i_O_RATIO_STD; p1_d_O_RATIO_STD] / 4;

% Creating axes and the bar graph
ax = axes;
h = bar(p1_means,'BarWidth',1/4);
h(1).FaceColor = 'blue';
xt={'Continued Training' ; 'Mental Practice' ; 'Irrelevant Task'} ; 
set(gca,'xtick',1:3); 
set(gca,'xticklabel',xt);
ylim([0 100]);
% title('Phase 1 Accuracies Across All Groups');


% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Experimental Group');
ylabel('Mean Accuracy (%)');
set(gca,'FontSize',18)

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
    errorbar(x, p1_means(:,i), p1_stderror(:,i), 'k', 'linestyle', 'none');
end
