% compares how well classification went for go--> imag vs. imag --> go 
class_analyzer; 

% load figs
diffs_PM =  go_imag_PM - imag_go_PM;
diffs_PS =  go_imag_PS - imag_go_PS;
diffs_SM =  go_imag_SM - imag_go_SM;
diffs_MP =  go_imag_MP - imag_go_MP;
diffs_MI =  go_imag_MI - imag_go_MI;
diffs_WB =  go_imag_WB - imag_go_WB;
diffs_AM =  go_imag_AM - imag_go_AM;

diff_matrix = 100*[diffs_PM;diffs_PS;diffs_SM;diffs_MP;diffs_MI;diffs_WB;diffs_AM];
mean_diffs_PM = mean(diffs_PM);
mean_diffs_PS = mean(diffs_PS);
mean_diffs_SM = mean(diffs_SM);
mean_diffs_MP = mean(diffs_MP);
mean_diffs_MI = mean(diffs_MI);
mean_diffs_WB = mean(diffs_WB);
mean_diffs_AM = mean(diffs_AM);

stderror_diffs_MI = std(diffs_MI) / sqrt(length(diffs_MI));
stderror_diffs_SM = std(diffs_SM) / sqrt(length(diffs_SM));
stderror_diffs_AM = std(diffs_AM) / sqrt(length(diffs_AM));
stderror_diffs_PM = std(diffs_PM) / sqrt(length(diffs_PM));
stderror_diffs_PS = std(diffs_PS) / sqrt(length(diffs_PS));
stderror_diffs_MP = std(diffs_MP) / sqrt(length(diffs_MP));
stderror_diffs_WB = std(diffs_WB) / sqrt(length(diffs_WB));

diffs = 100*[mean_diffs_PM;mean_diffs_PS;mean_diffs_SM;mean_diffs_MP;...
    mean_diffs_MI;mean_diffs_WB;mean_diffs_AM];
stderrors_diffs = 100*[stderror_diffs_PM;stderror_diffs_PS;stderror_diffs_SM; ...
    stderror_diffs_MP;stderror_diffs_MI;stderror_diffs_WB;stderror_diffs_AM];

% Creating axes and the bar graph
ax = axes;
h = bar(diffs,'BarWidth',1/2);
xt={'PM';'PS';'SM';'MP';'MI';'WB';'AM'}; 
set(gca,'xtick',1:7); 
set(gca,'xticklabel',xt);
ylim([-50 50]);
h(1).FaceColor = 'yellow';

% Properties of the bar graph as required
ax.YGrid = 'on';
ax.GridLineStyle = '-';
% X and Y labels
xlabel('Mask Applied'); 
ylabel({'Mean Difference in Accuracy (%)'; ...
    '["go" trained - "imagine" trained]'}); 
set(gca,'FontSize',18)

% Finding the number of groups and the number of bars in each group
ngroups = size(diffs, 1);
nbars = size(diffs, 2);

% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));

% Set the position of each error bar in the centre of the main bar
hold on
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, diffs(:,i), stderrors_diffs(:,i), 'k', 'linestyle', 'none');
end

% add individual data points
hold on        
for i=1:length(diff_matrix)
    x1 = repmat(i,1,length(diff_matrix(i,:))); %the first bar axis location
    x1 = x1+(rand(size(x1))-0.5)*0.01; %add a little random "jitter" to aid visibility
    plot(x1,diff_matrix(i,:),'.k','MarkerSize', 15)
end

%% t tests

[~,p1] = ttest(diffs_MI,0); 
[~,p2] = ttest(diffs_SM,0); 
[~,p3] = ttest(diffs_AM,0); 
[~,p4] = ttest(diffs_PM,0); 
[~,p5] = ttest(diffs_PS,0); 
[~,p6] = ttest(diffs_MP,0); 
[~,p7] = ttest(diffs_WB,0); 
P_go_imag = [p1 p2 p3 p4 p5 p6 p7];
