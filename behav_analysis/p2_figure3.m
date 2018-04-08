% COMPARES P2 A, B, A',B' ACCURACIES ACROSS ALL 3 GROUPS

%load data
behav_analyzer;

mean_all_Ao = mean(all_Ao); 
mean_all_Av = mean(all_Av);
mean_all_Bo = mean(all_Bo);
mean_all_Bv = mean(all_Bv);
std_all_Ao = std(all_Ao); 
std_all_Av = std(all_Av); 
std_all_Bo = std(all_Bo); 
std_all_Bv = std(all_Bv); 


% Data to be plotted as a bar graph
p2_means = 100*[mean_all_Ao; ...
                mean_all_Bo; ...
                mean_all_Av; ...
                mean_all_Bv];
        
p2_stds = 100*[std_all_Ao; ...
               std_all_Bo; ...
               std_all_Av; 
               std_all_Bv];

% Creating axes and the bar graph
ax = axes;
h = bar(p2_means,'BarWidth',1/2);
xt={'NB' ; 'B' ; 'NB`' ; 'B`'}; 
set(gca,'xtick',1:4); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Specific Scenario');
ylabel('Mean Percent Accuracy');

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
