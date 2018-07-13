% COMPARES P2 ORIGINAL AND VARIANT ACCURACIES ACROSS ALL 3 GROUPS

%load data
behav_analyzer;

% Data to be plotted as a bar graph
p3_means = 100*[p2_t_O_RATIO p3_t_O_RATIO p4_t_O_RATIO ; p2_t_V_RATIO p3_t_V_RATIO p4_t_V_RATIO];
p3_stderror = 100*[p2_t_O_RATIO_STD p3_t_O_RATIO_STD p4_t_O_RATIO_STD ; ...
    p2_t_V_RATIO_STD p3_t_V_RATIO_STD p4_t_V_RATIO_STD] / 4; 
       
% Creating axes and the bar graph
ax = axes;
h = bar(p3_means,'BarWidth',1/2);
xt={'Originals' ; 'Variants'} ; 
set(gca,'xtick',1:2); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'magenta';
h(2).FaceColor = 'cyan';
h(3).FaceColor = 'yellow';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Experimental Group');
ylabel('Mean Accuracy (%)');
set(gca,'FontSize',18)

% Creating a legend and placing it outside the bar plot
lg = legend('Phase 1','Phase 2','Phase 3','AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(p3_means, 1);
nbars = size(p3_means, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, p3_means(:,i), p3_stderror(:,i), 'k', 'linestyle', 'none');
end


%% stats

  
A = p2_t_V.';
B = p3_t_V.';
C = p4_t_V.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p1,~,stats] = anova1(y,group,'off');

[h2,p2] = ttest(A,B); 
[h3,p3] = ttest(B,C); 
