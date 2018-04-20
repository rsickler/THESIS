% COMPARES MEAN GO IMAG ACCURACIES FOR ALL 3 MASKS
class_analyzer; 

% Data to be plotted as a bar graph
means = 100*[mean_imag_go_MI; ...
             mean_imag_go_SM; ...
             mean_imag_go_AM];
        
stderror = 100*[stderror_imag_go_MI; ...
                stderror_imag_go_SM; ...
                stderror_imag_go_AM];

% Creating axes and the bar graph
ax = axes;
h = bar(means,'BarWidth',1/2);
xt={'MI' ; 'SMA' ; 'AM'}; 
set(gca,'xtick',1:3); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'blue';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Applied Mask');
ylabel('Classifier Mean Percent Accuracy');

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(means, 1);
nbars = size(means, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, means(:,i), stderror(:,i), 'k', 'linestyle', 'none');
end

% add chance classification line
x2 = [0 4];
y2 = [100/3 100/3];
line(x2,y2,'Color','red','LineStyle','--')

