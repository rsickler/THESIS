% COMPARES MEAN IMAG IMAG ACCURACIES FOR ALL 3 MASKS
class_analyzer; 

% Data to be plotted as a bar graph
means = 100*[mean_imag_imag_PM; ...
             mean_imag_imag_PS; ...
             mean_imag_imag_SM; ...
             mean_imag_imag_MP; ...
             mean_imag_imag_MI; ...
             mean_imag_imag_WB; ...
             mean_imag_imag_AM];
        
stderror = 100*[stderror_imag_imag_PM; ...
                stderror_imag_imag_PS; ...
                stderror_imag_imag_SM; ...
                stderror_imag_imag_MP; ...
                stderror_imag_imag_MI; ...
                stderror_imag_imag_WB; ...
                stderror_imag_imag_AM];

values = 100*[imag_imag_PM; ...
              imag_imag_PS; ...
              imag_imag_SM; ...
              imag_imag_MP; ...
              imag_imag_MI; ...
              imag_imag_WB; ...
              imag_imag_AM];

% Creating axes and the bar graph
ax = axes;
h = bar(means,'BarWidth',1/2);
xt={'PM';'PS';'SM';'MP';'MI';'WB';'AM'}; 
set(gca,'xtick',1:7); 
set(gca,'xticklabel',xt);
ylim([0 100]);

% Set color for each bar face
% light blue 
h(1).FaceColor = [0.5843    0.8157    0.9882];

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';

% X and Y labels
xlabel('Applied Mask');
ylabel('Classifier Mean Accuracy (%)');
set(gca,'FontSize',18)

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
