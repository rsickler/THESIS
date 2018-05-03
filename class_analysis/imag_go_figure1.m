% COMPARES MEAN IMAG GO ACCURACIES FOR ALL 3 MASKS
class_analyzer; 

% Data to be plotted as a bar graph
means = 100*[mean_imag_go_PM; ...
             mean_imag_go_PS; ...
             mean_imag_go_SM; ...
             mean_imag_go_MP; ...
             mean_imag_go_MI; ...
             mean_imag_go_WB; ...
             mean_imag_go_AM];
        
stderror = 100*[stderror_imag_go_PM; ...
                stderror_imag_go_PS; ...
                stderror_imag_go_SM; ...
                stderror_imag_go_MP; ...
                stderror_imag_go_MI; ...
                stderror_imag_go_WB; ...
                stderror_imag_go_AM];

values = 100*[imag_go_PM; ...
              imag_go_PS; ...
              imag_go_SM; ...
              imag_go_MP; ...
              imag_go_MI; ...
              imag_go_WB; ...
              imag_go_AM];

% Creating axes and the bar graph
ax = axes;
h = bar(means,'BarWidth',1/2);
xt={'PM';'PS';'SM';'MP';'MI';'WB';'AM'}; 
set(gca,'xtick',1:7); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
% light blue 
h(1).FaceColor = [0.9    0.4157    0.4882];

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
x2 = [0 8];
y2 = [100/3 100/3];
line(x2,y2,'Color','red','LineStyle','--')


% add individual data points
hold on
                 
for i=1:length(values)
    x = repmat(i,1,length(values(i,:))); %the x axis location
    x = x+(rand(size(x))-0.5)*0.05; %add a little random "jitter" to aid visibility
    plot(x,values(i,:),'.k','MarkerSize', 15)
end
