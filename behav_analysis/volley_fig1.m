% VBALL VS NON-VBALL ACCURACIES IN P2 

% COMPARES P2 A, B, A',B' ACCURACIES ACROSS ALL 3 GROUPS

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p2_means = 100*[nv_Ao_mean2 v_Ao_mean2 ; ...
                nv_Bo_mean2 v_Bo_mean2 ; ...
                nv_Av_mean2 v_Av_mean2 ; ...
                nv_Bv_mean2 v_Bv_mean2 ];
% convert to standard errors unique to the two group (n = 37 and 9)            
p2_stds = 100*[nv_Ao_std2 v_Ao_std2 ; ...
               nv_Bo_std2 v_Bo_std2 ; ...
               nv_Av_std2 v_Av_std2 ; 
               nv_Bv_std2 v_Bv_std2 ];

p2_stderror(:,1) = p2_stds(:,1) / sqrt(37); 
p2_stderror(:,2) = p2_stds(:,2) / sqrt(9); 

% Creating axes and the bar graph
ax = axes;
h = bar(p2_means,'BarWidth',1);
xt={'NB' ; 'B' ; 'NB`' ; 'B`'}; 
set(gca,'xtick',1:4); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'red';
h(2).FaceColor = 'green';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Specific Scenario');
ylabel('Mean Accuracy (%)');
set(gca,'FontSize',18)

% Creating a legend and placing it outside the bar plot
lg = legend('Inexperienced','Experienced', 'AutoUpdate','off');
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
    errorbar(x, p2_means(:,i), p2_stderror(:,i), 'k', 'linestyle', 'none');
end
