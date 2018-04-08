% PLOTS P4-P2 "original" ACCURACIES FOR IMAGERY GROUP AS FUNCTION OF IMAGERY PERFORMANCE

behav_analyzer;

% need 16 p4 - p2 orignal improvements as function of 16 imagery ratings
diff_accuracy = 100*( difference_Ao_i +  difference_Bo_i) / 2; 


x = GPA; 
y = diff_accuracy; 
scat = scatter(x,y);
correlation = corr(x(:), y(:)); 
R2 = correlation * correlation;

% Get the estimated values with polyval()
linearCoefficients = polyfit(x, y, 1);
xFit = linspace(0, 3);
yFit = polyval(linearCoefficients, xFit);

% Plot the fit
hold on;
text = ['Linear Regression (R^2 = ' num2str(R2) ')']; 
plot(xFit, yFit, 'b.-', 'MarkerSize', 10, 'LineWidth', 1);
legend('Subjects', text, 'Location', 'Northwest');

%format figure

% X and Y labels
xlabel('Mean Imagery Rating Score');
ylabel('Mean Difference (P4-P2) in Originals Accuracy ');
xlim([0 3]);
ylim([-20 100]);

x2 = [0 3];
y2 = [0 0];
line(x2,y2,'Color','red','LineStyle','--')
