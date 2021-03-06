% COMPARES MEAN GO GO ACCURACIES FOR ALL 3 MASKS
class_analyzer; 

% Data to be plotted as a bar graph
imag_imag_means = 100*[imag_imag_MI; ...
                       imag_imag_SM; ...
                       imag_imag_AM];
        
% Creating axes and the bar graph
ax = axes;
h = bar(imag_imag_means,'BarWidth',1);
xt={'MI' ; 'SMA' ; 'AM'}; 
set(gca,'xtick',1:3); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
h(1).FaceColor = 'red';
h(2).FaceColor = 'green';
h(3).FaceColor = 'blue';
h(4).FaceColor = 'yellow';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Applied Mask');
ylabel('Classifier Mean Percent Accuracy');

hold on;

% Finding the number of groups and the number of bars in each group
ngroups = size(imag_imag_means, 1);
nbars = size(imag_imag_means, 2);

% Creating a legend and placing it outside the bar plot
lg = legend('S1','S2', 'S3','S4', 'AutoUpdate','off');
lg.Location = 'BestOutside';
lg.Orientation = 'Horizontal';

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
end

% add chance classification line
x2 = [0 4];
y2 = [100/3 100/3];
line(x2,y2,'Color','red','LineStyle','--')

