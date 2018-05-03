% COMPARES P1 A, B ACCURACIES ACROSS ALL 3 GROUP

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p1_means = 100*[p1_t_Aratio p1_i_Aratio p1_d_Aratio; ...
                p1_t_Bratio p1_i_Bratio p1_d_Bratio];        
% convert to standard error (sqrt(16))            
p1_stderror = 100*[p1_t_Aratio_std p1_i_Aratio_std p1_d_Aratio_std; ...
               p1_t_Bratio_std p1_i_Bratio_std p1_d_Bratio_std]/4;
           
% Creating axes and the bar graph
ax = axes;
h = bar(p1_means,'BarWidth',1);
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
ylabel('Mean Accuracy (%)');
set(gca,'FontSize',18)

% Creating a legend and placing it outside the bar plot
lg = legend('Continued Training','Mental Practice', 'Irrelevant Task', 'AutoUpdate','off');
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
    errorbar(x, p1_means(:,i), p1_stderror(:,i), 'k', 'linestyle', 'none');
end
