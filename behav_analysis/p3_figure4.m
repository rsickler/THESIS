% PLOTS P4-P2 "original" ACCURACIES FOR IMAGERY GROUP AS FUNCTION OF [math acc] 

behav_analyzer;

% need 16 p4 - p2 improvements as function of 16 imagery ratings
diff_accuracy = 100*( difference_Ao_i +  difference_Bo_i) / 2; 


x = 100*overall_accs; 
y = diff_accuracy; 
scat = scatter(x,y);
correlation = corr(x(:), y(:)); 
R2 = correlation * correlation;

% Get the estimated values with polyval()
linearCoefficients = polyfit(x, y, 1);
xFit = linspace(0, 100);
yFit = polyval(linearCoefficients, xFit);

% Plot the fit
hold on;
text = ['Linear Regression (R^2 = ' num2str(R2) ')']; 
plot(xFit, yFit, 'b.-', 'MarkerSize', 10, 'LineWidth', 1);
legend('Individual Subjects', text, 'Location', 'Northwest');

%format figure

% X and Y labels
xlabel('Math Task Accuracy (%)');
ylabel({'Difference in Originals Accuracy (%)', '[P4-P2]'});
set(gca,'FontSize',18)

xlim([70 100]);
ylim([-20 100]);

x2 = [0 100];
y2 = [0 0];
line(x2,y2,'Color','red','LineStyle','--')
